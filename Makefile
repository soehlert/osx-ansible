.DEFAULT_GOAL := help

# This automatically builds the help target based on commands prepended with a double hashbang
## help: print this help output
.Phony: help
help: Makefile
	@sed -n 's/^##//p' $<

## base: sets up things like hostname, directories, ssh keys, searchdomains
.PHONY: base
base: osx_base

## bootstrap: install homebrew and ansible if they aren't already
.PHONY: bootstrap
bootstrap:
	./bootstrap.sh

# dump_facts: display all ansible facs on this host
.PHONY: dump_facts
dump_facts:
	ansible all -m setup --tree /tmp/facts --connection=local -i ansible_hosts

## osx_base: sets up things like hostname, directories, ssh keys, searchdomains
.PHONY: osx_base
osx_base:
	ansible-playbook playbooks/common.yml -t osx_base -K

## dotfiles: installs your dotfiles
.PHONY: dotfiles
dotfiles:
	ansible-playbook playbooks/common.yml -t dotfiles

## homebrew: installs casks and brews
.PHONY: homebrew
homebrew:
	ansible-playbook playbooks/common.yml -t homebrew -K

## mas: installs apple store apps
.PHONY: mas
mas:
	ansible-playbook playbooks/common.yml -t mas

## pip: installs python applications
.PHONY: pip
pip:
	ansible-playbook playbooks/common.yml -t pip

## go: installs golang applications
.PHONY: go
go:
	ansible-playbook playbooks/common.yml -t golang -K

## github: Upload ssh key (if using 2fa), clone all a users repos
.PHONY: github
github:
	ansible-playbook playbooks/common.yml -t github

## defaults: change a lot of macos defaults (defaults write ...)
.PHONY: defaults
defaults:
	ansible-playbook playbooks/common.yml -t defaults -K

## sudo_tid: turns on touchID for sudo
.PHONY: sudo_tid
sudo_tid:
	ansible-playbook playbooks/common.yml -t sudo_tid -K

## vim-plug: installs plugs for vim
.PHONY: vim-plug
vim-plug:
	ansible-playbook playbooks/common.yml -t vim-plug

## wallpaper: sets the wallpaper to any image you want
.PHONY: wallpaper
wallpaper:
	ansible-playbook playbooks/common.yml -t wallpaper

## update: update as many binaries as you can without rebooting
.PHONY: update
update:
	ansible-playbook playbooks/update.yml -K

## updates: update as many binaries as you can without rebooting
.PHONY: updates
updates: update

## update-reboot: update as many binaries as you can and reboot
.PHONY: update-reboot
update-reboot:
	ansible-playbook playbooks/update.yml -e "reboot=true" -K

## updates-reboot: update as many binaries as you can and reboot
.PHONY: updates-reboot
updates-reboot: update-reboot

## install: run the whole common playbook
.PHONY: install
install: 
	ansible-playbook playbooks/common.yml -K

.PHONY: all
all: osx_base dotfiles homebrew mas pip go github defaults vim-plug wallpaper
