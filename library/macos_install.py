#!/usr/bin/python

"""
Custom module for the macos_install Ansible role to install
software packed in the .dmg format.

@author: pipersniper
"""

from ansible.module_utils.basic import *
import subprocess
import shutil
import os


def install_app(appfile, mount_path, new_path, force):

    wd = os.getcwd()
    changed = True
    os.chdir(mount_path)
    copy_dir = '/Applications/{}'.format(appfile)
    already_installed = os.path.exists(copy_dir)

    if already_installed and force:
        shutil.rmtree(copy_dir)
        shutil.copytree(appfile, copy_dir)
        meta = dict(
            reinstalled=True,
            state='present'
        )
    elif already_installed and not force:
        changed = False
        meta = dict(
            reinstalled=False,
            state='present'
        )
    else:
        shutil.copytree(appfile, copy_dir)
        meta = dict(
            state='present'
        )

    os.chdir(wd)
    subprocess.call(['hdiutil', 'detach', mount_path])
    subprocess.call(['rm', new_path])

    return changed, meta


def install_pkg_from_app(appfile, mount_path, new_path, force):

    wd = os.getcwd()
    changed = True
    os.chdir('{}/{}/Contents'.format(mount_path, appfile))
    pkgs = [s for s in os.listdir(os.getcwd()) if ".pkg" in s]
    if len(pkgs) == 1:
        subprocess.call(['sudo', 'installer', '-pkg',
                         pkgs[0], '-target', '/'])
        os.chdir(wd)
        subprocess.call(['hdiutil', 'detach', mount_path])
        subprocess.call(['rm', new_path])
        meta = dict(
            reinstalled=False,
            state='present'
        )
        return changed, meta
    else:
        os.chdir(wd)
        subprocess.call(['hdiutil', 'detach', mount_path])
        subprocess.call(['rm', new_path])
        changed=False
        meta = dict(
            state='absent'
        )
        return changed, meta


def install(data):

    path_to_dmg = data['dmg_path']
    name = data['app_name']
    new_path = '{}.cdr'.format(name)
    force = data['force']

    # Convert dmg to avoid potential EULA splash before mounting

    subprocess.call(['hdiutil', 'convert', path_to_dmg, '-format',
                     'UDTO', '-o', name])

    # Because the mount path does not always follow the same naming convention
    # as the data['app_name'] field, track all files in /Volumes to ensure
    # that the new Volume can be found after calling hdiutil attach.

    default_volumes = [v for v in os.listdir('/Volumes')]

    # Mount dmg

    subprocess.call(['hdiutil', 'attach', new_path])

    # Find the mount path. Only one new volume should exist, so use
    # volumes[0]

    volumes = [v for v in os.listdir('/Volumes') if v not in
               default_volumes]
    mount_path = '/Volumes/{}'.format(volumes[0])

    # Inspect mounted image.

    files = [f for f in os.listdir(mount_path)]

    # This version only handles copying one app to the /Applications folder,
    # or getting a .pkg installer from an Install.app bundle.
    # Need to handle zip installs and other edge cases.

    matching = [s for s in files if ".app" in s]
    if len(matching) == 1:
        changed, meta = install_app(matching[0], mount_path, new_path, force)
        return changed, meta


    elif len(matching) > 1:
        for f in matching:
            if f == "Install.app":
                changed, meta = install_pkg_from_app(f, mount_path, new_path,
                                                    force)
                return changed, meta

        changed = False
        meta = dict(
            state='absent'
        )

    else:
        changed = False
        meta = dict(
            state='absent',
            msg='More than one .app or no .app files are found in the image!'
        )
    return changed, meta


def uninstall(data):

    installed_name = data['installed_name']
    app_path = '/Applications/{}'.format(installed_name)
    installed = os.path.exists(app_path)
    changed = False

    if installed:
        # Delete .app
        subprocess.call(['rm', '-rf', app_path])
        changed = True
        meta = dict(
            state='absent'
        )
    else:
        meta = dict(
            state='absent'
        )

    return changed, meta


def main():

    amodule = AnsibleModule(
        argument_spec=dict(
            app_name=dict(required=True, type='str'),
            dmg_path=dict(required=True, type='str'),
            force=dict(default=False, type='bool'),
            installed_name=dict(default='no_path', type='str'),
            state=dict(choices=['present', 'absent'],
                       type='str')
        )
    )

    choice_map = dict(
        present=install,
        absent=uninstall
    )

    has_changed, result = choice_map.get(amodule.params['state'])(amodule.params)
    amodule.exit_json(changed=has_changed, meta=result)

if __name__ == '__main__':
    main()
