declare THIS_SCRIPT_DIR="$(readlink -f $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ) )"

export PATH+=${THIS_SCRIPT_DIR}/bin:${PATH}

HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S: '

export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): } '

alias ll="ls -l"
alias lla="ls -la"

export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on"
export VISUAL=/usr/bin/vim

ulimit -c unlimited

alias find_h='/usr/bin/find -regextype posix-extended -regex ".*\.(c|cc|cpp|h)"'
alias find_src='/usr/bin/find -regextype posix-extended -regex ".*\.(c|cc|cpp)"'
alias find_h_and_src='/usr/bin/find -regextype posix-extended -regex ".*\.h"'

unset -v THIS_SCRIPT_DIR
