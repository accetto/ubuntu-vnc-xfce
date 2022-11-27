#!/bin/bash
### every exit != 0 fails the script
set -e
#set -u     # do not use

echo "Current user:"
id

[[ -n $DEBUG ]] && _verbose="-v" || _verbose=""

for i in "$@"
do
    echo "Fixing permissions for: $i"

    ### all users are allowed to execute '*.sh' scripts in the folder (recursively)
    find "$i"/ -name '*.sh' -exec chmod $_verbose a+x {} +

    ### all users are allowed to execute launchers in the folder (recursively)
    find "$i"/ -name '*.desktop' -exec chmod $_verbose a+x {} +

    ### folder and its content belong to the group zero (recursively)
    chgrp -R 0 "$i"

    ### all users have write permissions to the folder content (recursively)
    chmod -R $_verbose a+rw "$i"

    ### all users have execute permissions to all folder directories (recursively)
    find "$i" -type d -exec chmod $_verbose a+x {} +
done