#!/bin/bash

#TODO: Prompt the user for this
BAK_DIR=/home/logank/repos/arkitekt/src/backups
# Get list of packages to install:
source config/manifest.sh

# Check which package manager we're using
YUM_CMD=$(which yum)
APT_CMD=$(which apt)
PACMAN_CMD=$(which pacman)

function backup_dotfiles {
    echo "Creating backups..."
    sudo cp /etc/ssh/ssh_config $BAK_DIR/ssh_config.bak
    echo "Backed up " + $BAK_DIR/ssh_config
    sudo cp /etc/ssh/sshd_config $BAK_DIR/sshd_config.bak
    echo "Backed up " + $BAK_DIR/sshd_config
    sudo cp /etc/motd $BAK_DIR/motd.bak
    echo "Backed up " + $BAK_DIR/motd
    sudo cp $HOME/.config/neofetch/config.conf $BAK_DIR/config.conf.bak
    echo "Backed up " + $BAK_DIR/.config.conf
    sudo cp $HOME/.bashrc $BAK_DIR/bashrc.bak
    echo "Backed up " + $BAK_DIR/.bashrc
    sudo cp $HOME/.zshrc $BAK_DIR/zshrc.bak
    echo "Backed up " + $BAK_DIR/.zshrc
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
    echo $USER | figlet -f slant > ssh_banner
}

function make_motd {
    cat << EOF > motd
    Through me you pass into the city of woe:
    Through me you pass into eternal pain:
    Through me amoung the people lost for aye.
    Justice the founder of my fabric mov'd:
    To rear me was the task of power divine,
    Supremest wisdom, and primeval love.
    Before me things create were none, save things
    Eternal, and eternal I endure.
    All hope abandon ye who enter here.
EOF
}

function make_neofetch {
    cat << EOF > neofetch
print_info() {
        info title
        info local_ip
        info uptime
        info underline

        info "os" distro
        info "de" de
        info "wm" wm
        info "wm theme" wm_theme
        info "terminal" term
        info "shell" shell
        info "font" term_font
        info underline
        info "cpu" cpu
        info "cpu" cpu_usage
        info "gpu" gpu
        info "aforementioned driver" gpu_driver
        info "disk" disk
        info "ram" memory
        info "resolution" resolution
        info underline
        info "public ip" public_ip
    }

title_fqdn="off"
uptme_shorthand="off"
public_ip_host="http://ident.me"
public_ip_timeout=2
disk_show=('/')
disk_subtitle="dir"
disk_percent="on"
music_player="auto"
song_format='%artist% - %album% - %title%'
song_shorthand="off"
mpc_args=()
    
# TEXT
colors=(4 6 4 8 4 6)
bold="off"
underline_enabled="on"
underline_char="+"
separator="+"
block_range=(0 9)
color_blocks="off"
block_width=3
block_height=1
col_offset="auto"
bar_char_elapsed="+"
bar_char_total="-"
bar_border="on"
bar_length=10
bar_color_elapsed="4"
bar_color_total="4"

 # INFO
cpu_display="barinfo"
memory_display="barinfo"
battery_display="off"
disk_display="barinfo"
    
# IMAGE
image_backend="ascii"
image_source="ascii"
ascii_distro="auto"
ascii_colors=(4 8)
ascii_bold="on"
image_loop="off"
crop_mode="normal"
crop_offset="center"
image_size="35%"
gap=2
yoffset=0
xoffset=0
background_color=

# STDOUT
stdout="off"
EOF
}

function make_dotfiles {
    make_motd
    make_neofetch
    make_banner
    # cp bashrc.txt ~/.bashrc
    # cp zshrc.txt ~/.zshrc
    # TODO: Make sure we have zsh, and perhaps even oh-my-zsh if we can automate it
}

backup_dotfiles
#pkg_check_and_install
make_dotfiles