packages := $(shell cd arch-pkgs; ls -d */ | sed ',/,,')
aur-packages := yacreader vivaldi vivaldi-codecs-fmpeg-extra-bin mu-git
repos := xmonad-setup emacs-setup dotfiles bc-extensions

all: $(packages) $(aur-packages) $(repos) hidpi xmonad-xsession

print-%  : ; @echo $* = $($*)

.PHONY: $(packages) $(aur-packages) $(repos) hidpi xmonad-xsession xmonad-log-applet

$(packages):
	cd arch-pkgs/$@; makepkg -si

$(aur-packages):
	yay -S $@

$(repos):
	cd $@; make install

hidpi:
	cd dotfiles; make hidpi

xmonad-xsession:
	cd xmonad-setup; make xsession

xmonad-log-applet:
	cd xmonad-log-applet; ./autogen.sh && make && sudo make install

necessities: necessities yay
dotfiles: dotfiles bc-extensions
emacs: emacs-setup mu-git
yay:
X11: X11-apps
X11-apps: yacreader vivaldi vivaldi-codecs-fmpeg-extra-bin
Xfce:
Xmonad: xmonad-log-applet xmonad-setup
devel:
natural-language:
mobile-studio-pro: hidpi
tablet:

base: X11 X11-apps necessities emacs dotfiles Xmonad yay
account: dotfiles emacs Xmonad

git-sub-update:
	git submodule add --force $(repos) $(arch-pkgs)
	git commit -am "update submodules to head"
	git push
