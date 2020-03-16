packages := $(shell cd arch-pkgs; ls -d */ | sed 's,/,,')
repos := xmonad-setup emacs-setup dotfiles bc-extensions
everything := $(packages) $(repos) hidpi xmonad-xsession xmonad-log-applet

all: $(everything)

# make print-packages, etc.
print-%  : ; @echo $* = $($*)

.PHONY: $(everything)

clean:
	cd arch-pkgs; make clean; \
        cd xmonad-log-applet; make clean

$(packages):
	cd arch-pkgs; make $@

$(repos):
	cd $@; make install

hidpi:
	cd dotfiles; make hidpi

xmonad-xsession:
	cd xmonad-setup; make xsession

xmonad-log-applet: Xmonad
	cd xmonad-log-applet; ./autogen.sh && make && sudo make install

dotfiles: dotfiles bc-extensions
emacs-setup: emacs
xmonad-setup: Xmonad xmonad-log-applet
mobile-studio-pro: hidpi

base: necessities X11 emacs dotfiles Xmonad
account: dotfiles emacs Xmonad

git-sub-update:
	for repo in $(repos); do \
		git submodule add --force "./$$repo"; \
	done; \
	git submodule add --force "./arch-pkgs"; \
	git commit -am "update submodules to head"; \
	# git push
