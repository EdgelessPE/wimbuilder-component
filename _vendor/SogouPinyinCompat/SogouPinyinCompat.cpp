#include <windows.h>
#include <tlhelp32.h>
#include <msctf.h>
#include <shellapi.h>

#include <cwchar>
#include <cstdio>
#include <string>

namespace {

constexpr wchar_t kIfeoKey[] =
    LR"(SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\kmenureg.exe)";
constexpr wchar_t kSogouTipKey[] =
    LR"(SOFTWARE\Microsoft\CTF\TIP\{E7EA138E-69F8-11D7-A6EA-00065B844310}\LanguageProfile\0x00000804\{E7EA138F-69F8-11D7-A6EA-00065B844311})";
constexpr wchar_t kSogouComKey[] =
    LR"(SOFTWARE\Classes\CLSID\{E7EA138E-69F8-11D7-A6EA-00065B844310})";
constexpr wchar_t kSogouTipFile[] = LR"(X:\Windows\System32\SogouTSF.ime)";
constexpr wchar_t kSogouImmKey[] =
    LR"(SYSTEM\CurrentControlSet\Control\Keyboard Layouts\E0200804)";
constexpr wchar_t kSogouImmKlid[] = L"E0200804";
constexpr DWORD kPollIntervalMs = 100;
constexpr DWORD kRegistrationStableMs = 1500;
constexpr DWORD kInstallerGoneStableMs = 2000;
constexpr DWORD kExplorerSettleMs = 3000;
constexpr DWORD kInstallerExitTimeoutMs = 15 * 60 * 1000;
constexpr DWORD kWatchTimeoutMs = 12 * 60 * 60 * 1000;
FILE* logFile = nullptr;

void logLine(const char* format, ...) {
    va_list args;
    va_start(args, format);
    if (logFile) {
        vfprintf(logFile, format, args);
        fflush(logFile);
    }
    va_end(args);
}

DWORD findProcess(const wchar_t* exactName, const wchar_t* prefix = nullptr,
                  DWORD excludedPid = 0) {
    DWORD found = 0;
    HANDLE snapshot = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    PROCESSENTRY32W entry{};
    entry.dwSize = sizeof(entry);
    if (snapshot != INVALID_HANDLE_VALUE && Process32FirstW(snapshot, &entry)) {
        do {
            bool matches = exactName && !_wcsicmp(entry.szExeFile, exactName);
            if (!matches && prefix) {
                matches = _wcsnicmp(entry.szExeFile, prefix, wcslen(prefix)) == 0;
            }
            if (matches && entry.th32ProcessID != excludedPid) {
                found = entry.th32ProcessID;
                break;
            }
        } while (Process32NextW(snapshot, &entry));
    }
    if (snapshot != INVALID_HANDLE_VALUE) CloseHandle(snapshot);
    return found;
}

bool terminateProcess(DWORD pid) {
    HANDLE process = OpenProcess(PROCESS_TERMINATE | SYNCHRONIZE, FALSE, pid);
    if (!process) return false;
    bool terminated = TerminateProcess(process, 0) != FALSE;
    if (terminated) WaitForSingleObject(process, 5000);
    CloseHandle(process);
    return terminated;
}

void terminateByName(const wchar_t* name) {
    while (DWORD pid = findProcess(name)) {
        if (!terminateProcess(pid)) break;
    }
}

struct SavedDebugger {
    REGSAM view{};
    bool keyExisted{};
    bool valueExisted{};
    DWORD type{};
    std::wstring value;
};

bool installDebugger(SavedDebugger& saved, const std::wstring& command) {
    HKEY key = nullptr;
    LONG opened = RegOpenKeyExW(HKEY_LOCAL_MACHINE, kIfeoKey, 0,
                                KEY_QUERY_VALUE | saved.view, &key);
    saved.keyExisted = opened == ERROR_SUCCESS;
    if (key) {
        DWORD bytes = 0;
        if (RegQueryValueExW(key, L"Debugger", nullptr, &saved.type, nullptr, &bytes)
                == ERROR_SUCCESS) {
            saved.valueExisted = true;
            saved.value.resize((bytes + sizeof(wchar_t) - 1) / sizeof(wchar_t));
            RegQueryValueExW(key, L"Debugger", nullptr, &saved.type,
                             reinterpret_cast<BYTE*>(saved.value.data()), &bytes);
            while (!saved.value.empty() && saved.value.back() == L'\0') {
                saved.value.pop_back();
            }
        }
        RegCloseKey(key);
    }

    DWORD disposition = 0;
    if (RegCreateKeyExW(HKEY_LOCAL_MACHINE, kIfeoKey, 0, nullptr, 0,
                        KEY_SET_VALUE | saved.view, nullptr, &key, &disposition)
            != ERROR_SUCCESS) {
        return false;
    }
    LONG result = RegSetValueExW(key, L"Debugger", 0, REG_SZ,
        reinterpret_cast<const BYTE*>(command.c_str()),
        static_cast<DWORD>((command.size() + 1) * sizeof(wchar_t)));
    RegCloseKey(key);
    return result == ERROR_SUCCESS;
}

void restoreDebugger(const SavedDebugger& saved) {
    HKEY key = nullptr;
    if (RegOpenKeyExW(HKEY_LOCAL_MACHINE, kIfeoKey, 0, KEY_SET_VALUE | saved.view, &key)
            != ERROR_SUCCESS) {
        return;
    }
    if (saved.valueExisted) {
        RegSetValueExW(key, L"Debugger", 0, saved.type,
            reinterpret_cast<const BYTE*>(saved.value.c_str()),
            static_cast<DWORD>((saved.value.size() + 1) * sizeof(wchar_t)));
    } else {
        RegDeleteValueW(key, L"Debugger");
    }
    RegCloseKey(key);
    if (!saved.keyExisted) {
        RegDeleteKeyExW(HKEY_LOCAL_MACHINE, kIfeoKey, saved.view, 0);
    }
}

bool keyExists(const wchar_t* path, REGSAM view = 0) {
    HKEY key = nullptr;
    LONG result = RegOpenKeyExW(HKEY_LOCAL_MACHINE, path, 0, KEY_READ | view, &key);
    if (key) RegCloseKey(key);
    return result == ERROR_SUCCESS;
}

bool coreInstalled() {
    return (keyExists(kSogouTipKey, KEY_WOW64_64KEY)
            || keyExists(kSogouTipKey, KEY_WOW64_32KEY))
        && (keyExists(kSogouComKey, KEY_WOW64_64KEY)
            || keyExists(kSogouComKey, KEY_WOW64_32KEY))
        && GetFileAttributesW(kSogouTipFile) != INVALID_FILE_ATTRIBUTES;
}

bool enableSogou() {
    const CLSID clsid = {0xE7EA138E, 0x69F8, 0x11D7,
        {0xA6, 0xEA, 0x00, 0x06, 0x5B, 0x84, 0x43, 0x10}};
    const GUID profile = {0xE7EA138F, 0x69F8, 0x11D7,
        {0xA6, 0xEA, 0x00, 0x06, 0x5B, 0x84, 0x43, 0x11}};
    HRESULT initialized = CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);
    ITfInputProcessorProfiles* profiles = nullptr;
    HRESULT created = CoCreateInstance(
        CLSID_TF_InputProcessorProfiles, nullptr, CLSCTX_INPROC_SERVER,
        IID_ITfInputProcessorProfiles, reinterpret_cast<void**>(&profiles));
    HRESULT enabled = FAILED(created) ? created
        : profiles->EnableLanguageProfile(clsid, 0x0804, profile, TRUE);
    if (profiles) profiles->Release();
    if (SUCCEEDED(initialized)) CoUninitialize();
    return SUCCEEDED(enabled);
}

