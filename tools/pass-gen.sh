#!/bin/bash
LEN=16
if [[ ! -z "$1" ]]; then
    LEN=$1
    shift 1
fi
for i in $(seq 1 $1); do
    case $LEN in
        ''|*[!0-9]*) echo Number needed;;
        *) 
        echo `tr -cd '[:alnum:][\.!@#$&*]' < /dev/urandom | head -c$LEN` ;;
    esac
done
