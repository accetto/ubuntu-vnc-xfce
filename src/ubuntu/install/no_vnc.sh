#!/bin/bash
### every exit != 0 fails the script
set -e
set -u

echo "Install noVNC - HTML5 based VNC viewer"
mkdir -p $NO_VNC_HOME/utils/websockify
wget -qO- https://github.com/novnc/noVNC/archive/v1.0.0.tar.gz | tar xz --strip 1 -C $NO_VNC_HOME

## Use older version of websockify to prevent hanging connections on offline containers, see https://github.com/ConSol/docker-headless-vnc-container/issues/50
wget -qO- https://github.com/novnc/websockify/archive/v0.6.1.tar.gz | tar xz --strip 1 -C $NO_VNC_HOME/utils/websockify
chmod +x -v $NO_VNC_HOME/utils/*.sh

## Create index.html to forward automatically to lite or full noVNC client
#ln -s $NO_VNC_HOME/vnc_lite.html $NO_VNC_HOME/index.html
#ln -s $NO_VNC_HOME/vnc.html $NO_VNC_HOME/index.html

## Create index.html to choose noVNC client
cp $INST_SCRIPTS/no_vnc_index.html $NO_VNC_HOME/index.html