bool setStringValue(HKEY key, const wchar_t* name, const wchar_t* value) {
    return RegSetValueExW(
        key, name, 0, REG_SZ, reinterpret_cast<const BYTE*>(value),
        static_cast<DWORD>((wcslen(value) + 1) * sizeof(wchar_t))) == ERROR_SUCCESS;
}

bool registerImmLayout() {
    HKEY key = nullptr;
    DWORD disposition = 0;
    LONG created = RegCreateKeyExW(
        HKEY_LOCAL_MACHINE, kSogouImmKey, 0, nullptr, 0,
        KEY_QUERY_VALUE | KEY_SET_VALUE | KEY_WOW64_64KEY, nullptr, &key, &disposition);
    if (created != ERROR_SUCCESS) {
        logLine("IMM layout key creation failed error=%ld\n", created);
        return false;
    }

    // These are the complete values produced by the known-working Sogou 6.5
    // WinPE installer. Pointing the same IMM layout at 16.4's installed core
    // avoids the TSF activation failure in a SYSTEM WinPE desktop.
    bool imeFile = setStringValue(key, L"Ime File", L"SogouPY.ime");
    bool layoutText = setStringValue(
        key, L"Layout Text",
        L"\u4e2d\u6587(\u7b80\u4f53) - \u641c\u72d7\u8f93\u5165\u6cd5\u62fc\u97f3");
    bool layoutFile = setStringValue(key, L"Layout File", L"kbdus.dll");
    RegCloseKey(key);
    logLine("IMM layout registered disposition=%lu ime=%d text=%d layout=%d\n",
            disposition, imeFile, layoutText, layoutFile);
    return imeFile && layoutText && layoutFile;
}

