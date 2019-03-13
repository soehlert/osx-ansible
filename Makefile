.DEFAULT_GOAL := install

base: osx_base
bootstrap:
	./bootstrap.sh
dump_facts:
	ansible all -m setup --tree /tmp/facts --connection=local -i ansible_hosts
osx_base:
	ansible-playbook playbooks/common.yml -t osx_base -K
dotfiles:
	ansible-playbook playbooks/common.yml -t dotfiles
homebrew:
	ansible-playbook playbooks/common.yml -t homebrew
mas:
	ansible-playbook playbooks/common.yml -t mas
macos_install:
	ansible-playbook playbooks/common.yml -t macos_install
github:
	ansible-playbook playbooks/common.yml -t github
hazel:
	ansible-playbook playbooks/common.yml -t hazel
defaults:
	ansible-playbook playbooks/common.yml -t defaults -K
vim-plug:
	ansible-playbook playbooks/common.yml -t vim-plug
wallpaper:
	ansible-playbook playbooks/common.yml -t wallpaper
update:
	ansible-playbook playbooks/update.yml -K
updates: update
update-reboot:
	ansible-playbook playbooks/update.yml -K -e "reboot=true"
updates-reboot: update-reboot
install: 
	ansible-playbook playbooks/common.yml -K
all: osx_base dotfiles homebrew mas macos_install github hazel defaults vim-plug wallpaper
