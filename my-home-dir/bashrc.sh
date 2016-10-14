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
alias find_c='/usr/bin/find -regextype posix-extended -regex ".*\.(c|cc|cpp)"'
alias find_hc='/usr/bin/find -regextype posix-extended -regex ".*\.(c|cc|cpp|h)"'
alias find_o="/usr/bin/find -name '*.o'"

alias search_c='/usr/bin/find -regextype posix-extended -regex ".*\.(c|cc|cpp)" | xargs grep -n --color'
alias search_h='/usr/bin/find -regextype posix-extended -regex ".*\.(h)" | xargs grep -n --color'
alias search_ch='/usr/bin/find -regextype posix-extended -regex ".*\.(c|cc|cpp|h)" | xargs grep -n --color'

export GREP_OPTIONS='--color'

function find_powerline_daemon {
    if which powerline-daemon 2>/dev/null; then
        return 0
    else
        return 1
    fi
}

function find_powerline_bash_script {
    local POWERLINE_REPOSITORY_ROOT
    if ! POWERLINE_REPOSITORY_ROOT=$(
        pip show powerline-status            2>/dev/null |
        env -u GREP_OPTIONS grep "Location:" 2>/dev/null |
        sed 's/Location: //'                 2>/dev/null
        ) 2>/dev/null ;
    then
        return 1
    fi

    if [[ -z "${POWERLINE_REPOSITORY_ROOT}" ]]; then
        return 1
    fi

    local POWERLINE_BASH_SCRIPT=${POWERLINE_REPOSITORY_ROOT}/powerline/bindings/bash/powerline.sh
    if [[ ! -f  ${POWERLINE_BASH_SCRIPT} ]]; then
        return 1
    fi

    echo "${POWERLINE_BASH_SCRIPT}"
    return 0
}

function setup_powerline {
    local POWERLINE_DAEMON
    if ! POWERLINE_DAEMON=$(find_powerline_daemon); then
        return 1
    fi

    local POWERLINE_BASH_SCRIPT
    if ! POWERLINE_BASH_SCRIPT=$(find_powerline_bash_script); then
        return 1
    fi

    "${POWERLINE_DAEMON}" -q || true

    declare -g POWERLINE_BASH_CONTINUATION=1
    declare -g POWERLINE_BASH_SELECT=1
    source ${POWERLINE_BASH_SCRIPT}
    return 0
}

#setup_powerline || true

unset -v THIS_SCRIPT_DIR

