#!/bin/bash
## Creates an ordinary non-root VNC_USER and calls the script to fix the file permissions

### every exit != 0 fails the script
set -e
#set -u     # don't use!

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
    chgrp -R $UGROUP "$var" && chmod -R a+rw "$var" && find "$var" -type d -exec chmod a+x {} +
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

### only for image with Firefox
MOZILLA="$HOME/.mozilla"
FFOX="$MOZILLA/firefox"
if [[ -d "$MOZILLA" ]] ; then

    LIST="$MOZILLA $FFOX $FFOX/profile0.default"
    for var in $LIST
    do
        if [[ -d "$var" ]] ; then
            echo "$FIXING $var"
            chown -R $UNAME:$UGROUP $var
            chmod -R 700 $var
        fi
    done

    var="/usr/lib/firefox/browser/defaults/preferences/all-accetto.js"
    echo "$FIXING $var"
    chgrp $UGROUP "$var"
    chmod 664 "$var"

    ARRA=("$FFOX/profiles.ini" "$FFOX/user.js.txt" "$FFOX/profile0.default/user.js")
    ARRB=(644 600 600)
    MAXI=${#ARRA[@]}
    for (( i=0; i<=$MAXI; i++ ))
    do
        if [[ -f ${ARRA[$i]} ]] ; then
            echo "$FIXING ${ARRA[$i]}"
            chmod "${ARRB[$i]}" "${ARRA[$i]}"
        fi
    done
fi
