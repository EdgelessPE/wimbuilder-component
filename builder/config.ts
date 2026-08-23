import type {
    CheckboxForm,
    FormCommand,
    FormCommands,
    FormPage,
} from './type.ts';

const batch = (
    content: string | string[],
    options: Pick<FormCommand, 'stage' | 'commented'> = {},
): FormCommand => ({
    ...options,
    command: () => content,
});

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
    checked: true,
    command,
});

export const pages: FormPage[] = [
    {
        page: 'Slim',
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
                                command: batch([
                                    'call .\\Slim\\FirPE_Slim.cmd %x% %opt[Edgeless.Slim]%',
                                    'title Edgeless Patch Running...',
                                ]),
                            },
                            {
                                label: '普通精简',
                                value: '2',
                                command: batch([
                                    'call .\\Slim\\FirPE_Slim.cmd %x% %opt[Edgeless.Slim]%',
                                    'title Edgeless Patch Running...',
                                ]),
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
        page: 'Apple',
        groups: [
            {
                type: 'group',
                children: [
                    checkbox('apple', 'HFS和MNT支持', batch([
                        '%append1%apple.wcs%append2%',
                        'xcopy /s /r /y .\\_vendor\\Lib_Apple\\* "%x%\\Windows\\System32\\drivers\\"',
                    ])),
                ],
            },
        ],
    },
    {
        page: 'Files',
        batchTitle: 'File',
        commandOrder: {
            main: [
                'file_system32',
                'file_syswow64',
                'file_systemResources',
                'file_users',
                'files_dynamic',
                'files_easydown',
                'files_Imdisk',
                'files_downloader',
                'files_ept',
                'files_loader',
                'files_localboost',
                'files_addin',
                'files_log',
                'files_update',
                'files_theme',
                'files_udisk',
                'files_setx',
                'files_dpinst',
                'files_input',
                'files_firsttimeaid',
            ],
        },
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
                                'type .\\_commands\\files_ept.wcs>>"%x%\\Program Files\\Edgeless\\system_hooks\\onBootFinished\\_Preset.wcs"',
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
        title: '补丁',
        batchTitle: 'Patch',
        groups: [
            {
                type: 'group',
                children: [
                    checkbox('patch_vc', 'Visual C++ 9补丁', batch([
                        '%append1%patch_vc.wcs%append2%',
                        'xcopy /s /r /y .\\_vendor\\Lib_VC9\\* "%x%\\"',
                    ])),
                    checkbox('patch_mklink', 'mklink补丁（不需要）', batch(
                        '%append1%patch_mklink.wcs%append2%',
                        { commented: true },
                    ), { htmlCommented: true }),
                ],
            },
        ],
    },
    {
        page: 'Optimization',
        commandOrder: {
            main: [
                'opt_cn',
                'opt_pin',
                'opt_keyboard',
                'opt_taskmgr',
                'opt_remove_rtf',
                'opt_remove_undo',
                'opt_loadDrivers',
                'opt_cnUser',
                'opt_firefox',
                'opt_ExplorerRibbon',
                'opt_autoAllPrograms',
                'opt_fastShutdown',
                'opt_hideBootWindow',
                'opt_minPENetwork',
                'opt_netDelay',
                'opt_removeNewShortcut',
                'opt_removeSearchIndex',
                'opt_transparentCMD',
                'opt_hideSearchOnTaskBar',
            ],
        },
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
                        '%append1%opt_keyboard.wcs%append2%',
                    ])),
                    checkbox('opt_taskmgr', '汉化任务管理器', batch(
                        [
                            'rem wimbuilder2 已经复制此文件',
                            'rem 此处再次替换不同版本会导致任务管理器显示空白窗口',
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
                        '%append1%opt_ExplorerRibbon.wcs%append2%',
                    )),
                ],
            },
            {
                type: 'group',
                label: 'FirPE优化',
                children: [
                    checkbox('opt_remove_rtf', '去掉新建菜单中的RTF', batch('%append1%opt_remove_rtf.wcs%append2%')),
                    checkbox('opt_remove_undo', '去掉右键还原到以前版本', batch('%append1%opt_remove_undo.wcs%append2%')),
                    checkbox('opt_autoAllPrograms', '开始菜单自动跳转所有程序', batch('%append1%opt_autoAllPrograms.wcs%append2%')),
                    checkbox('opt_fastShutdown', '快速关机', batch('%append1%opt_fastShutdown.wcs%append2%')),
                    checkbox('opt_hideBootWindow', '隐藏启动小窗口', batch('%append1%opt_hideBootWindow.wcs%append2%')),
                    checkbox('opt_minPENetwork', '最小化PENetwork', batch('%append1%opt_minPENetwork.wcs%append2%')),
                    checkbox('opt_netDelay', '改善网络启动延时', batch('%append1%opt_netDelay.wcs%append2%')),
                    checkbox('opt_removeNewShortcut', '移除新建菜单的BMP图像', batch('%append1%opt_removeNewShortcut.wcs%append2%')),
                    checkbox('opt_removeSearchIndex', '移除搜索时索引提示', batch('%append1%opt_removeSearchIndex.wcs%append2%')),
                    checkbox('opt_transparentCMD', '亚克力cmd', batch('%append1%opt_transparentCMD.wcs%append2%')),
                    checkbox('opt_hideSearchOnTaskBar', '移除任务栏搜索', batch('%append1%opt_hideSearchOnTaskBar.wcs%append2%')),
                ],
            },
        ],
    },
];
