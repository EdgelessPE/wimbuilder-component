#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <objbase.h>
#include <shellapi.h>
#include <shobjidl.h>

namespace {
constexpr DWORD kBufferSize = 32768;

DWORD stringLength(const wchar_t* value) {
    DWORD length = 0;
    while (value[length] != L'\0') {
        ++length;
    }
    return length;
}

bool stringsEqualIgnoreCase(const wchar_t* left, const wchar_t* right) {
    const int leftLength = static_cast<int>(stringLength(left));
    const int rightLength = static_cast<int>(stringLength(right));
    return leftLength == rightLength
        && CompareStringOrdinal(
            left,
            leftLength,
            right,
            rightLength,
            TRUE
        ) == CSTR_EQUAL;
}

bool endsWithArgument(const wchar_t* arguments, const wchar_t* argument) {
    const DWORD argumentsLength = stringLength(arguments);
    const DWORD argumentLength = stringLength(argument);
    if (argumentLength > argumentsLength) {
        return false;
    }

    const DWORD offset = argumentsLength - argumentLength;
    for (DWORD index = 0; index < argumentLength; ++index) {
        if (arguments[offset + index] != argument[index]) {
            return false;
        }
    }
    return offset == 0 || arguments[offset - 1] == L' ';
}

bool appendArgument(wchar_t* arguments, const wchar_t* argument) {
    DWORD outputIndex = stringLength(arguments);
    const DWORD argumentLength = stringLength(argument);
    const DWORD separatorLength = outputIndex == 0 ? 0 : 1;
    if (outputIndex + separatorLength + argumentLength >= kBufferSize) {
        return false;
    }

    if (separatorLength != 0) {
        arguments[outputIndex++] = L' ';
    }
    for (DWORD index = 0; index < argumentLength; ++index) {
        arguments[outputIndex++] = argument[index];
    }
    arguments[outputIndex] = L'\0';
    return true;
}

bool readTextFile(const wchar_t* path, wchar_t* value) {
    HANDLE file = CreateFileW(
        path,
        GENERIC_READ,
        FILE_SHARE_READ,
        nullptr,
        OPEN_EXISTING,
        FILE_ATTRIBUTE_NORMAL,
        nullptr
    );
    if (file == INVALID_HANDLE_VALUE) {
        return false;
    }

    char* const buffer = static_cast<char*>(
        HeapAlloc(GetProcessHeap(), 0, kBufferSize)
    );
    if (buffer == nullptr) {
        CloseHandle(file);
        return false;
    }

    DWORD size = 0;
    const bool read = ReadFile(file, buffer, kBufferSize - 1, &size, nullptr) != 0;
    const bool complete = read && GetFileSize(file, nullptr) == size;
    CloseHandle(file);
    if (!complete) {
        HeapFree(GetProcessHeap(), 0, buffer);
        return false;
    }

    while (size > 0 && (buffer[size - 1] == '\r' || buffer[size - 1] == '\n')) {
        --size;
    }
    buffer[size] = '\0';
    const bool converted = MultiByteToWideChar(
        CP_ACP,
        0,
        buffer,
        -1,
        value,
        static_cast<int>(kBufferSize)
    ) > 0;
    HeapFree(GetProcessHeap(), 0, buffer);
    return converted;
}

bool writeLuaString(const wchar_t* path, const wchar_t* value) {
    wchar_t* const escaped = static_cast<wchar_t*>(HeapAlloc(
        GetProcessHeap(),
        0,
        kBufferSize * 2 * sizeof(wchar_t)
    ));
    if (escaped == nullptr) {
        return false;
    }

    DWORD outputIndex = 0;
    for (DWORD inputIndex = 0; value[inputIndex] != L'\0'; ++inputIndex) {
        const wchar_t character = value[inputIndex];
        if (character == L'\\' || character == L'\'') {
            if (outputIndex + 2 >= kBufferSize * 2) {
                HeapFree(GetProcessHeap(), 0, escaped);
                return false;
            }
            escaped[outputIndex++] = L'\\';
        } else if (outputIndex + 1 >= kBufferSize * 2) {
            HeapFree(GetProcessHeap(), 0, escaped);
            return false;
        }
        escaped[outputIndex++] = character;
    }
    escaped[outputIndex] = L'\0';

    const int byteCount = WideCharToMultiByte(
        CP_ACP,
        0,
        escaped,
        -1,
        nullptr,
        0,
        nullptr,
        nullptr
    );
    char* const bytes = byteCount > 0
        ? static_cast<char*>(HeapAlloc(GetProcessHeap(), 0, byteCount))
        : nullptr;
    const bool converted = bytes != nullptr && WideCharToMultiByte(
        CP_ACP,
        0,
        escaped,
        -1,
        bytes,
        byteCount,
        nullptr,
        nullptr
    ) == byteCount;
    HeapFree(GetProcessHeap(), 0, escaped);
    if (!converted) {
        if (bytes != nullptr) {
            HeapFree(GetProcessHeap(), 0, bytes);
        }
        return false;
    }

    HANDLE file = CreateFileW(
        path,
        GENERIC_WRITE,
        0,
        nullptr,
        CREATE_ALWAYS,
        FILE_ATTRIBUTE_NORMAL,
        nullptr
    );
    if (file == INVALID_HANDLE_VALUE) {
        HeapFree(GetProcessHeap(), 0, bytes);
        return false;
    }

    DWORD written = 0;
    const DWORD contentSize = static_cast<DWORD>(byteCount - 1);
    const bool success = WriteFile(file, bytes, contentSize, &written, nullptr) != 0
        && written == contentSize;
    CloseHandle(file);
    HeapFree(GetProcessHeap(), 0, bytes);
    return success;
}
} // namespace

