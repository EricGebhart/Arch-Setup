# Arch-Setup 

This repo consists of two scripts and some submodules.

 * Arch-installer  - a script to do the basic arch install steps.
 * package-installer - a script to install some meta packges and setup
 for various things.
 
## Arch-installer

 This is a basic arch installer. There isn't much to installing arch as it is,
 but after doing it a bunch of times it's nice to have something that automates things a bit.
 
 To get it after you've booted your Arch linux Live USB connect to the internet, 
 I usually use `wifi-menu`.  Then do this curl command to fetch the installer script.
 
 `curl https://raw.githubusercontent.com/EricGebhart/Arch-Setup/master/install-arch  > ./install-arch`
 
 If you haven't installed Arch Linux manually a few times, following the instructions 
 [in the instllation guide](https://wiki.archlinux.org/index.php/Installation_guide#Localization)
 Then this script is possibly not for you.  Go earn some experience points over there first.
 
 I sort of like doing the Arch install manually, it's not like it's too difficult. 
 Some of it can be a bit tedious but the most
 important things to me are really remembering the basic pacstrap packages I need, 
 creating my user account with wheel & sudo and cloning this repo with submodules 
 into my home directory so I can install the rest of the system after reboot.
 
 Basically, if you like, use the Arch installer to install Arch from a live USB.
 Then, after reboot, come to this Arch-Setup folder in the admin user's home
 directory, installed by the Arch-installer and run package-installer to finish
 up installation.
 
 Doing the fdisk/parted, mkfs, mounts genfstab, locale, zoneinfo, and boot-ctl steps are
 mostly trivial.  
 
 For me the important bits are these commands. I always seem to forget somthing here.

    # install the base system pieces I want and need to get a basic install.
    pacstrap /mnt base linux linux-firmware base-devel devtools sudo network-manager git zsh dialog

    # create my userid then go edit /etc/sudoers to give sudo to wheel.
    arch-chroot /mnt useradd -mU -s /usr/bin/zsh -G wheel,uucp,video,audio,storage,games,input "$user"
    # fetch this repo into my new user account so I can install the rest of my stuff 
    # with my package-installer after reboot.
    arch-chroot -u "$user" /mnt git clone --remote-submodules --recurse-submodules https://github.com/ericgebhart/Arch-Setup
 
 
## package-installer
 
 This script installs my metapackages and my personal configurations and scripts.
 
 A checklist is provided for what you might want to install from my packages and repos.
 
 Basic stuff like zsh dotfiles, .Xresources, my ~/bin folder, and emacs setup are
 always installed. After that there are some extra packages if you choose tablet or
 mobile studio pro.  High dpi is a group of settings which are added to .Xresources
 by the dotfiles repo if you ask for it.  I needed them for my Wacom mobile studio pro
 and my computer which uses a wacom cintiq for a monitor. Both have resolutions around
 3840x2160, the text is super tiny and the mouse pointer is invisible without these settings.
 
 I do not currently install a display manager like sddm.  I rely on *startx*.
 
 Xorg and friends are always installed if you choose _Xmonad_ or _xfce_. 
 
### submodule repos used here are:
 
 * [arch-pkgs](http://github.com/ericgebhart/arch-pkgs) - My arch meta-packages.
 
#### Always Installed.
 
 * necessities  - An Arch pkgbuild with various basic packages.
 * [dotfiles](http://github.com/ericgebhart/dotfiles)  - My dotfiles, zsh, Xresources, and miscellaneous other things that mostly
   go into my _~/bin_ directory.  Includes a high DPI udate to _.Xresources_ if chosen.
 * [bc-extensions](http://github.com/ericgebhart/bc-extensions) which is a set of extensions for bc.
 * [emacs-setup](http://github.com/ericgebhart/emacs-setup) - My emacs setup which includes isync and mu4e for email.
   [yay](http://github.com/jguer/yay) - An installer for packages in the AUR.

#### Xmonad
 * [xmonad-setup](http://github.com/ericgebhart/xmonad-setup) - My Xmonad configuration.
 * [xmonad-log-applet](http://github.com/ericgebhart/xmonad-log-applet) - An applet that allows communication between XMonad and the panel
   which comes with xfce4, gnome, kde and mate.

 
 
