import type {
    CheckboxForm,
    FormCommand,
    FormCommands,
    FormPage,
} from './type.ts';

const batch = (
    content: string | string[],
    options: Omit<FormCommand, 'command'> = {},
): FormCommand => ({
    ...options,
    command: () => content,
});

const runWcsScript = (name: string): string => `%append1%${name}.wcs%append2%`;

const checkbox = (
    key: string,
    label: string,
    command: FormCommands,
    options: Pick<CheckboxForm, 'htmlCommented'> = {},
): CheckboxForm => ({
    ...options,
    type: 'checkbox',
    key,
    label,
    checked: false,
    command,
});

const slimCommand = batch([
    'call .\\_vendor\\FirPE\\FirPE_Slim.cmd %x% %opt[Edgeless.Slim]%',
    'title Edgeless Patch Running...',
]);

export const pages: FormPage[] = [
    {
        page: 'Slim',
        patchName: '精简',
        batchTitle: '调用精简脚本',
        groups: [
            {
                type: 'group',
                label: 'FirPE精简',
                children: [
                    {
                        type: 'radio',
                        key: 'Slim',
                        label: 'FirPE精简',
                        defaultValue: '0',
                        options: [
                            { label: '不精简', value: '0' },
                            {
                                label: '安全精简',
                                value: '1',
                                command: slimCommand,
                            },
                            {
                                label: '普通精简',
                                value: '2',
                                command: slimCommand,
                            },
                        ],
                    },
                ],
            },
        ],
    },
    {
        page: 'Driver',
        title: '驱动',
        batchTitle: '安装驱动',
        groups: [
            {
                type: 'group',
                children: [
                    checkbox('drv_disk', '磁盘驱动', batch([
                        'echo Installing Disk Drivers...',
                        'dism /image:"%X%" /Add-Driver /Driver:.\\_vendor\\Drv_Disk /Recurse',
                    ])),
                ],
            },
        ],
    },
    {
        page: '',
        batchTitle: 'main配置',
        groups: [
            {
                type: 'group',
                label: 'Edgeless特性',
                children: [
                    checkbox('main_pecmd', '替换pecmd.ini（和Launcher.bat）', batch([
                        'copy /y .\\_vendor\\Files_pecmd\\Pecmd.ini "%x%\\Windows\\System32\\"',
                        'copy /y .\\_vendor\\Files_pecmd\\OnShutdown.wcs "%x%\\Windows\\System32\\"',
                        '@REM copy /y .\\_vendor\\Files_pecmd\\Launcher.bat "%x%\\Program Files\\"',
                        'copy /y .\\_vendor\\Files_pecmd\\_Config.wcs "%x%\\Program Files\\Edgeless\\system_hooks\\onDesktopShown\\_Config.wcs"',
                    ])),
                    {
                        type: 'group',
                        label: '版权',
                        children: [
                            checkbox('main_oem', '写入OEM信息', batch([
                                runWcsScript('main_oem'),
                                'type .\\_commands\\main_oem.wcs>>"%x%\\Program Files\\Edgeless\\system_hooks\\onDesktopShown\\_Preset.wcs"',
                            ])),
                            checkbox('main_version', '配置version.txt', batch(
                                'copy /y .\\_config\\version.txt "%x%\\Program Files\\"',
                            )),
                            checkbox('main_wp', '设置默认壁纸和头像', batch([
                                'copy /y .\\_vendor\\Files\\user-200.png "%x%\\ProgramData\\Microsoft\\User Account Pictures\\"',
                                'del /f /q "%x%\\ProgramData\\Microsoft\\User Account Pictures\\*.accountpicture-ms"',
                                'reg delete HKLM\\Tmp_Software\\Microsoft\\Windows\\CurrentVersion\\PropertySystem\\PropertyHandlers\\.accountpicture-ms /va /f',
                                'reg delete HKLM\\Tmp_Default\\Software\\Microsoft\\Windows\\CurrentVersion\\AccountPicture /v SourceId /f',
                                '',
                                'copy /y .\\_vendor\\Files\\img0.jpg "%x%\\Windows\\Web\\Wallpaper\\Windows\\"',
                                'set "opt[shell.wallpaper]=%cd%\\_vendor\\Files\\img0.jpg"',
                            ])),
                            checkbox('main_checkUpdate', '检查更新', batch([
                                'del /f /q %x%\\Windows\\SystemResources\\systemcpl.dll.mun',
                                'copy /y .\\_vendor\\Bin_Update\\systemcpl.dll.mun %x%\\Windows\\SystemResources\\systemcpl.dll.mun',
                            ])),
                            checkbox('main_activate', '激活PE', batch([
                                'del /f /q %x%\\Windows\\System32\\zh-CN\\systemcpl.dll.mui',
                                'copy /y .\\_vendor\\Bin_Activate\\systemcpl.dll.mui %x%\\Windows\\System32\\zh-CN\\systemcpl.dll.mui',
                            ])),
                            checkbox('main_pinBrowsers', '固定浏览器到任务栏', batch(
                                'type .\\_commands\\main_pinBrowsers.wcs>>"%x%\\Program Files\\Edgeless\\system_hooks\\onDesktopShown\\_Preset.wcs"',
                            )),
                        ],
                    },
                    {
                        type: 'group',
                        label: '资源管理器',
                        children: [
                            {
                                type: 'input',
                                key: 'main_desktopIconSize',
                                label: '桌面图标大小',
                                defaultValue: '48',
                                command: batch(
                                    'reg add "HKLM\\Tmp_Software\\Microsoft\\Windows\\Shell\\Bags\\1\\Desktop" /f /v "IconSize" /t REG_DWORD /d %opt[Edgeless.main_desktopIconSize]%',
                                ),
                            },
                            checkbox('main_explorerRibbon', '收起资源管理器功能区', batch(
                                runWcsScript('main_explorerRibbon'),
                            )),
                            checkbox('main_displayHiddenFiles', '显示隐藏文件（系统级除外）', batch(
                                runWcsScript('main_displayHiddenFiles'),
                                { stage: 'last' },
                            )),
                            checkbox('main_rightClickMenu', '清理右键菜单', batch(
                                'type .\\_commands\\main_rightClickMenu.wcs>>"%x%\\Program Files\\Edgeless\\system_hooks\\onDesktopShown\\_Preset.wcs"',
                            )),
                            checkbox('main_fixManage', '修复此电脑右键菜单管理', batch(
                                'type .\\_commands\\main_fixManage.wcs>>"%x%\\Program Files\\Edgeless\\system_hooks\\onDesktopShown\\_Preset.wcs"',
                            )),
                            checkbox('main_dpi', 'DPI自适应', batch(runWcsScript('main_dpi'))),
                        ],
                    },
                    {
                        type: 'group',
                        label: '第三方软件配置',
                        children: [
                            checkbox('main_7zPolish', '7-Zip优化', batch(runWcsScript('main_7zPolish'))),
                            checkbox('main_initStartIsBack', '自定义StartIsBack样式', batch([
                                '@REM del /f /s /q "%x%\\Program Files\\StartIsBack"',
                                '@REM rd /s /q "%x%\\Program Files\\StartIsBack"',
                                '@REM xcopy /s /r /y .\\_vendor\\Soft_SIB\\* "%x%\\Program Files\\"',
                                'type .\\_commands\\main_initStartIsBack.wcs>>"%x%\\Program Files\\Edgeless\\system_hooks\\beforeLocalBoost\\_Preset.wcs"',
                            ])),
                        ],
                    },
                    checkbox('main_cleanCursors', '清理光标组件', batch(runWcsScript('main_cleanCursors'))),
                    checkbox('main_orderdrv', '整理盘符', batch(
                        'xcopy /s /r /y .\\_vendor\\File_OrderDrv\\* "%x%\\Windows\\System32\\"',
                    )),
                    checkbox('main_emoji', '添加emoji字体', batch(
                        '  call AddFiles \\Windows\\fonts\\seguiemj.ttf',
                    )),
                ],
            },
            {
                type: 'group',
                label: '文件类型关联',
                children: [
                    checkbox('main_enhancedType', '增强类型（启动后重导入至HKCU）', batch(
                        'type .\\_commands\\main_enhancedType.wcs>>"%x%\\Program Files\\Edgeless\\system_hooks\\onDiskFound\\_Preset.wcs"',
                    )),
                    checkbox('main_wcs', '.wcs（含xcmd）', batch([
                        'copy /y .\\_vendor\\Exec_Xcmd\\xcmd.exe %x%\\Windows\\System32\\xcmd.exe',
                        runWcsScript('main_wcs'),
                    ])),
                    checkbox('main_7z', '.7z右键加载', batch(runWcsScript('main_7z'))),
                    checkbox('main_7zf', '.7zf', batch(runWcsScript('main_7zf'))),
                    checkbox('main_7zl', '.7zl', batch(runWcsScript('main_7zl'))),
                    checkbox('main_eth', '主题包/资源包(.eth .eis .els .ems .esc .ess)', batch(runWcsScript('main_eth'))),
                    checkbox('main_iso', '智能虚拟光驱', batch([
                        'md "%x%\\Users\\Imdisk"',
                        'xcopy /s /r /y "%workshop%\\Users\\Imdisk\\*" "%x%\\Users\\Imdisk\\"',
                        'type .\\_commands\\main_iso_removeImdiskMenu.wcs>>"%x%\\Program Files\\Edgeless\\system_hooks\\onBootFinished\\_Preset.wcs"',
                        runWcsScript('main_iso'),
                    ])),
                    checkbox('main_explainPartialTypes', '解释部分类型文件', batch(
                        'type .\\_commands\\main_explainPartialTypes.wcs>>"%x%\\Program Files\\Edgeless\\system_hooks\\onDesktopShown\\_Preset.wcs"',
                    )),
                    checkbox('main_explainOpenWithNotepad', '添加Open with Notepad', batch(
                        'type .\\_commands\\main_explainOpenWithNotepad.wcs>>"%x%\\Program Files\\Edgeless\\system_hooks\\onBootFinished\\_Preset.wcs"',
                    )),
                ],
            },
        ],
    },
    {
        page: 'Apple',
        groups: [
            {
                type: 'group',
                children: [
                    checkbox('apple', 'HFS和MNT支持', batch([
                        runWcsScript('apple'),
                        'xcopy /s /r /y .\\_vendor\\Lib_Apple\\* "%x%\\Windows\\System32\\drivers\\"',
                    ])),
                ],
            },
        ],
    },
    {
        page: 'Files',
        patchName: '文件',
        batchTitle: 'File',
        groups: [
            {
                type: 'group',
                label: 'Edgeless组件',
                children: [
                    checkbox('file_system32', '补充System32', batch([
                        'xcopy /s /r /y .\\_vendor\\File_System32\\* "%x%\\Windows\\System32\\"',
                        'call AddFiles \\Windows\\System32\\msvc*.dll',
                        'call AddFiles \\windows\\System32\\mfc40.dll',
                        'call AddFiles \\windows\\System32\\mfc40u.dll',
                        'call AddFiles \\windows\\System32\\mfc42.dll',
                        'call AddFiles \\windows\\System32\\mfc42u.dll',
                        'call AddFiles \\windows\\System32\\mfcore.dll',
                        'call AddFiles \\Windows\\System32\\vcruntime*.dll',
                        'call AddFiles \\Windows\\System32\\vcomp*.dll',
                        'call AddFiles \\Windows\\System32\\atl*.dll',
                        'call AddFiles \\Windows\\System32\\Drivers\\fbwf.sys',
                        'call AddFiles \\Windows\\System32\\fontsub.dll',
                        'call AddFiles \\Windows\\System32\\dxva2.dll',
                        'call AddFiles \\Windows\\System32\\opengl32.dll',
                        'call AddFiles \\Windows\\System32\\glu32.dll',
                        'call AddFiles \\Windows\\System32\\httpapi.dll',
                        'call AddFiles \\Windows\\System32\\d3d8.dll',
                        'call AddFiles \\Windows\\System32\\d3d8thk.dll',
                        'call AddFiles \\Windows\\System32\\d3d9.dll',
                        'call AddFiles \\Windows\\System32\\d3d10.dll',
                        'call AddFiles \\Windows\\System32\\d3d10_1.dll',
                        'call AddFiles \\Windows\\System32\\d3d10_1core.dll',
                        'call AddFiles \\Windows\\System32\\d3d10core.dll',
                        'call AddFiles \\Windows\\System32\\d3d10level9.dll',
                        'call AddFiles \\Windows\\System32\\d3d10warp.dll',
                        'call AddFiles \\Windows\\System32\\d3d11.dll',
                        'call AddFiles \\Windows\\System32\\d3d11on12.dll',
                        'call AddFiles \\Windows\\System32\\d3d12.dll',
                        'call AddFiles \\Windows\\System32\\d3dcompiler_47.dll',
                        'call AddFiles \\Windows\\System32\\mfc140d.dll',
                        'call AddFiles \\Windows\\System32\\mfc140ud.dll',
                        'call AddFiles \\Windows\\System32\\mfc140.dll',
                        'call AddFiles \\Windows\\System32\\mfc140u.dll',
                        'call AddFiles \\Windows\\System32\\mfc140enu.dll',
                        'call AddFiles \\Windows\\System32\\mfc140chs.dll',
                    ])),
                    checkbox('file_syswow64', '补充SysWOW64', batch([
                        'xcopy /s /r /y .\\_vendor\\Lib_SysWOW64\\* "%x%\\Windows\\SysWOW64\\"',
                        'call AddFiles \\Windows\\SysWOW64\\msvb*.dll',
                        'call AddFiles \\Windows\\SysWOW64\\msvc*.dll',
                        'call AddFiles \\Windows\\SysWOW64\\msvcp140_1.dll',
                        'call AddFiles \\windows\\SysWOW64\\mfc40.dll',
                        'call AddFiles \\windows\\SysWOW64\\mfc40u.dll',
                        'call AddFiles \\windows\\SysWOW64\\mfc42.dll',
                        'call AddFiles \\windows\\SysWOW64\\mfc42u.dll',
                        'call AddFiles \\windows\\SysWOW64\\mfcore.dll',
                        'call AddFiles \\Windows\\SysWOW64\\atl*.dll',
                        'call AddFiles \\Windows\\SysWOW64\\vcruntime*.dll',
                        'call AddFiles \\Windows\\SysWOW64\\vcomp*.dll',
                        'call AddFiles @windows\\SysWOW64\\msvf*.dll',
                        'call AddFiles @windows\\SysWOW64\\msvidc*.dll',
                        'call AddFiles \\Windows\\SysWOW64\\fontsub.dll',
                        'call AddFiles \\Windows\\SysWOW64\\dxva2.dll',
                        'call AddFiles \\Windows\\SysWOW64\\opengl32.dll',
                        'call AddFiles \\Windows\\SysWOW64\\glu32.dll',
                        'call AddFiles \\Windows\\SysWOW64\\httpapi.dll',
                        'call AddFiles \\windows\\SysWOW64\\d3d8.dll',
                        'call AddFiles \\windows\\SysWOW64\\d3d8thk.dll',
                        'call AddFiles \\windows\\SysWOW64\\d3d9.dll',
                        'call AddFiles \\windows\\SysWOW64\\d3d10.dll',
                        'call AddFiles \\windows\\SysWOW64\\d3d10_1.dll',
                        'call AddFiles \\windows\\SysWOW64\\d3d10warp.dll',
                        'call AddFiles \\windows\\SysWOW64\\d3d10core.dll',
                        'call AddFiles \\windows\\SysWOW64\\d3d10level9.dll',
                        'call AddFiles \\windows\\SysWOW64\\d3d10_1core.dll',
                        'call AddFiles \\windows\\SysWOW64\\d3d11.dll',
                        'call AddFiles \\windows\\SysWOW64\\d3d12.dll',
                        'call AddFiles \\windows\\SysWOW64\\d3dcompiler_47.dll',
                        'call AddFiles \\windows\\SysWOW64\\d3d11on12.dll',
                        'call AddFiles \\windows\\SysWOW64\\hhctrl.dll',
                        'call AddFiles \\Windows\\SysWOW64\\mfc140d.dll',
                        'call AddFiles \\Windows\\SysWOW64\\mfc140ud.dll',
                        'call AddFiles \\Windows\\SysWOW64\\mfc140.dll',
                        'call AddFiles \\Windows\\SysWOW64\\mfc140u.dll',
                        'call AddFiles \\Windows\\SysWOW64\\mfc140enu.dll',
                        'call AddFiles \\Windows\\SysWOW64\\mfc140chs.dll',
                        'call AddFiles \\Windows\\SysWOW64\\cryptui.dll',
                        'call AddFiles \\Windows\\SysWOW64\\sfc.dll',
                        'call AddFiles \\Windows\\SysWOW64\\sfc_os.dll',
                    ])),
                    checkbox('file_systemResources', '补充SystemResources', batch(
                        'xcopy /s /r /y .\\_vendor\\Lib_SystemResources\\* "%x%\\Windows\\SystemResources\\"',
                    )),
                    checkbox('file_users', '补充Users', batch(
                        'xcopy /s /r /y .\\_vendor\\File_Users\\* "%x%\\Users\\"',
                    )),
                    {
                        type: 'group',
                        label: '插件相关',
                        children: [
                            checkbox('files_loader', '插件加载器', batch([
                                'md "%x%\\Program Files\\Edgeless\\plugin_loader"',
                                'xcopy /s /r /y "%workshop%\\Program Files\\Edgeless\\plugin_loader\\*" "%x%\\Program Files\\Edgeless\\plugin_loader\\"',
                            ])),
                            checkbox('files_theme', '主题包管理器', batch([
                                'md "%x%\\Program Files\\Edgeless\\theme_processer"',
                                'xcopy /s /r /y "%workshop%\\Program Files\\Edgeless\\theme_processer\\*" "%x%\\Program Files\\Edgeless\\theme_processer\\"',
                            ])),
                            checkbox('files_ept', 'ept', batch([
                                'md "%x%\\Program Files\\Edgeless\\plugin_ept"',
                                'xcopy /s /r /y "%workshop%\\Program Files\\Edgeless\\plugin_ept\\*" "%x%\\Program Files\\Edgeless\\plugin_ept\\"',
                                'type .\\_commands\\files_ept.wcs>>"%x%\\Program Files\\Edgeless\\system_hooks\\beforePluginLoading\\_Preset.wcs"',
                            ])),
                            checkbox('files_downloader', '插件下载器', batch([
                                'md "%x%\\Program Files\\Edgeless\\plugin_downloader"',
                                'xcopy /s /r /y "%workshop%\\Program Files\\Edgeless\\plugin_downloader\\*" "%x%\\Program Files\\Edgeless\\plugin_downloader\\"',
                            ])),
                            checkbox('files_localboost', 'LocalBoost', batch([
                                'md "%x%\\Program Files\\Edgeless\\plugin_localboost"',
                                'xcopy /s /r /y "%workshop%\\Program Files\\Edgeless\\plugin_localboost\\*" "%x%\\Program Files\\Edgeless\\plugin_localboost\\"',
                            ])),
                        ],
                    },
                    {
                        type: 'group',
                        label: '系统相关',
                        children: [
                            checkbox('files_dynamic', '动态API', batch([
                                'md "%x%\\Program Files\\Edgeless\\dynamic_creator"',
                                'xcopy /s /r /y "%workshop%\\Program Files\\Edgeless\\dynamic_creator\\*" "%x%\\Program Files\\Edgeless\\dynamic_creator\\"',
                            ])),
                            checkbox('files_addin', '系统附件', batch([
                                'md "%x%\\Program Files\\Edgeless\\system_addin"',
                                'xcopy /s /r /y "%workshop%\\Program Files\\Edgeless\\system_addin\\*" "%x%\\Program Files\\Edgeless\\system_addin\\"',
                            ])),
                            checkbox('files_log', '日志工具', batch([
                                'md "%x%\\Program Files\\Edgeless\\system_log"',
                                'xcopy /s /r /y "%workshop%\\Program Files\\Edgeless\\system_log\\*" "%x%\\Program Files\\Edgeless\\system_log\\"',
                            ])),
                            checkbox('files_update', '检查更新', batch([
                                'md "%x%\\Program Files\\Edgeless\\system_update"',
                                'xcopy /s /r /y "%workshop%\\Program Files\\Edgeless\\system_update\\*" "%x%\\Program Files\\Edgeless\\system_update\\"',
                            ])),
                        ],
                    },
                    checkbox('files_easydown', '下载组件', batch([
                        'md "%x%\\Program Files\\Edgeless\\EasyDown"',
                        'xcopy /s /r /y "%workshop%\\Program Files\\Edgeless\\EasyDown\\*" "%x%\\Program Files\\Edgeless\\EasyDown\\"',
                    ])),
                    checkbox('files_Imdisk', 'Imdisk', batch([
                        'md "%x%\\Program Files\\Edgeless\\Imdisk"',
                        'xcopy /s /r /y "%workshop%\\Program Files\\Edgeless\\Imdisk\\*" "%x%\\Program Files\\Edgeless\\Imdisk\\"',
                    ])),
                    checkbox('files_udisk', 'U盘程序', batch([
                        'md "%x%\\Program Files\\Edgeless\\udisk"',
                        'xcopy /s /r /y "%workshop%\\Program Files\\Edgeless\\udisk\\*" "%x%\\Program Files\\Edgeless\\udisk\\"',
                    ])),
                ],
            },
            {
                type: 'group',
                label: '附加文件',
                children: [
                    checkbox('files_setx', 'setx环境变量工具', batch(
                        'copy /y .\\_vendor\\Files\\setx.exe %x%\\Windows\\System32\\',
                    )),
                    checkbox('files_dpinst', 'dpinst驱动安装工具', batch([
                        'copy /y .\\_vendor\\Files\\dpinst.exe "%x%\\Program Files\\Edgeless\\system_addin\\"',
                        'copy /y .\\_vendor\\Files\\dpinst.xml "%x%\\Program Files\\Edgeless\\system_addin\\"',
                    ])),
                    checkbox('files_input', '修复部分程序无法输入', batch(
                        'xcopy /s /r /y .\\_vendor\\Bin_NLS\\* %x%\\Windows\\System32\\',
                    )),
                    checkbox('files_firsttimeaid', '应急插件包', batch(
                        'copy /y .\\_vendor\\Files\\应急包.7z "%x%\\Program Files\\"',
                    )),
                ],
            },
        ],
    },
    {
        page: 'Patch',
        patchName: '补丁',
        title: '补丁',
        batchTitle: 'Patch',
        groups: [
            {
                type: 'group',
                children: [
                    checkbox('patch_vc', 'Visual C++ 9补丁', batch([
                        runWcsScript('patch_vc'),
                        'xcopy /s /r /y .\\_vendor\\Lib_VC9\\* "%x%\\"',
                    ])),
                    checkbox('patch_mklink', 'mklink补丁（不需要）', batch(
                        runWcsScript('patch_mklink'),
                        { commented: true },
                    ), { htmlCommented: true }),
                ],
            },
        ],
    },
    {
        page: 'Optimization',
        patchName: '优化',
        groups: [
            {
                type: 'group',
                label: 'Win10XPE优化',
                children: [
                    checkbox('opt_cn', '解决文件类型中的中文乱码', batch(
                        'type .\\_commands\\opt_cn.wcs>>"%x%\\Program Files\\Edgeless\\system_hooks\\onDiskFound\\_Preset.wcs"',
                    )),
                    checkbox('opt_pin', '替换InitPinIcons.lua文件', [
                        batch('copy /y .\\_vendor\\File_PinIcons\\00-InitPinIcons.lua "%x%\\PEMaterial\\Autoruns\\Startup\\"'),
                        batch(
                            'copy /y .\\_vendor\\File_PinIcons\\00-InitPinIcons.lua "%x%\\PEMaterial\\Autoruns\\Startup\\"',
                            { stage: 'last' },
                        ),
                    ]),
                    checkbox('opt_keyboard', '设置美式键盘', batch([
                        'type .\\_commands\\opt_keyboard.wcs>>"%x%\\Program Files\\Edgeless\\system_hooks\\beforeLocalBoost\\_Preset.wcs"',
                        runWcsScript('opt_keyboard'),
                    ])),
                    checkbox('opt_taskmgr', '汉化任务管理器', batch(
                        [
                            'wimbuilder2 已经复制此文件',
                            '此处再次替换不同版本会导致任务管理器显示空白窗口',
                            'copy /y .\\_vendor\\File_Taskmgr\\Taskmgr.exe.mui "%x%\\Windows\\System32\\ZH-CN\\"',
                        ],
                        { commented: true },
                    )),
                    checkbox('opt_loadDrivers', '登入桌面时加载剩余驱动', batch(
                        'type .\\_commands\\opt_loadDrivers.wcs>>"%x%\\Program Files\\Edgeless\\system_hooks\\onBootFinished\\_Preset.wcs"',
                    )),
                    checkbox('opt_cnUser', '用户文件夹中文', batch([
                        'xcopy /s /r /y /h .\\_vendor\\File_User\\* "%x%\\Users\\Default\\"',
                        'attrib +s "%x%\\Users\\Default\\Desktop"',
                        'attrib +s "%x%\\Users\\Default\\Documents"',
                        'attrib +s "%x%\\Users\\Default\\Downloads"',
                        'attrib +s "%x%\\Users\\Default\\Pictures"',
                    ])),
                    checkbox('opt_firefox', '修复火狐下载崩溃', batch(
                        'call AddFiles \\Windows\\System32\\Windows.UI.FileExplorer.dll',
                    )),
                    checkbox('opt_ExplorerRibbon', '启动时资源管理器功能区最小化', batch(
                        runWcsScript('opt_ExplorerRibbon'),
                    )),
                ],
            },
            {
                type: 'group',
                label: 'FirPE优化',
                children: [
                    checkbox('opt_remove_rtf', '去掉新建菜单中的RTF', batch(runWcsScript('opt_remove_rtf'))),
                    checkbox('opt_remove_undo', '去掉右键还原到以前版本', batch(runWcsScript('opt_remove_undo'))),
                    checkbox('opt_autoAllPrograms', '开始菜单自动跳转所有程序', batch(runWcsScript('opt_autoAllPrograms'))),
                    checkbox('opt_fastShutdown', '快速关机', batch(runWcsScript('opt_fastShutdown'))),
                    checkbox('opt_hideBootWindow', '隐藏启动小窗口', batch(runWcsScript('opt_hideBootWindow'))),
                    checkbox('opt_minPENetwork', '最小化PENetwork', batch(runWcsScript('opt_minPENetwork'))),
                    checkbox('opt_netDelay', '改善网络启动延时', batch(runWcsScript('opt_netDelay'))),
                    checkbox('opt_removeNewShortcut', '移除新建菜单的BMP图像', batch(runWcsScript('opt_removeNewShortcut'))),
                    checkbox('opt_removeSearchIndex', '移除搜索时索引提示', batch(runWcsScript('opt_removeSearchIndex'))),
                    checkbox('opt_transparentCMD', '亚克力cmd', batch(runWcsScript('opt_transparentCMD'))),
                    checkbox('opt_hideSearchOnTaskBar', '移除任务栏搜索', batch(runWcsScript('opt_hideSearchOnTaskBar'))),
                ],
            },
        ],
    },
    {
        page: 'Fixup',
        patchName: '修复',
        batchTitle: '修复',
        groups: [
            {
                type: 'group',
                label: '插件包兼容性',
                children: [
                    checkbox(
                        'edge_fix',
                        '修复 Edge 闪退和 RESULT_CODE_MISSING_DATA',
                        batch([
                            'echo Repairing Microsoft Edge compatibility...',
                            '@REM Remove stale WindowTabManager declarations only when the implementation is absent.',
                            'if not exist "%x%\\Windows\\System32\\Windows.Internal.UI.Shell.WindowTabManager.dll" (',
                            '  reg delete "HKLM\\Tmp_Software\\Classes\\OneCoreContracts\\Windows.Internal.PlatformExtensions.WindowTabManagerContract" /f >nul 2>nul',
                            '  reg delete "HKLM\\Tmp_Software\\Microsoft\\WindowsRuntime\\ActivatableClassId\\Windows.Internal.UI.Shell.DesktopWindowTabManagerContractExtension" /f >nul 2>nul',
                            '  reg delete "HKLM\\Tmp_Software\\WOW6432Node\\Microsoft\\WindowsRuntime\\ActivatableClassId\\Windows.Internal.UI.Shell.DesktopWindowTabManagerContractExtension" /f >nul 2>nul',
                            '  reg delete "HKLM\\Tmp_Software\\Microsoft\\WindowsRuntime\\WellKnownContracts" /v Windows.UI.Shell.WindowTabManagerContract /f >nul 2>nul',
                            '  reg delete "HKLM\\Tmp_Software\\WOW6432Node\\Microsoft\\WindowsRuntime\\WellKnownContracts" /v Windows.UI.Shell.WindowTabManagerContract /f >nul 2>nul',
                            ')',
                            '@REM Restore WinSxS read access required by restricted and AppContainer renderers.',
                            'icacls "%x%\\Windows\\WinSxS" /grant *S-1-5-12:^(OI^)^(CI^)^(RX^) /T /C',
                            'if errorlevel 1 exit /b 1',
                            'icacls "%x%\\Windows\\WinSxS" /grant *S-1-15-2-1:^(OI^)^(CI^)^(RX^) /T /C',
                            'if errorlevel 1 exit /b 1',
                            'icacls "%x%\\Windows\\WinSxS" /grant *S-1-15-2-2:^(OI^)^(CI^)^(RX^) /T /C',
                            'if errorlevel 1 exit /b 1',
                        ]),
                    ),
                ],
            },
        ],
    },
];

export const presetOptions: Readonly<Record<string, boolean>> = {
    'Edgeless.edge_fix': true,
};
