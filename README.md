# Ansible
Ansible files for OSX local runs

Before running you must:
* make sure remote login is enabled in System Prefs -> Sharing
* Go here to grab latest version: http://releases.ansible.com/ansible/ (must be at least 2.0 to use osx tweaks)
* xcode-select install
* tar -zxf ansible*.tar.gz; cd ansible-2*; make; sudo make install
* set variables in group_vars/all
* set variables in roles/*/vars/main.yml

If you want to use dotfiles:
* create {{ ansible_secrets }} directory
* create deploy key for your repo
* put deploy key into ansible_secrets repo with file name "dotfiles"
* allow your deploy key on bitbucket/github
