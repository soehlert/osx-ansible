# Ansible
Ansible files for OSX local runs.

osx-ansible/playbooks/common.yml shows what roles will be loaded. To see what any role does, look at osx-ansible/roles/${role}/task/main.yml

### Before running you must:
1.  set variables in group_vars/all
2.  set variables in roles/${role}/vars/main.yml if you want to change anything else

### To run: 

cd to osx-ansible dir

#### Raw ansible:
ansible-playbook playbooks/common.yml -K

#### Makefile
make
