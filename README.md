# Ansible
Ansible files for OSX local runs.

osx-ansible/playbooks/common.yml shows what roles will be loaded.

to see what any role does, look at osx-ansible/roles/${role}/task/main.yml

Before running you must:
1.  set variables in group_vars/all MUST DO 
2.  set variables in roles/${role}/vars/main.yml if you want to change anything else

to run: 
cd to osx-ansible dir
ansible-playbook playbooks/common.yml
