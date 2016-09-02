#!/bin/bash

# This script is meant to be run on the new workstation.


function install_powerline {
    aptitude install    \
        build-essential \
        python-pip      \
        git

    pushd ~/repos
    git clone https://github.com/libgit2/libgit2
    mkdir libgit2.build
    cd libgit2.build
    make all
    make install
    popd

    pip install --upgrade psutil
    pip install --upgrade pygit2
    pip install --upgrade powerline-status

    # Install the desired font...
    mkdir /tmp/powerline-font-install
    pushd /tmp/powerline-font-install
    wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
    wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
    mkdir -p ~/.fonts
    mv *.otf ~/.fonts/
    fc-cache -vf ~/.fonts/
    mkdir -p ~/.config/fontconfig/conf.d/
    mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
    popd

    # Integrate it into Vim...
    # This is done by modifying the .vimrc file to contain these lines:
    #
    # python from powerline.vim import setup as powerline_setup
    # python powerline_setup()
    # python del powerline_setup
    # set laststatus=2

    # Integrate it into Bash...
    # Add these lines to ~/.bashrc :
    #
    # declare POWERLINE_REPOSITORY_ROOT=$(pip show powerline-status | grep Location: | sed 's/Location: //')
    # declare POWERLINE_BASH_CONTINUATION=1
    # declare POWERLINE_BASH_SELECT=1
    # source ${POWERLINE_REPOSITORY_ROOT}/powerline/bindings/bash/powerline.sh

}



declare -a VIM_POWERLINE_APT_PACKAGES=(

    )

declare -a VIM_POWERLINE_PIP_PACKAGES=(
    #git+git://github.com/Lokaltog/powerline
    psutil
    pygit2
    )
declare -a VIM_APT_PACKAGES=(
    python-pip # For powerline
    git

    )


# TODO: Add symlinks related to config files / scripts stored in this repo.

# TODO: add packages and do apt-file udpate

# TODO: Install Vundle

# TODO: enable inbound ssh

# TODO: establish SSH credentials with spaceman

# TODO: copy spaceman's ssh config file

# TODO: copy ~cconvey/.config/chromium --> new laptop

# TODO: add icons and/or scripts for launching chromium with the particular user I want

# TODO: setup repo clones

# TODO: copy / sync scripts (via scratch repo?)

# TODO: setup .gitrc files as appropriate
# git config --global core.excludesfile ~/.gitignore_global

