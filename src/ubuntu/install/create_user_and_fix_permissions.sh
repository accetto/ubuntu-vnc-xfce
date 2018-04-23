#!/bin/bash
## Creates an ordinary non-root VNC_USER and calls the script to fix the file permissions

### every exit != 0 fails the script
set -e
#set -u     # do not use!

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

FIXING="Fixing permissions: "

for var in "$@"
do
    echo "$FIXING $var"
    find "$var"/ -name '*.sh' -exec chmod a+x {} +
    find "$var"/ -name '*.desktop' -exec chmod a+x {} +
    
    ### Not root any more. It's assumed that the user and its group names are identical.
    #chgrp -R 0 "$var" && chmod -R -v a+rw "$var" && find "$var" -type d -exec chmod -v a+x {} +
    chgrp -R $UGROUP $var && chmod -R a+rw $var && find $var -type d -exec chmod a+x {} +
done

LIST="$HOME/Desktop $HOME/Documents $HOME/Downloads"
for var in $LIST
do
    if [[ -d "$var" ]] ; then
        echo "$FIXING $var"
        chown -R $UNAME:$UGROUP $var
        chmod -R 755 $var
    fi
done
