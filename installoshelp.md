# install os

## pre os

```bash
# 进入交互式提示符环境
iwctl
# 接下来是在以 [iwd] 开头的提示符环境中进行的
# 列出所有 WiFi 设备
device list
# 假设刚才的 Name 一列的网络设备名称为 wlan0，接下来扫描网络
station wlan0 scan
# 列出所有可用的网络
station wlan0 get-networks
# 假设想要连到 Network name 一列中，名称为 Xiaomi 的网络
station wlan0 connect Xiaomi
# 然后按照提示输入密码即可

# 启用 NTP 时间同步
timedatectl set-ntp true

mkfs.fat -F32 /dev/sda1

# install arch linux
pacstrap /mnt base base-devel linux linux-firmware dhcpcd vim arch-install-scripts reflector efibootmgr grub tmux zsh sudo networkmanager usbutils git python python3 tmux ntfs-3g openntpd
arch-chroot /mnt
# 设置时区为上海
timedatectl set-timezone Asia/Shanghai
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hostnamectl set-hostname loyxin

echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "zh_CN.UTF-8 UTF-8" >> /etc/locale.gen
# 生成 locale 信息
locale-gen
echo 'LANG=en_US.UTF-8' > /etc/locale.conf
reflector -c China --save /etc/pacman.d/mirrorlist --sort rate

systemctl enable openntpd.service
systemctl enable NetworkManager.service

# after install the basic os
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub
grub-mkconfig -o /boot/grub/grub.cfg
# 修改fstab
genfstab -L /mnt >> /mnt/etc/fstab

## add user must add network
useradd -m -G users,wheel,video,audio,portage,usb,network,mail loyxin
passwd root
passwd loyxin
visudo
chsh -s /bin/zsh loyxin
```


## 其他命令
install window  eject linux because windows will demage the linux
```shell
 efibootmgr  -c -d /dev/nvme0n1 -p 1 -L "deepin-n" -l "/EFI/deepin/grubx64.efi"
# 调整风扇
export DISPLAY=:0
nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan:0]/GPUTargetFanSpeed=$1"

tar --one-file-system aviod adding /proc /dev

dkms
出现提示是否使用dkms，选择NO，在secure boot（安全模式）下使用dkms会无法开机
```

## seafile
```bash
jre11-openjdk mariadb
systemctl enable mariadb.service
sudo pip3 install -r requirement.txt
```

## samba

```bash
samba()
{
    echo "samba install"
    sudo cp ~/program/back/etc/smb.conf /etc/samba/
    rm ~/program/back/etc/smb.conf
    sudo ln /etc/samba/smb.conf ~/program/back/etc/smb.conf
    echo "samba passwd\n"
    sudo smbpasswd -a loyxin
    sudo service smbd restart
    echo "samba complete"
}
```

## jupyter
```bash
    sudo pip3 install jupyter scipy pandas matplotlib ipython
    sudo pip3 install jupyterlab-git jupyter_contrib_nbextensions jupyter-highlight-selected-word jupyterthemes

    jupyter serverextension enable --py jupyterlab_git
    jupyter contrib nbextension install --user
```

## nouse
### gentoo 安装说明
网站 https://wiki.gentoo.org/wiki/Hardened_Gentoo/zh-cn

它在现有 Gentoo Linux 安装上提供了多种额外的安全服务。虽然这些服务可以分别单独使用，但是 "Gentoo Hardened" 启用了 toolchain 中几个可以降低被攻击风险的选项，支持 PaX, grSecurity, SELinux, TPE 等等功能。

目前使用 https://mirrors.tuna.tsinghua.edu.cn/gentoo/releases/amd64/autobuilds/current-stage3-amd64-systemd/

在安装媒介写一个shell 脚本
```shell
mount 设备
wget https://mirrors.tuna.tsinghua.edu.cn/gentoo/releases/amd64/autobuilds/current-stage3-amd64-systemd/stage3-amd64-systemd-$da.tar.xz ## 下载安装系统
tar xpvf stage3-*.tar.bz2 --xattrs-include='*.*' --numeric-owner # 解压到 目标硬盘

cp -rf /etc/resolv.conf /mnt/gentoo/etc/ #网络
wget -P /mnt/gentoo/etc/portage/  https://raw.githubusercontent.com/rafrozen/rafrozen.github.io/master/page/make.conf # 编译器
wget -P /mnt/gentoo/etc/portage/repos.conf https://raw.githubusercontent.com/rafrozen/rafrozen.github.io/master/page/gentoo.conf
mount /dev/$bootdev /mnt/gentoo/boot
mount -t proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/sys
chroot /mnt/gentoo /bin/bash
# 如何根据信息 生成自己的 make.conf
make_conf(){
    gcc -v -E -x c /dev/null -o /dev/null -march=native 2>&1 | grep /cc1
    sudo dmesg | grep x2apic
    sudo dmesg | grep dma
    sudo dmesg| grep video # kernel

    grep pat /proc/cpuinfo
    grep mpx /proc/cpuinfo
    grep umip /proc/cpuinfo
    cat /proc/cpuinfo| grep mce

    sudo dmidecode
lspci -kb -nn -Q > program/back/etc/home/pci
}

## 安装完了
eselect profile set "default/linux/amd64/17.1/systemd"

# layman add
# gentoo-zh

# USE="pulseaudio"
# emerge -av alsa-lib alsa-utils pulseaudio
```

