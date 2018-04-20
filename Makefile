.DEFAULT_GOAL := all

base: osx_base
install:
	./bootstrap.sh
dump_vars:
	ansible all -m setup --tree /tmp/facts --connection=local -i ansible_hosts
osx_base:
	ansible-playbook playbooks/common.yml -t osx_base -K
dotfiles:
	ansible-playbook playbooks/common.yml -t dotfiles -K
homebrew:
	ansible-playbook playbooks/common.yml -t homebrew -K
mas:
	ansible-playbook playbooks/common.yml -t mas -K
git:
	ansible-playbook playbooks/common.yml -t git
hazel:
	ansible-playbook playbooks/common.yml -t hazel
tweaks:
	ansible-playbook playbooks/common.yml -t tweaks
all: osx_base dotfiles homebrew mas git hazel tweaks
