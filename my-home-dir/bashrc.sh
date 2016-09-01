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

alias find_h="/usr/bin/find -name '*.h'"
alias find_src='/usr/bin/find -regextype posix-extended -regex ".*\.(c|cc|cpp)"'
alias find_h_and_src='/usr/bin/find -regextype posix-extended -regex ".*\.(c|cc|cpp|h)"'
alias find_o="/usr/bin/find -name '*.o'"

export GREP_OPTIONS='-n --color'

declare POWERLINE_DAEMON
if POWERLINE_DAEMON=$(which powerline-daemon 2>/dev/null); then
    powerline-daemon -q || true

    declare POWERLINE_REPOSITORY_ROOT
    if POWERLINE_REPOSITORY_ROOT=$(pip show powerline-status | env -u GREP_OPTIONS grep Location: | sed 's/Location: //'); then
        if [[ ! -z "${POWERLINE_REPOSITORY_ROOT}" ]]; then
            declare POWERLINE_BASH_SCRIPT=${POWERLINE_REPOSITORY_ROOT}/powerline/bindings/bash/powerline.sh
            if [[ -f  ${POWERLINE_BASH_SCRIPT} ]]; then
                declare POWERLINE_BASH_CONTINUATION=1
                declare POWERLINE_BASH_SELECT=1
                source ${POWERLINE_BASH_SCRIPT}
            fi
        fi
    fi
fi


unset -v THIS_SCRIPT_DIR
