# Ansible
Ansible files for OSX local runs
osx-ansible/playbooks/common.yml shows what roles will be loaded
to see what any role does, look at osx-ansible/roles/$role_name/task/main.yml

Before running you must:

1. make sure remote login is enabled in System Prefs -> Sharing
2.  Go here to grab latest version: http://releases.ansible.com/ansible/ (must be at least 2.0 to use osx tweaks)
3.  xcode-select --install
4.  tar -zxf ansible*.tar.gz; cd ansible-2*; make; sudo make install
5.  edit osx-ansible/ansible.cfg to point to correct inventory file (ansible_hosts in osx-ansible) and (ansible.cfg in osx-ansible)
6.  set variables in group_vars/all ***** MUST DO *****
7.  set hostname variable roles/osx_base/vars/main.yml
8.  set variables in roles/*/vars/main.yml

If you want to use dotfiles:

1.  create {{ ansible_secrets }} directory
2.  create deploy key for your repo
3.  put deploy key into ansible_secrets repo with file name "dotfiles"
4.  allow your deploy key on bitbucket/github


to run: 
cd to osx-ansible dir
ansible-playbook playbooks/common.yml -k -K 

Type ssh password then hit enter twice (assuming sudo password is same as your user password)