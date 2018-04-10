#!/usr/bin/env bash
## Creates an ordinary non-root VNC_USER and calls the script to fix the file permissions
##!/bin/sh
## Warning about she-bang!
## Cannot use '/bin/sh' in Dockerfile, because the expansions are not supported.
## Therefore it also cannot be sourced there.
## Remark: Docker 1.12 and above support SHELL command, which could help.

### every exit != 0 fails the script
set -e
#set -u     # don't!

UNAME=0
UGROUP=0

if [[ -n "${VNC_USER}" ]] ; then
    case "$VNC_USER" in
        root|0)     UNAME=root; UGROUP=$UNAME;;                 # exact match
        root:*|0:*) UNAME=root; UGROUP=$UNAME;;                 # match from the beginning
        *:root|*:0) UNAME=root; UGROUP=$UNAME;;                 # match at the end
        *)          UNAME=${VNC_USER/%:*/}; UGROUP=${VNC_USER/#*:/};;   # else case
    esac
    if [[ "$UGROUP" != "" && "$UGROUP" != "root" ]] ; then
        echo "Creating non-root user $VNC_USER"
        groupadd $UGROUP
        echo "User goup $UGROUP created"
        useradd --no-log-init --gid $UGROUP --home-dir $HOME --shell /bin/bash --password $VNC_PW $UNAME
        echo "User $UNAME created"
    else
        echo "Will not create root user $VNC_USER"
    fi
fi

for var in "$@"
do
    echo "fix permissions for: $var"
    find "$var"/ -name '*.sh' -exec chmod -v a+x {} +
    find "$var"/ -name '*.desktop' -exec chmod -v a+x {} +
    
    # 2017-12-18: Not root any more. It's assumed that the user and its group names are identical.
    #chgrp -R 0 "$var" && chmod -R -v a+rw "$var" && find "$var" -type d -exec chmod -v a+x {} +
    chgrp -R $UGROUP "$var" && chmod -R -v a+rw "$var" && find "$var" -type d -exec chmod -v a+x {} +
done
