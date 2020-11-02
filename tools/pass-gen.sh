#!/bin/bash
LEN=8
for i in $(seq 1 $2); do
    if [[ ! -z "$1" ]]; then
        LEN=$1
    fi
    case $LEN in
        ''|*[!0-9]*) echo Number needed;;
        *) 
        echo `tr -cd '[:alnum:][:punct:]' < /dev/urandom | head -c$LEN` ;;
    esac
done
