import type { FormPage } from './type.ts';

export const pages: FormPage[] = [
    {
        page: 'Driver',
        title: '驱动',
        groups: [
            {
                type: 'group',
                children: [
                    {
                        type: 'checkbox',
                        key: 'drv_disk',
                        label: '磁盘驱动',
                        checked: true,
                        command: {
                            command: () => [
                                'echo Installing Disk Drivers...',
                                'dism /image:"%X%" /Add-Driver /Driver:.\\_vendor\\Drv_Disk /Recurse',
                            ],
                        },
                    },
                ],
            },
        ],
    },
];