extern "C" void wWinMainCRTStartup() {
    int exitCode = 2;
    int argc = 0;
    wchar_t** const argv = CommandLineToArgvW(GetCommandLineW(), &argc);
    if (argv == nullptr || argc != 5) {
        ExitProcess(exitCode);
    }

    const HRESULT initializeResult = CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);
    if (FAILED(initializeResult)) {
        LocalFree(argv);
        ExitProcess(3);
    }

    IShellLinkW* shellLink = nullptr;
    HRESULT result = CoCreateInstance(
        CLSID_ShellLink,
        nullptr,
        CLSCTX_INPROC_SERVER,
        IID_IShellLinkW,
        reinterpret_cast<void**>(&shellLink)
    );
    if (FAILED(result)) {
        CoUninitialize();
        LocalFree(argv);
        ExitProcess(4);
    }

    IPersistFile* persistFile = nullptr;
    result = shellLink->QueryInterface(
        IID_IPersistFile,
        reinterpret_cast<void**>(&persistFile)
    );
    if (FAILED(result)) {
        shellLink->Release();
        CoUninitialize();
        LocalFree(argv);
        ExitProcess(5);
    }

    result = persistFile->Load(argv[1], STGM_READWRITE);
    wchar_t* const target = static_cast<wchar_t*>(HeapAlloc(
        GetProcessHeap(),
        HEAP_ZERO_MEMORY,
        kBufferSize * sizeof(wchar_t)
    ));
    wchar_t* const arguments = static_cast<wchar_t*>(HeapAlloc(
        GetProcessHeap(),
        HEAP_ZERO_MEMORY,
        kBufferSize * sizeof(wchar_t)
    ));
    wchar_t* const appendedArgument = static_cast<wchar_t*>(HeapAlloc(
        GetProcessHeap(),
        HEAP_ZERO_MEMORY,
        kBufferSize * sizeof(wchar_t)
    ));

    bool success = SUCCEEDED(result)
        && target != nullptr
        && arguments != nullptr
        && appendedArgument != nullptr
        && SUCCEEDED(shellLink->GetPath(target, kBufferSize, nullptr, SLGP_RAWPATH))
        && target[0] != L'\0'
        && SUCCEEDED(shellLink->GetArguments(arguments, kBufferSize))
        && readTextFile(argv[4], appendedArgument);

    bool changed = false;
    if (
        success
        && appendedArgument[0] != L'\0'
        && !stringsEqualIgnoreCase(appendedArgument, L"Disable")
        && !endsWithArgument(arguments, appendedArgument)
    ) {
        success = appendArgument(arguments, appendedArgument);
        changed = success;
    }
    success = success
        && writeLuaString(argv[2], target)
        && writeLuaString(argv[3], arguments)
        && (!changed || (
            SUCCEEDED(shellLink->SetArguments(arguments))
            && SUCCEEDED(persistFile->Save(argv[1], TRUE))
        ));
    exitCode = success ? 0 : 7;

    if (appendedArgument != nullptr) {
        HeapFree(GetProcessHeap(), 0, appendedArgument);
    }
    if (arguments != nullptr) {
        HeapFree(GetProcessHeap(), 0, arguments);
    }
    if (target != nullptr) {
        HeapFree(GetProcessHeap(), 0, target);
    }
    persistFile->Release();
    shellLink->Release();
    CoUninitialize();
    LocalFree(argv);
    ExitProcess(exitCode);
}
