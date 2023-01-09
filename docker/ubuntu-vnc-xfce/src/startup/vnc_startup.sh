#!/bin/bash
### every exit != 0 fails the script
set -e
#set -u     # do not use

## print out help
help (){
echo "
USAGE:
docker run <run-options> accetto/<image>:<tag> <option> <optional-command>

IMAGES:
accetto/ubuntu-vnc-xfce

TAGS:
latest      based on 'latest' Ubuntu
rolling     based on 'rolling' Ubuntu

OPTIONS:
-w, --wait      (default) Keeps the UI and the vnc server up until SIGINT or SIGTERM are received.
                An optional command can be executed after the vnc starts up.
                example: docker run -d -P accetto/ubuntu-vnc-xfce
                example: docker run -it -P --rm accetto/ubuntu-vnc-xfce bash

-s, --skip      Skips the vnc startup and just executes the provided command.
                example: docker run -it -P --rm accetto/ubuntu-vnc-xfce --skip echo $BASH_VERSION

-d, --debug     Executes the vnc startup and tails the vnc/noVNC logs.
                Any parameters after '--debug' are ignored. CTRL-C stops the container.
                example: docker run -it -P --rm accetto/ubuntu-vnc-xfce --debug

-t, --tail-log  same as '--debug'

-h, --help      Prints out this help.
                example: docker run --rm accetto/ubuntu-vnc-xfce

Fore more information see: https://github.com/accetto/ubuntu-vnc-xfce
"
}
if [[ $1 =~ -h|--help ]]; then
    help
    exit 0
fi

### '.bashrc' will also source '$STARTUPDIR/generate_container_user'
### (see 'stage-final' in Dockerfile)
source "${HOME}"/.bashrc

### add `--skip` to startup args, to skip the VNC startup procedure
if [[ $1 =~ -s|--skip ]]; then
    echo "Skip VNC startup"
    echo "Executing command: '${@:2}'"
    exec "${@:2}"
fi

if [[ $1 =~ -d|--debug ]]; then
    echo "Debug VNC startup"
    export DEBUG=true
fi

### correct forwarding of shutdown signal
cleanup () {
    kill -s SIGTERM $!
    exit 0
}
trap cleanup SIGINT SIGTERM

### resolve_vnc_connection
VNC_IP=$(hostname -i)

if [[ ${DEBUG} ]] ; then
    echo "DEBUG:"
    id
    echo "DEBUG: ls -la /"
    ls -la /
    echo "DEBUG: ls -la ."
    ls -la .
fi

### change vnc password
### first entry is control, second is view (if only one is valid for both)
mkdir -p "${HOME}"/.vnc
PASSWD_PATH="${HOME}/.vnc/passwd"

if [[ "${VNC_VIEW_ONLY}" == "true" ]]; then
    echo "Start VNC server in view only mode"
    ### create random pw to prevent access
    echo $(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 20) | vncpasswd -f > "${PASSWD_PATH}"
fi

echo "${VNC_PW}" | vncpasswd -f >> "${PASSWD_PATH}"
chmod 600 "${PASSWD_PATH}"

### start vncserver and noVNC webclient in the background
echo "Starting noVNC"
"${NO_VNC_HOME}"/utils/novnc_proxy --vnc localhost:${VNC_PORT} --listen ${NO_VNC_PORT} &> "${STARTUPDIR}"/no_vnc_startup.log &
PID_SUB=$!

echo "Starting VNC server ..."
echo "... remove old VNC locks to be a reattachable container"
vncserver -kill ${DISPLAY} &> "${STARTUPDIR}"/vnc_startup.log \
    || rm -rfv /tmp/.X*-lock /tmp/.X11-unix &> "${STARTUPDIR}"/vnc_startup.log \
    || echo "... no locks present"

echo "... VNC params: VNC_COL_DEPTH=${VNC_COL_DEPTH}, VNC_RESOLUTION=${VNC_RESOLUTION}"
echo "... VNC params: VNC_BLACKLIST_TIMEOUT=${VNC_BLACKLIST_TIMEOUT}, VNC_BLACKLIST_THRESHOLD=${VNC_BLACKLIST_THRESHOLD}"
vncserver ${DISPLAY} -depth ${VNC_COL_DEPTH} -geometry ${VNC_RESOLUTION} \
    -BlacklistTimeout ${VNC_BLACKLIST_TIMEOUT} \
    -BlacklistThreshold ${VNC_BLACKLIST_THRESHOLD} &> "${STARTUPDIR}"/no_vnc_startup.log

### log connect options
echo "... VNC server started on display ${DISPLAY}"
echo "Connect via VNC viewer with ${VNC_IP}:${VNC_PORT}"
echo "Connect via noVNC with http://${VNC_IP}:${NO_VNC_PORT}"

if [[ ${DEBUG} == true ]] || [[ $1 =~ -t|--tail-log ]]; then
    echo "Display log: ${HOME}/.vnc/*${DISPLAY}.log"
    ### if option `-t` or `--tail-log` block the execution and tail the VNC log
    tail -f "${STARTUPDIR}"/*.log "${HOME}"/.vnc/*"${DISPLAY}".log
fi

if [ -z "$1" ] || [[ $1 =~ -w|--wait ]]; then
    wait ${PID_SUB}
else
    ### unknown option ==> call command
    echo "Executing command: '$@'"
    exec "$@"
fi
