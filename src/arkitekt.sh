#!/bin/bash

# Get relevant application lists
source config/manifest.sh

YUM_CMD=$(which yum)
APT_CMD=$(which apt)
PACMAN_CMD=$(which pacman)

function backup_dotfiles {
    # Create backups of all dotfiles to be edited
    
    # TODO: Change these cp to mv
    cp /etc/motd /src/backups/motd.bak
    cp /etc/ssh/banner /src/backups/banner.bak
    cp /etc/ssh/ssh_config /src/backups/ssh_config.bak
    cp /etc/ssh/sshd_config /src/backups/sshd_config.bak
    cp ~/.zshrc /src/backups/.zshrc.bak
    cp ~/.bashrc /src/backups/.bashrc.bak
    cp ~/.config/neofetch /src/backups/.neofetch.bak
}

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
backup_dotfiles
