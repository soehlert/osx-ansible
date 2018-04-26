# Ansible
Ansible files for OSX local runs.

osx-ansible/playbooks/common.yml shows what roles will be loaded. To see what any role does, look at osx-ansible/roles/${role}/task/main.yml

## Before running you must:
1. Copy local_example.yml to local.yml or just create one with any variables you'd like to override over defaults.yml (you'll want to do this unless you want my name all over your system)

## To run:

cd to osx-ansible dir

##### Raw commands:
./bootstrap.sh
ansible-playbook playbooks/common.yml -K

##### Makefile:
make install
make
