#!/usr/bin/python

from ansible.module_utils.basic import AnsibleModule
import os.path
import glob
from shutil import copytree, rmtree

# reference

VISCOSITY_DATA = os.path.expanduser("~/Library/Application Support/Viscosity/OpenVPN")

ANSIBLE_METADATA = {
    'metadata_version': '1.1',
    'status': ['preview'],
    'supported_by': 'community'
}

DOCUMENTATION = '''
---
module: viscosity_profile

short_description: Install a Viscosity profile

version_added: "2.4"

description:
    - "Install a Viscosity profile"

options:
    name:
        description:
            - This is the name of the profile to install
        required: true
    src:
        description:
            - Source directory of the profile to install.  All files in this directory will be copied to the destination.
    state:
        description:
            - Either present or 
        required: true

author:
    - Jon M. Dugan (@jdugan)
'''

EXAMPLES = '''
- name: Install a profile called foo
  viscosity_profile:
    name: 'foo'
    src: /path/to/profile
    state: present

- name: Remove a profile called foo
  viscosity_profile:
    name: 'foo'
    state: absent
'''

RETURN = '''
message:
    description: A description of what action was taken
'''

def get_config_key(path, key):
    """Extract config key from Viscosity configs"""
    with open(path) as f:
        for line in f.readlines():
            if line.startswith("#viscosity"):
                _, name, value = line.split()
                if name == key:
                    return value
    return None

def get_existing_configs():
    """Get a list of currently installed Viscosity configs."""
    existing_configs = glob.glob("{}/*/config.conf".format(VISCOSITY_DATA))

    return { get_config_key(conf, "name"): conf for conf in existing_configs if conf }

def install_config(name, src, check_mode=False):
    """Install a Viscosity config."""
    # TODO: should check checksum of files to see if they differ from source and update
    existing = get_existing_configs()
    already_installed = name in existing

    if already_installed:
        return None, False, "{} already present".format(name)

    current_configs = [int(x) for x in os.listdir(VISCOSITY_DATA)]
    if current_configs:
        next_config = str(max(current_configs) + 1)
    else:
        next_config = "1"

    next_config = os.path.join(VISCOSITY_DATA, next_config)

    if not os.path.exists(src):
        return "{} does not exist".format(src), False, None

    if check_mode:
        return None, False, "would {} install in {}".format(name, next_config)
    else:
        copytree(src, next_config)
        return None, True, "{} installed in {}".format(name, next_config)

def remove_config(name, check_mode=False):
    """Remove a Viscosity config."""
    existing = get_existing_configs()
    already_installed = name in existing

    if already_installed:
        config_path = existing[name]
        config_dir = os.path.dirname(config_path)
        if check_mode:
            return None, False, "would remove {} from {}".format(name, config_dir)
        else:
            rmtree(config_dir)
            return None, True, "removed {} from {}".format(name, config_dir)
    else:
        return None, False, "{} already absent".format(name)


def run_module():
    module_args = {
        "name": { "type": 'str',  "required": True },
        "src": { "type": 'str', "required": False },
        "state": {
            "default": "present",
            "choices": ['present', 'absent'],
            "type": 'str'
        },
    }

    result =  {
        "changed": False,
        "message": "",
    }

    module = AnsibleModule(argument_spec=module_args, supports_check_mode=True)

    if module.params["state"] == "present" and not module.params["src"]:
        module.fail_json(msg="Must specify src if state='present'")
        return

    check_mode = module.check_mode
    name = module.params["name"]
    state = module.params["state"]
    src = module.params["src"]

    if state == "present":
        error, changed, success = install_config(name, src, check_mode=check_mode)
    elif state == "absent":
        error, changed, success = remove_config(name, check_mode=check_mode)
    else:
        error = "unknown state '{}'".format(state)
        changed = False
        success = False

    if error:
        module.fail_json(msg=error)
    else:
        result["changed"] = changed
        result["message"] = success
        module.exit_json(**result)

def main():
    run_module()

if __name__ == '__main__':
    main()
