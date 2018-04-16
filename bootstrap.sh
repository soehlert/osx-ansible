#!/bin/sh

# shell script to bootstrap the system to the point that it has ansible
if [ ! -d /Library/Developer ]; then
    echo "Insalling Xcode first, then rerun this script"
    sleep 1
    xcode-select --install
else
   /bin/bash ./roles/homebrew/files/install-homebrew.sh
   /usr/local/bin/brew install ansible
fi
