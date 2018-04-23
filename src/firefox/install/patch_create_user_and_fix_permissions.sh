#!/bin/bash
### every exit != 0 fails the script
set -e
set -u

TARGET="$INST_SCRIPTS/create_user_and_fix_permissions.sh"
PATCH="$INST_SCRIPTS/patch_create_user_and_fix_permissions.txt"

cat $PATCH >> $TARGET
