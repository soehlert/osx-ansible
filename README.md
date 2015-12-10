# Ansible
Ansible files for OSX local runs

Before running you must:
* make sure remote login is enabled in System Prefs -> Sharing
* Go here to grab latest version: http://releases.ansible.com/ansible/ (must be at least 2.0 to use osx tweaks)
* xcode-select --install
* tar -zxf ansible*.tar.gz; cd ansible-2*; make; sudo make install
* edit osx-ansible/ansible.cfg to point to correct inventory file (ansible_hosts in osx-ansible) and (ansible.cfg in osx-ansible)
* set variables in group_vars/all ***** MUST DO *****
* set hostname variable roles/osx_base/vars/main.yml
* set variables in roles/*/vars/main.yml

If you want to use dotfiles:
* create {{ ansible_secrets }} directory
* create deploy key for your repo
* put deploy key into ansible_secrets repo with file name "dotfiles"
* allow your deploy key on bitbucket/github


to run: 
cd to osx-ansible dir
ansible-playbook playbooks/common.yml -k -K 

Type ssh password then hit enter twice (assuming sudo password is same as your user password)