bool activateImmLayout() {
    HKL layout = LoadKeyboardLayoutW(
        kSogouImmKlid, KLF_ACTIVATE | KLF_REORDER | KLF_SETFORPROCESS);
    if (!layout) {
        logLine("IMM layout load failed error=%lu\n", GetLastError());
        return false;
    }

    HKL activated = ActivateKeyboardLayout(
        layout, KLF_REORDER | KLF_SETFORPROCESS);
    BOOL madeDefault = SystemParametersInfoW(
        SPI_SETDEFAULTINPUTLANG, 0, &layout, SPIF_SENDCHANGE);
    BOOL notified = PostMessageW(
        HWND_BROADCAST, WM_INPUTLANGCHANGEREQUEST, INPUTLANGCHANGE_SYSCHARSET,
        reinterpret_cast<LPARAM>(layout));
    logLine("IMM layout activated hkl=%p active=%p default=%d notified=%d error=%lu\n",
            layout, activated, madeDefault, notified, GetLastError());
    return activated != nullptr && madeDefault != FALSE && notified != FALSE;
}

bool launchCtfmon(DWORD explorerPid) {
    HANDLE process = OpenProcess(PROCESS_QUERY_LIMITED_INFORMATION, FALSE, explorerPid);
    HANDLE token = nullptr;
    HANDLE primaryToken = nullptr;
    if (!process
        || !OpenProcessToken(process, TOKEN_QUERY | TOKEN_DUPLICATE | TOKEN_ASSIGN_PRIMARY, &token)
        || !DuplicateTokenEx(token, TOKEN_ALL_ACCESS, nullptr,
                             SecurityImpersonation, TokenPrimary, &primaryToken)) {
        if (token) CloseHandle(token);
        if (process) CloseHandle(process);
        return false;
    }
    wchar_t command[] = LR"(X:\Windows\System32\ctfmon.exe)";
    STARTUPINFOW startup{};
    startup.cb = sizeof(startup);
    startup.lpDesktop = const_cast<wchar_t*>(LR"(winsta0\default)");
    PROCESS_INFORMATION info{};
    BOOL created = CreateProcessAsUserW(primaryToken, nullptr, command, nullptr, nullptr, FALSE,
                                        CREATE_UNICODE_ENVIRONMENT, nullptr, nullptr, &startup, &info);
    if (created) { CloseHandle(info.hThread); CloseHandle(info.hProcess); }
    CloseHandle(primaryToken);
    CloseHandle(token);
    CloseHandle(process);
    return created != FALSE;
}

bool refreshInputSession() {
    DWORD oldExplorer = findProcess(L"explorer.exe");
    terminateByName(L"ctfmon.exe");
    terminateByName(L"explorer.exe");
    DWORD newExplorer = 0;
    for (int attempt = 0; attempt < 200 && !newExplorer; ++attempt) {
        Sleep(100);
        newExplorer = findProcess(L"explorer.exe", nullptr, oldExplorer);
    }
    if (!newExplorer) {
        logLine("Explorer did not restart\n");
        return false;
    }
    Sleep(kExplorerSettleMs);
    bool launched = launchCtfmon(newExplorer);
    for (int attempt = 0; launched && attempt < 50 && !findProcess(L"ctfmon.exe"); ++attempt) {
        Sleep(100);
    }
    logLine("Input session refreshed explorer=%lu ctfmonLaunched=%d ctfmon=%lu\n",
            newExplorer, launched, findProcess(L"ctfmon.exe"));
    Sleep(500);
    return activateImmLayout();
}

