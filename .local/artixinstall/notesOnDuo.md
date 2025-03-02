`pacman -Sy`
`rc-service sshd start`

`ip a`
`ssh root@192.168.1.192`

`v ~/.ssh/known_hosts.old`

`pacman -S gptfdisk parted`


end sector of last windows partition
`parted /dev/nvme0n1 'unit s print'`

`cgdisk /dev/nvme0n1`
`512Mib`
`parted -s /dev/nvme0n1 set 6 lvm on`
`cryptsetup luksFormat -v --type=luks1 /dev/nvme0n1p6`

`cryptsetup luksOpen /dev/nvme0n1p6 lvm-system`
`pvcreate /dev/mapper/lvm-system`
`vgcreate lvmSystem /dev/mapper/lvm-system`
`lvcreate -L 64G lvmSystem -n volSwap`
`lvcreate -l +100%FREE lvmSystem -n volRoot`
`mkswap /dev/lvmSystem/volSwap`
- watch for UUID
`mkfs.ext4 -L volRoot /dev/lvmSystem/volRoot`
`mkfs.ext4 /dev/nvme0n1p5`
`mount /dev/lvmSystem/volRoot /mnt`
`mkdir /mnt/boot`
`mount /dev/nvme0n1p5 /mnt/boot`
`mkdir -p /mnt/boot/efi`
`mount /dev/nvme0n1p1 /mnt/boot/efi`
`swapon /dev/lvmSystem/volSwap`


`basestrap -i /mnt base base-devel openrc`
- to choose open-rc
`basestrap /mnt linux-firmware linux linux-headers neovim openssh openssh-openrc networkmanager networkmanager-openrc lvm2 lvm2-openrc cryptsetup cryptsetup-openrc git grub efibootmgr dosfstools freetype2 fuse2 gptfdisk libisoburn mtools os-prober`

`fstabgen -U /mnt >> /mnt/etc/fstab`

`echo "tmpfs	/tmp	tmpfs	rw,nosuid,noatime,nodev,size=4G,mode=1777	0 0" >> /mnt/etc/fstab`

`artix-chroot /mnt /bin/bash`

`echo -e "en_US.UTF-8 UTF-8" >> /etc/locale.gen`
`locale-gen`
`echo LANG=en_US.UTF-8 > /etc/locale.conf`
`export LANG=en_US.UTF-8`

`ln -s /usr/share/zoneinfo/America/New_York /etc/localtime`
`echo "hostname=4rt1x" > /etc/conf.d/hostname`

update HOOKS in mkinitcpio.conf to
`HOOKS=(base udev autodetect keyboard modconf kms keymap consolefont block encrypt lvm2 resume filesystems fsck)`

`pacman -S grub efibootmgr`
`pacman -S dosfstools freetype2 fuse2 gptfdisk libisoburn mtools os-prober`

for nvidia optimus laptop
- update MODULES in mkinitcpio.conf to
    `MODULES(nvidia nvidia_modeset nvidia_uvm nvidia_drm)`

- append to end of GRUB_CMDLINE_LINUX_DEFAULT in /etc/default/grub
    `acpi_osi=Linux acpi_backlight=video`

hibernation UUID finder grub
`blkid -s UUID -o value /dev/lvmSystem/volSwap`

keyfilepath reference:
`blkid -s UUID -o value /dev/nvme0n1p5`

grub-install
`grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=artix --recheck /dev/nvme0n1`

`grub-mkconfig -o /boot/grub/grub.cfg`


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

### Sudoers
```
%wheel ALL=(ALL:ALL) NOPASSWD: /usr/bin/shutdown,/usr/bin/reboot,/usr/bin/systemctl suspend,/usr/bin/wifi-menu,/usr/bin/mount,/usr/bin/umount,/usr/bin/pacman -Syu,/usr/bin/pacman -Syyu,/usr/bin/pacman -Syyu --noconfirm,/usr/bin/loadkeys,/usr/bin/pacman -Syyuw --noconfirm,/usr/bin/pacman -S -u -y --config /etc/pacman.conf --,/usr/bin/pacman -S -y -u --config /etc/pacman.conf --
```

### Install early
```
sudo pacman -S xorg-server xorg-xinit dmenu brave-bin noto-fonts noto-fonts-emoji ttf-sarasa-gothic ttf-iosevka-nerd pipewire arandr xcompmgr xwallpaper mpd-openrc mpc pamixer mpv xcape nvidia unclutter
```

+ `xclip`

### Save lvm install from boot driver
```bash
cryptsetup luksOpen /dev/nvme0n1p5 lvm-system
pvscan
vgscan
vgchange -a y
lvscan
mount /dev/lvmSystem/volRoot /mnt
# mount /dev/nvme0n1p1 /mnt/boot/efi
artix-chroot /mnt /bin/bash # formerly artools-chroot

exit
umount -R /mnt
reboot
```

### Add these to default
```bash
sudo rc-update add ntpd default
```

### ntp-client init script update (wireless useful)
```
depend() {
    before cron portmap
-   after net
+   need net
    use dns logger
}
```

## Helpful commands
Run this after updating your `.config/Xresources`:
```config
!xrdb .config/Xresources
```

### suckless apps

- config.def.h is an example config, config.h is your actual config
- apply a patch with:
`git apply --reject --whitespace=fix`
- after applying a patch run:
```bash
make
sudo make install
```
### printer
[driver](https://aur.archlinux.org/packages/brother-hl-l2380dw)

```bash
pacman -S cups cups-openrc
sudo rc-service cupsd start
sudo rc-update add cupsd default
```
1) Install this package
2) In CUPS, add a new lpd printer using a path such as the following, with the printer's ip address: lpd://xxxx.xxx.xxx.xxx/queue 
3) Select the ppd from /opt/brother/Printers/HLL2380DW/cupswrapper/brother-HLL2380DW-cups-en.ppd

##### Vimium settings
```
map J goBack
map K goForward
map H previousTab
map L nextTab
map d removeTab
map D restoreTab
```

#### Opera settings
`sudo nvim /etc/opera/default` conf file`
```
OPERA_FLAGS="
--force-device-scale-factor=2.5
"
```

#### Keyboard mapping
Layer 0 = Linux / Windows
  - mods: Menu,LGui,LAlt,space,RAlt,RGui.  Caps = Ctrl if held & Escape if pressed
Layer 2 = MacOS
  - mods: Menu,LAlt,LCtrl,space,RAlt,RGui.  Caps = LGui if held & Escape if pressed
Layer 1 = Numpad 0 -> go to layer 0, Numpad 2 -> go to layer 2
Temporarily go to layer 1 by holding right function key on layer 0/2
```bash
sudo dfu-programmer atmega32u4 erase --force
sudo dfu-programmer atmega32u4 flash .config/kbds/fc980c.hex
sudo dfu-programmer atmega32u4 reset
```

#### vim shortcuts
```lua
vim.keymap.set("n", "<leader>gs", vim.cmd.Git);
```

### replace forbidden characters in directory recursively brackets parentheses, [DUB].mp4 => (DUB).mp4

```bash
find . -depth -execdir perl-rename 's/\[/\(/g; s/\]/\)/g; s/:/ - )/g' {} +
```
