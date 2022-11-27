#!/bin/bash
## Creates an ordinary non-root VNC_USER and calls the script to fix the file permissions

### every exit != 0 fails the script
set -e
set -u

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

        ### Creates the group only if it does not exist yet
        echo "Creating group $UGROUP if needed"
        groupadd -f $UGROUP

        ### Returns "0" if the user exists, or "1" otherwise
        missing_user=$(id -u $UNAME > /dev/null 2>&1; echo $?)

        if [[ $missing_user != 0 ]] ; then
            echo "Creating non-root user \"$VNC_USER\"."
            useradd --no-log-init --gid $UGROUP --home-dir $HOME --shell /bin/bash --password $VNC_PW $UNAME
        fi
    else
        echo "Will not create root user \"$VNC_USER\"."
    fi
fi

FIXING="Fixing permissions: "

for var in "$@"
do
    echo "$FIXING $var"
    find "$var"/ -name '*.sh' -exec chmod a+x {} +
    find "$var"/ -name '*.desktop' -exec chmod a+x {} +
    
    ### folder and its content belong to the group zero (recursively)
    chgrp -R 0 "$var" && chmod -R -v a+rw "$var" && find "$var" -type d -exec chmod -v a+x {} +
done
