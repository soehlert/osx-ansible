#!/bin/sh

eval "$(/opt/homebrew/bin/brew shellenv)"
type ansible >/dev/null 2>&1 || brew install ansible
ansible-galaxy install -r requirements.yml
