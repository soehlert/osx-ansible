#!/bin/sh

type brew >/dev/null 2>&1 || /bin/bash ./roles/homebrew/files/install-homebrew.sh
type ansible >/dev/null 2>&1 || /usr/local/bin/brew install ansible
ansible-galaxy install -r requirements.yml