bool installerRunning() {
    return findProcess(nullptr, L"sogou_pinyin_") != 0
        || findProcess(L"sogou-setup.exe") != 0;
}

bool waitForAllInstallers(DWORD timeoutMs) {
    ULONGLONG started = GetTickCount64();
    ULONGLONG goneSince = 0;
    while (GetTickCount64() - started < timeoutMs) {
        if (!installerRunning()) {
            if (!goneSince) goneSince = GetTickCount64();
            if (GetTickCount64() - goneSince >= kInstallerGoneStableMs) return true;
        } else {
            goneSince = 0;
        }
        Sleep(kPollIntervalMs);
    }
    return false;
}

}  // namespace

int WINAPI wWinMain(HINSTANCE, HINSTANCE, PWSTR, int) {
    int argc = 0;
    wchar_t** argv = CommandLineToArgvW(GetCommandLineW(), &argc);
    bool stubMode = argc > 1 && !_wcsicmp(argv[1], L"--kmenureg-stub");
    if (argv) LocalFree(argv);
    if (stubMode) return 0;

    HANDLE singleton = CreateMutexW(nullptr, TRUE, LR"(Local\EdgelessSogouPinyinCompat)");
    if (!singleton || GetLastError() == ERROR_ALREADY_EXISTS) {
        if (singleton) CloseHandle(singleton);
        return 0;
    }
    _wfopen_s(&logFile, LR"(X:\Users\SogouPinyinCompat.log)", L"w");
    wchar_t executable[MAX_PATH]{};
    GetModuleFileNameW(nullptr, executable, MAX_PATH);
    std::wstring debugger = L"\"" + std::wstring(executable) + L"\" --kmenureg-stub";
    SavedDebugger debugger64{KEY_WOW64_64KEY};
    SavedDebugger debugger32{KEY_WOW64_32KEY};
    bool installed64 = installDebugger(debugger64, debugger);
    bool installed32 = installDebugger(debugger32, debugger);
    logLine("IFEO installed 64=%d 32=%d\n", installed64, installed32);

    ULONGLONG started = GetTickCount64();
    DWORD installerPid = 0;
    while (GetTickCount64() - started < kWatchTimeoutMs && !installerPid) {
        installerPid = findProcess(nullptr, L"sogou_pinyin_");
        if (!installerPid) installerPid = findProcess(L"sogou-setup.exe");
        if (!installerPid) Sleep(kPollIntervalMs);
    }
    logLine("Installer PID=%lu elapsed=%llu\n", installerPid, GetTickCount64() - started);

    bool exited = installerPid && waitForAllInstallers(kInstallerExitTimeoutMs);
    if (installed32) restoreDebugger(debugger32);
    if (installed64) restoreDebugger(debugger64);
    logLine("Installer exited=%d core=%d elapsed=%llu\n", exited, coreInstalled(),
            GetTickCount64() - started);

    ULONGLONG stableSince = 0;
    for (int attempt = 0; exited && attempt < 100; ++attempt) {
        if (coreInstalled()) {
            if (!stableSince) stableSince = GetTickCount64();
            if (GetTickCount64() - stableSince >= kRegistrationStableMs) break;
        } else {
            stableSince = 0;
        }
        Sleep(kPollIntervalMs);
    }
    bool installed = exited && coreInstalled();
    bool tsfEnabled = installed && enableSogou();
    bool immRegistered = installed && registerImmLayout();
    bool immActivated = immRegistered && refreshInputSession();
    bool completed = installed && immRegistered && immActivated;
    logLine("Completed installed=%d tsfEnabled=%d immRegistered=%d immActivated=%d total=%llu\n",
            installed, tsfEnabled, immRegistered, immActivated, GetTickCount64() - started);
    if (logFile) fclose(logFile);
    ReleaseMutex(singleton);
    CloseHandle(singleton);
    return completed ? 0 : 2;
}
