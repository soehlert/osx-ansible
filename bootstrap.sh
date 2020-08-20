#!/bin/sh

# shell script to bootstrap the system to the point that it has ansible
 type brew >/dev/null 2>&1 || /bin/bash ./roles/homebrew/files/install-homebrew.sh
 type ansible >/dev/null 2>&1 || /usr/local/bin/brew install ansible
