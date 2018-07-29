declare THIS_SCRIPT_DIR="$(readlink -f $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ) )"

export PATH+=${THIS_SCRIPT_DIR}/bin:${PATH}

HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S: '

export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): } '

alias ll="ls -l --color=auto"
alias lla="ls -la --color=auto"

export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on"
export VISUAL=/usr/bin/vim

ulimit -c unlimited

unset -v THIS_SCRIPT_DIR

