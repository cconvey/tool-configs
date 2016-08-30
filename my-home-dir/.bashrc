HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S: '
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'

export PATH
PATH+=~/bin:${PATH}
PATH=/home/cconvey/repos/llvm-git/llvm.install-3.9-relwithdebinfo/bin:${PATH}

alias ll="ls -l"
alias lla="ls -la"

export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on"

export VISUAL=/usr/bin/vim

# export LESS="-SN"

ulimit -c unlimited

export
