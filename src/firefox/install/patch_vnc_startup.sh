#!/bin/bash
### every exit != 0 fails the script
set -e
set -u

TARGET="$STARTUPDIR/vnc_startup.sh"
PATCH="$INST_SCRIPTS/patch_vnc_startup.txt"

LINE=$(grep -n 'set -u' $TARGET | cut -d ":" -f 1)
LINE=$(($LINE+1))

{ head -n $LINE $TARGET; cat $PATCH; tail -n +$LINE $TARGET; } > "$TARGET".patched
mv -f "$TARGET".patched "$TARGET"
