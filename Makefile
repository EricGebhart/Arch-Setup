packages := $(shell cd arch-pkgs; ls -d */ | sed 's,/,,')
repos := xmonad-setup emacs-setup dotfiles\
 bc-extensions onboard-layouts games-setup
everything := $(packages) $(repos) hidpi xmonad-xsession xmonad-log-applet

all: $(everything)

# make print-packages, etc.
print-%  : ; @echo $* = $($*)

.PHONY: $(everything)

clean:
	$(MAKE) -C arch-pkgs clean
	$(MAKE) -C xmonad-log-applet clean

$(packages):
	$(MAKE) -C arch-pkgs $@

$(repos):
	$(MAKE) -C $@ install

hidpi:
	$(MAKE) -C dotfiles hidpi

enable-anbox:
	$(MAKE) -C dotfiles $@

xmonad-xsession:
	$(MAKE) -C xmonad-setup xsession

# the default is to build for xfce.
xmonad-log-applet: Xmonad
	cd $@; ./autogen.sh
	$(MAKE) -C $@
	$(MAKE) -C $@ install

dotfiles: bc-extensions onboard-layouts
emacs-setup: emacs-pkg-setup
xmonad-setup: Xmonad xmonad-log-applet
mobile-studio-pro: hidpi

base: necessities X11 emacs-setup dotfiles xmonad-setup
account: dotfiles emacs-setup xmonad-setup

git-sub-update:
	git submodule update --recursive --remote
