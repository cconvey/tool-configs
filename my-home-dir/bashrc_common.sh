# This is meant to be sourced into a ~/.bashrc file.
# It contains statements that should be common for all of my machines.

declare THIS_SCRIPT_DIR="$(readlink -f $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ) )"

export PATH=${HOME}/bin:${PATH}

# append to the history file, don't overwrite it
shopt -s histappend

HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S: '

export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): } '

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

alias ll="ls -l --color=auto"
alias lla="ls -la --color=auto"

export VISUAL=/usr/bin/vim
ulimit -c unlimited

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

unset -v THIS_SCRIPT_DIR

