#!/bin/bash

# Get relevant application lists
source config/manifest.sh

YUM_CMD=$(which yum)
APT_CMD=$(which apt)
PACMAN_CMD=$(which pacman)

function backup_dotfiles {
    # Create backups of all dotfiles to be edited
    
    # TODO: Change these cp to mv
    # TODO: Check whether any of these fail (eg neofetch) due to the program not being installed
    # TODO: If any failed due to above, re-run the backups after pkg_check_and_install
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
    echo $HOST | figlet -f slant > ssh_banner.txt
}

function make_motd {
    cat << EOF > motd
    #!/bin/bash
    echo "Through me you pass into the city of woe:"
    echo "Through me you pass into eternal pain:"
    echo "Through me amoung the people lost for aye."
    echo "Justice the founder of my fabric mov'd:"
    echo "To rear me was the task of power divine,"
    echo "Supremest wisdom, and primeval love."
    echo "Before me things create were none, save things"
    echo "Eternal, and eternal I endure."
    echo "All hope abandon ye who enter here."
EOF
}

function make_neofetch {
    cat << EOF > neofetch
    echo '    print_info() {'
    echo '        info title'
    echo '        info local_ip'
    echo '        info uptime'
    echo '        info underline'
    echo ''
    echo '        info "os" distro'
    echo '        info "de" de'
    echo '        info "wm" wm'
    echo '        info "wm theme" wm_theme'
    echo '        info "terminal" term'
    echo '        info "shell" shell'
    echo '        info "font" term_font'
    echo '        info underline'
    echo ''
    echo '        info "cpu" cpu'
    echo '        info "cpu" cpu_usage'
    echo '        info "gpu" gpu'
    echo '        info "aforementioned driver" gpu_driver'
    echo '        info "disk" disk'
    echo '        info "ram" memory'
    echo '        info "resolution" resolution'
    echo '        info underline'
    echo ''
    echo '        info "public ip" public_ip'
    echo '    }'
    echo ''
    echo '    title_fqdn="off"'
    echo '    uptime_shorthand="off"'
    echo '    public_ip_host="http://ident.me"'
    echo '    public_ip_timeout=2'
    echo '    disk_show=('/')'
    echo '    disk_subtitle="dir"'
    echo '    disk_percent="on"'
    echo '    music_player="auto"'
    echo '    song_format='%artist% - %album% - %title%''
    echo '    song_shorthand="off"'
    echo '    mpc_args=()'
    echo ''
    echo '    # TEXT'
    echo '    colors=(4 6 4 8 4 6)'
    echo '    bold="off"'
    echo '    underline_enabled="on"'
    echo '    underline_char="+"'
    echo '    separator="+"'
    echo ''
    echo '    block_range=(0 9)'
    echo '    color_blocks="off"'
    echo '    block_width=3'
    echo '    block_height=1'
    echo '    col_offset="auto"'
    echo ''
    echo '    bar_char_elapsed="+"'
    echo '    bar_char_total="-"'
    echo '    bar_border="on"'
    echo '    bar_length=10'
    echo '    bar_color_elapsed="4"'
    echo '    bar_color_total="4"'
    echo ''
    echo '    # INFO'
    echo '    cpu_display="barinfo"'
    echo '    memory_display="barinfo"'
    echo '    battery_display="off"'
    echo '    disk_display="barinfo"'
    echo ''
    echo '    # IMAGE'
    echo '    image_backend="ascii"'
    echo '    image_source="ascii"'
    echo '    ascii_distro="auto"'
    echo '    ascii_colors=(4 8)'
    echo '    ascii_bold="on"'
    echo '    image_loop="off"'
    echo '    crop_mode="normal"'
    echo '    crop_offset="center"'
    echo '    image_size="35%"'
    echo '    gap=2'
    echo '    yoffset=0'
    echo '    xoffset=0'
    echo '    background_color='
    echo '    '
    echo '    # STDOUT'
    echo '    stdout="off"'
EOF
}

function make_dotfiles {
    make_motd
    make_neofetch
    make_banner
    # bashrc
    cp bashrc.txt ~/.bashrc
    # TODO: Make sure we have zsh, and perhaps even oh-my-zsh if we can automate it
    # zshrc
    cp zshrc.txt ~/.zshrc
    # motd

}

backup_dotfiles
pkg_check_and_install
make_banner
make_motd
make_dotfiles