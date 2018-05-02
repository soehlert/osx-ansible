# Ansible
Ansible files for OSX local runs.

osx-ansible/playbooks/common.yml shows what roles will be loaded. To see what any role does, look at osx-ansible/roles/${role}/task/main.yml

## Before running you must:
1. Copy local_example.yml to local.yml or just create one with any variables you'd like to override over defaults.yml (you'll want to do this unless you want my name all over your system)

### Make targets
1. base: installs osx_base role
2. install: runs the bootstrap script
3. dump_facts: dumps all local facts ansible can find
4. osx_base: sets up some things (hostname, login shell, create directories, create ssh key, set searchdomains)
5. dotfiles: installs dotfiles from a repo you provide
6. homebrew: install packages from homebrew/homebrew cask
7. mas: connects to the Mac App Store and installs applications from there
8. github: uploads ssh key to github, clones all my repos from github
9. hazel: [hazel](https://www.noodlesoft.com/) is a powerful auto organizing tool. this target sets up the directories I use hazel on
10. tweaks: lots of little osx tweaks (think `defaults write`)
11. vim-plug: sets up [vim-plug](https://github.com/junegunn/vim-plug)
12. update: runs update playbook; updates mas, homebrew, hombrew cask, npm, pip packages and ruby gems
13. complete: runs all of these (minus install) only asking for one sudo password
14. all: runs all of these, but will ask for sudo password for each role that requires it

## To run:
cd to osx-ansible directory

##### Raw commands:
1. `./bootstrap.sh`
2. `ansible-playbook playbooks/common.yml -K`

##### Makefile:
1. `make install`
2. `make`
