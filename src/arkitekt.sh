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

function make_banner {

}

function make_dotfiles {
    # neofetch
    cp neofetch.txt ~/.config/neofetch/config.conf
    # ssh_banner
    make_banner
    # bashrc
    cp bashrc.txt ~/.bashrc
    # TODO: Make sure we have zsh, and perhaps even oh-my-zsh if we can automate it
    # zshrc
    cp zshrc.txt ~/.zshrc
    # motd

}

pkg_check_and_install
backup_dotfiles
make_dotfiles
