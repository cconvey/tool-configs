#!/bin/bash

if [[ $# -ne 2 ]]; then
    echo "Expected exactly 2 arguments, but got $#.  Cmd-line = '${@}'" >&2
    exit 1
fi

declare REMOTE_NAME="${1}"
declare REMOVE_LOCATION="${2}"

while read -r -a STDIN_ARGS; do
    if [[ ${#STDIN_ARGS[@]} -ne 4 ]]; then
        echo >&2 "Unexpected input format on stdin: ${STDIN_ARGS[@]}"
        exit 1
    fi

    declare LOCAL_REF="${STDIN_ARGS[0]}"
    declare LOCAL_SHA1="${STDIN_ARGS[1]}"
    declare REMOTE_REF="${STDIN_ARGS[2]}"
    declare REMOVE_SHA1="${STDIN_ARGS[3]}"

    declare REMOTE_DEFAULT_BRANCH="$(git branch -r | grep origin/HEAD | sed -rn 's/.* -> origin\/(.*)$/\1/p')"

    echo "REMOTE_NAME     = '${REMOTE_NAME}'"
    echo "REMOVE_LOCATION = '${REMOVE_LOCATION}'"
    echo "LOCAL_REF       = '${LOCAL_REF}'"
    echo "LOCAL_SHA1      = '${LOCAL_SHA1}'"
    echo "REMOTE_REF      = '${REMOTE_REF}'"
    echo "REMOVE_SHA1     = '${REMOVE_SHA1}'"
done


exit 0

