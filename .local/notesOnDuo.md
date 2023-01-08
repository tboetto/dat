`pacman -Sy`
`pacman -S gptfdisk parted`


end sector of last windows partition
`parted /dev/sda 'unit s print'`

basestrap -i
- to choose open-rc

update HOOKS in mkinitcpio.conf to
`HOOKS=(base udev autodetect keyboard modconf block encrypt filesystems fsck)`

hibernation UUID finder grub
`blkid -s UUID -o value /dev/lvmSystem/volSwap`

keyfilepath reference:
`blkid -s UUID -o value /dev/nvme0n1p5`

grub-install
`grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=artix --recheck /dev/nvme0n1`

### Arch repo support
add this to `/etc/pacman.conf`
```
[universe]
Server = https://universe.artixlinux.org/$arch
Server = https://mirror1.artixlinux.org/universe/$arch
Server = https://mirror.pascalpuffke.de/artix-universe/$arch
Server = https://artixlinux.qontinuum.space/artixlinux/universe/os/$arch
Server = https://mirror1.cl.netactuate.com/artix/universe/$arch
Server = https://ftp.crifo.org/artix-universe/
```
`pacman -S artix-archlinux-support`
`pacman-key --populate archlinux`
