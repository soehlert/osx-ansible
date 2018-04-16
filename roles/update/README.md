Role Name
=========

Updates all packages it can on your host (OS, homebrew/cask, ruby gems, pip packages, npm, mac app store)

Requirements
------------

N/A

Role Variables
--------------

reboot: set to yes if you'd like to have your machine reboot automatically when it finds OS updates requiring reboots (defaults to false)

Dependencies
------------

N/A

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: update }

License
-------

BSD

Author Information
------------------

jdugan@es.net
soehlert@es.net
