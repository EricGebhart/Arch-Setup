packages := $(shell cd arch-pkgs; ls -d */ | sed 's,/,,')
aur-packages := yacreader vivaldi vivaldi-codecs-ffmpeg-extra-bin mu-git
repos := xmonad-setup emacs-setup dotfiles bc-extensions
everything := $(packages) $(aur-packages) $(repos) hidpi xmonad-xsession xmonad-log-applet

all: $(everything)

# make print-packages, etc.
print-%  : ; @echo $* = $($*)

.PHONY: $(everything)

clean:
	cd arch-pkgs; make clean; \
        cd xmonad-log-applet; make clean

$(packages):
	cd arch-pkgs; make $@

$(aur-packages):
	yay -S --noconfirm $@

$(repos):
	cd $@; make install

hidpi:
	cd dotfiles; make hidpi

xmonad-xsession:
	cd xmonad-setup; make xsession

xmonad-log-applet: Xmonad
	cd xmonad-log-applet; ./autogen.sh && make && sudo make install

necessities: yay
yay:
dotfiles: dotfiles bc-extensions
emacs-setup: necessities emacs natural-language mu-git
X11: X11-apps
X11-apps: yacreader vivaldi vivaldi-codecs-ffmpeg-extra-bin
Xfce:
xmonad-setup: Xmonad xmonad-log-applet
Xmonad:
devel:
natural-language:
mobile-studio-pro: hidpi
tablet:

base: X11 X11-apps necessities emacs dotfiles Xmonad yay
account: dotfiles emacs Xmonad

git-sub-update:
	for repo in $(repos); do \
		git submodule add --force "./$$repo"; \
	done; \
	git submodule add --force "./arch-pkgs"; \
	git commit -am "update submodules to head"; \
	# git push
