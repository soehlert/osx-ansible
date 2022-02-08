.DEFAULT_GOAL := install

.PHONY: base
base: osx_base

.PHONY: bootstrap
bootstrap:
	./bootstrap.sh

.PHONY: dump_facts
dump_facts:
	ansible all -m setup --tree /tmp/facts --connection=local -i ansible_hosts

.PHONY: osx_base
osx_base:
	ansible-playbook playbooks/common.yml -t osx_base -K

.PHONY: dotfiles
dotfiles:
	ansible-playbook playbooks/common.yml -t dotfiles

.PHONY: homebrew
homebrew:
	ansible-playbook playbooks/common.yml -t homebrew -K

.PHONY: mas
mas:
	ansible-playbook playbooks/common.yml -t mas

.PHONY: pip
pip:
	ansible-playbook playbooks/common.yml -t pip

.PHONY: go
go:
	ansible-playbook playbooks/common.yml -t golang -K

.PHONY: github
github:
	ansible-playbook playbooks/common.yml -t github

.PHONY: hazel
hazel:
	ansible-playbook playbooks/common.yml -t hazel

.PHONY: defaults
defaults:
	ansible-playbook playbooks/common.yml -t defaults -K

.PHONY: sudo_tid
sudo_tid:
	ansible-playbook playbooks/common.yml -t sudo_tid -K

.PHONY: vim-plug
vim-plug:
	ansible-playbook playbooks/common.yml -t vim-plug

.PHONY: wallpaper
wallpaper:
	ansible-playbook playbooks/common.yml -t wallpaper

.PHONY: update
update:
	ansible-playbook playbooks/update.yml -K

.PHONY: updates
updates: update

.PHONY: update-reboot
update-reboot:
	ansible-playbook playbooks/update.yml -e "reboot=true" -K

.PHONY: updates-reboot
updates-reboot: update-reboot

.PHONY: install
install: 
	ansible-playbook playbooks/common.yml -K

.PHONY: all
all: osx_base dotfiles homebrew mas pip go github hazel defaults vim-plug wallpaper
