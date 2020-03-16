# Arch-Setup 

This repo consists of two scripts and some submodules.

 * Arch-installer  - a script to do the basic arch install steps -- not recommended to newbies.
 * package-installer - a script frontend to the Makefile which will install some meta packages 
 and my setup repos for various things.  Xorg, Xmonad, emacs, dotfiles, apps, etc.
 
## Explanation

_*Simply, I just wanted a way to replicate my install of Arch Linux, but simply.*_

From what I understand, the typical way to do this is to use Arch 
[packages](https://wiki.archlinux.org/index.php/Creating_packages) and
by creating a 
[local package repo](https://wiki.archlinux.org/index.php/Pacman/Tips_and_tricks#Custom_local_repository), or putting one on the web.  

I've gone down that path. It's complicated and time consuming, and has a few 
problems simply because of the philosophy behind packages and the AUR.

I have a few packages I prefer that come from the [AUR](https://aur.archlinux.org) such as 
[vivaldi](http://vivaldi.com) and [mu4e](https://www.djcbsoftware.nl/code/mu/mu4e.html).  
So far, I have not
figured out how to _makechrootpkg_ from 
[devtools](https://www.archlinux.org/packages/extra/any/devtools/) 
to create a package that I can include in
my local repo. It has complications of it's own.  To build anything from AUR 
_You must install all dependencies into your chroot first_.

Another problem, for me, was that some packages are not 
[meta-packages, but package groups](https://wiki.archlinux.org/index.php/Meta_package_and_package_group)
package groups like xorg, xorg-apps, xfce, gnome, and so forth cannot be installed via 
dependencies in a [PKGBUILD](https://wiki.archlinux.org/index.php/PKGBUILD). 
Either you need to find out what packages are in them and add each one to your packages 
explicitly or you can just install them separately in your script.  I chose the latter because I don't like having to maintain unecessary things.

So, this is set of scripts is simple and obvious. I don't build any packages. 
All I have are lightweight MetaPackages.  None of them do anything but have dependencies.
There is nothing to build or deploy. Just check out this repo and run one script or another.
You can use the Makefile directly to install the various parts instead of using the install-packages script which is just a checklist dialog that calls make.

Depending on what you decide to install, dependencies like xorg are handled in one obvious
and clear place. The Makefile. The same goes for the AUR.  The Makefile in _arch-pkgs_ uses 
`makepkg -si` to install it's meta-packages.  The Makefile here uses `yay -S` for packages in 
the AUR. Super simple, no moving parts, and complexities are in the systems where they belong, not here.  The Makefile is super simple and makes it very easy to install groups of the three types
of things.  Meta-packages, AUR packages and repositories with make.

Essentially `make something` will install something or a group of somethings. Look at the
Makefile if you are curious.


## What is here.

├── README.md
├── Makefile
├── install-arch
├── install-packages
├── arch-pkgs
│   ├── README.md
│   ├── Makefile
│   ├── audio
│   ├── devel
│   ├── mobile-studio-pro
│   ├── natural-language
│   ├── necessities
│   ├── tablet
│   ├── X11
│   ├── X11-apps
│   ├── Xfce
│   ├── Xmonad
│   └── yay
├── bc-extensions
│   ├── README.md
│   ├── Makefile
│   ├── array.bc
│   ├── extensions.bc
│   ├── misc.bc
│   ├── primes.bc
│   └── rand.bc
├── dotfiles
│   ├── README.md
│   ├── Makefile
│   ├── hidpi.txt
│   ├── bin
│   │   ├── bcl
│   │   ├── cellwriter@point
│   │   ├── emacsn
│   │   ├── flash-ergodox
│   │   ├── new-re-frame-proj
│   │   ├── serve-jekyll
│   │   └── switch-kbd
│   └── xcursor.theme
├── emacs-setup
│   ├── README.md
│   ├── Makefile
│   ├── elisp
│   │   ├── bytecompiledir.el
│   │   ├── config
│   │   │   ├── Configuration files for everything.
│   │   ├── extensions
│   │   │   ├── Lisp extensions that have no package.
│   │   ├── packages.el
│   │   ├── setup.el
│   │   ├── themes
│   │   │   ├── Oh so many themes.
│   │   └── vars.el
│   ├── fonts
│   ├── lein-profiles-example.clj
│   └── mbsyncrc
├── xmonad-log-applet
│   ├── README.md
│   ├── AUTHORS.md
│   ├── autogen.sh
│   ├── configure.ac
│   └── ....
└── xmonad-setup
    ├── README.md
    ├── Makefile
    ├── ocean_park_114.jpg
    ├── xmonad.desktop
    └── xmonad.start

32 directories, 364 files

* 2 shell scripts, Makefiles everywhere.
   * install-arch  - to install arch from a Live USB
   * install-packages  -  Dialog checklist frontend to the Makefil. Install packages 
   from the offical repos or the AUR, from local PKGBUILDs as well as some of my repositories.
* arch-pkgs - My Arch Linux meta package repo
* dotfiles -  My dotfiles and scripts repo
* bc-extensions - My [bc](https://www.gnu.org/software/bc/manual/html_mono/bc.html) extensions repo
* emacs-setup - My [emacs](https://www.gnu.org/software/emacs/) configuration repo
* xmonad-setp - My [Xmonad](http://xmonad.org) configuration repo
* xmonad-log-applet - My repo to build xmonad-log-applet which allows xmonad to communicate 
with the panel/toolbar of xfce, gnome, kde, or mate.

## Getting started.

 * boot your Arch Linux Live USB
 * get an internet connection.  _wifi-menu_ is easy if you have wifi.
 * curl the _install-arch_ script from this repo.
    `curl https://raw.githubusercontent.com/EricGebhart/Arch-Setup/master/install-arch  > ./install-arch`
 * Make it executable: `chmod a+x ./install-arch` 
 * Get help `./install-arch -h`
 
 * Partition and possibly format your drive or not.

Be Careful, have fun.
 
 * Run _install-arch_
 * Something like this to install on a drive that is partitioned and formatted accordingly.
    `./install-arch -e <efi partition> -r <root partition> -u <user>`
    `./install-arch -e /dev/sda1 -r /dev/sda2 -u Sherlock`
 * or if you are ok with automatic partitioning and formatting.
    `./install-arch -d /dev/sda -u Sherlock`

 
## After basic installation and reboot
 
### Get a network. 

 * The _install-arch_ script installed 
[Network manager](https://wiki.archlinux.org/index.php/NetworkManager).   

 * [start and enable the Network manager](https://wiki.archlinux.org/index.php/NetworkManager#Enable_NetworkManager).
   * `sudo systemctl enable NetworkManager; systemctl start NetworkManager`
 
 * [Connect as you like:](https://wiki.archlinux.org/index.php/NetworkManager#Usage)
   * `nmtui` the NCurses based console gui
   * `nmcli` the command line.
   
### install packages

 Run _install packages_ : `./install-packages`
 
You are on your own from here... 

## Make it yours

To clone this repo so you can just do the _install-packages_ script do this.  

 `git clone --remote-submodules --recursive-submodules http://github.com/ericgebhart/Arch-Setup`

Or more likely, you should just fork this repo and add what you want. 
If you feel like sharing, do a pull request.

 
## Arch-installer

 This is a basic arch installer. There isn't much to installing arch as it is,
 but after doing it a bunch of times it's nice to have something that automates things a bit.
 
 If you haven't installed Arch Linux manually a few times, following the instructions 
 [in the instllation guide](https://wiki.archlinux.org/index.php/Installation_guide#Localization)
 Then this script is possibly not for you.  Go earn some experience points over there first.
 
 I sort of like doing the Arch install manually, it's not like it's too difficult. 
 Some of it can be a bit tedious but the most
 important things to me are really remembering the basic pacstrap packages I need, 
 creating my user account with wheel & sudo and then cloning this repo with submodules 
 into my home directory so I can install the rest of the system after reboot.
 
 Basically, if you like, use _install-arch_ to install Arch from a live USB.
 Then, after reboot, come to this Arch-Setup folder in the admin user's home
 directory, installed by the _install-arch_ and run _install-packages_ to finish
 up installation and personalization of your system.
 
Really, doing it all manually is not rocket science unless you are a newbie.
  * fdisk/parted, 
  * mkfs, 
  * mounts
  * pacstrap
  * genfstab 
  * arch-chroot
    * locale
    * zoneinfo 
    * boot-ctl 
      * conf
      * entries/entry
    * passwd
    * exit
  * umount
  * reboot
 
 For me the important bits are these additions to the standard instructions. 
 I always seem to forget somthing here.

    # install the base system pieces I want and need to get a basic install.
    pacstrap /mnt base linux linux-firmware base-devel devtools sudo network-manager git zsh dialog

    # create my userid with wheel then go edit /etc/sudoers to give sudo to wheel.
    arch-chroot /mnt useradd -mU -s /usr/bin/zsh -G wheel,uucp,video,audio,storage,games,input "$user"
    # fetch this repo into my new user account so I can install the rest of my stuff 
    # with my package-installer after reboot.
    arch-chroot -u "$user" /mnt git clone --remote-submodules --recurse-submodules https://github.com/ericgebhart/Arch-Setup
 
 
## package-installer
 
 This script installs my metapackages and my personal configurations and scripts.
 
 A checklist is provided for what you might want to install from my packages and repos.
 
 Basic stuff like zsh dotfiles, .Xresources, my ~/bin folder, and emacs setup are
 in _Necessities_. After that there are some extra packages if you choose tablet or
 mobile studio pro.  High dpi is a group of settings which are added to .Xresources
 by the dotfiles repo if you ask for it.  I need them for my Wacom mobile studio pro
 and my computer which uses a wacom cintiq for a monitor. Both have resolutions around
 3840x2160, the text is super tiny and the mouse pointer is invisible without these settings.
 
 I do not currently install a display manager like sddm.  I rely on *startx*.
 
 Xorg and friends are always installed if you choose _Xmonad_ or _Xfce_. 
 
### submodule repos used here are:
 
 * [arch-pkgs](http://github.com/ericgebhart/arch-pkgs) - My arch meta-packages.
 
#### The Necessities choice
 
 * necessities  - An Arch pkgbuild with various basic packages.
 * [dotfiles](http://github.com/ericgebhart/dotfiles)  - My dotfiles, zsh, Xresources, and miscellaneous other things that mostly
   go into my _~/bin_ directory.  Includes a high DPI udate to _.Xresources_ if chosen.
 * [bc-extensions](http://github.com/ericgebhart/bc-extensions) which is a set of extensions for bc.
 * [emacs-setup](http://github.com/ericgebhart/emacs-setup) - My emacs setup which includes isync and mu4e for email.
   [yay](http://github.com/jguer/yay) - An installer for packages in the AUR.

#### Xmonad
 * [xmonad-setup](http://github.com/ericgebhart/xmonad-setup) - My Xmonad configuration.
 * [xmonad-log-applet](http://github.com/ericgebhart/xmonad-log-applet) - An applet that 
 allows communication between XMonad and the panel which comes with xfce4, gnome, kde and mate.
 

## See Also:

[Arch Linux; Creating an automated install and personal Setup](http://ericgebhart.com/blog/code/2020-03-15-Arch-Linux/)
 
* [hosting an arch linux repository in an amazon s3 bucket]: https://disconnected.systems/blog/archlinux-repo-in-aws-bucket
* [managing arch linux with meta packages]: https://disconnected.systems/blog/archlinux-meta-packages
* [creating a custom arch linux installer]: https://disconnected.systems/blog/archlinux-installer
