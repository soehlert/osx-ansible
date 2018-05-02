.DEFAULT_GOAL := complete

base: osx_base
install:
	./bootstrap.sh
dump_facts:
	ansible all -m setup --tree /tmp/facts --connection=local -i ansible_hosts
osx_base:
	ansible-playbook playbooks/common.yml -t osx_base -K
dotfiles:
	ansible-playbook playbooks/common.yml -t dotfiles
homebrew:
	ansible-playbook playbooks/common.yml -t homebrew -K
mas:
	ansible-playbook playbooks/common.yml -t mas
github:
	ansible-playbook playbooks/common.yml -t github
hazel:
	ansible-playbook playbooks/common.yml -t hazel
tweaks:
	ansible-playbook playbooks/common.yml -t tweaks -K
vim-plug:
	ansible-playbook playbooks/common.yml -t vim-plug
update:
	ansible-playbook playbooks/update.yml -K
updates: update
complete: 
	ansible-playbook playbooks/common.yml -K
all: osx_base dotfiles homebrew mas github hazel tweaks vim-plug
