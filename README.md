# Ansible
Ansible configurations, playbooks and roles for setting up an OSX host.

osx-ansible/playbooks/common.yml shows what roles will be loaded.\
To see what any role does, look at osx-ansible/roles/${role}/task/main.yml

## Before Running You Should:
1. Copy local_example.yml to local.yml or just create one with any variables you'd like to override over defaults.yml (you'll want to do this unless you want my name all over your system)

#### Make targets
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

## TODO
- [x] bootstrap.sh
- [x] convert homebrew to script based install instead of tarball
- [x] update readme
- [x] dotfiles
- [x] Fix search domains to not be hardcoded
- [x] Fix brew bundle
- [x] Pull git repos
- [x] mackup role (nevermind, mackup backups wouldnt be available anyways)
- [x] fonts (using mackup to do this; fonts not seen by iterm?)
- [x] fix makefile
- [x] make sure to have defaults for every variable; put the rest in group vars that need changing
- [x] clean up tweaks
- [x] work brewfile
- [ ] any way to do vpn stuff?
- [x] any way to upload github key via API?
- [ ] add PlugUpdate to update role
- [x] idempotent check for plugclean
- [ ] disable gatekeeper before installing brews, install brews, spctl --add with_items, enable gatekeeper
- [ ] add asciinema demos
