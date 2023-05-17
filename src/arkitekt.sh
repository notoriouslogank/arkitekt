#!/bin/bash

# Get relevant application lists
source config/manifest.sh

YUM_CMD=$(which yum)
APT_CMD=$(which apt)
PACMAN_CMD=$(which pacman)

function pkg_check_and_install {
# Determine which package manage is being used and
# install necessary packages
if [[ ! -z $APT_CMD ]]; then
    apt update && apt full-upgrade -y
    apt install $APT_PKG
elif [[ ! -z $PACMAN_CMD ]]; then
    pacman -Syu
    pacman -Su $PACMAN_PKG
elif [[ ! -z $YUM_CMD ]]; then
    yum install $YUM_PKG
else
    echo "ERROR: Can't install package(s). Verify correct package manager."
    exit 1;
fi
}

pkg_check_and_install