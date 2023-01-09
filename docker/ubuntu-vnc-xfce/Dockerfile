# syntax=docker/dockerfile:experimental

# ./hooks/build latest
# ./hooks/test latest

### Example: Build and test 'dev' tag locally like
### ./hooks/build dev
### ./hooks/test dev
### or with additional arguments
### ./hooks/build dev --no-cache
### ./hooks/test dev
### or using the utility
### ./utils/util-hdx.sh Dockerfile 1
### ./utils/util-hdx.sh Dockerfile 2
### The last output line should be '+ exit 0'
### If '+ exit 1' then adjust the version sticker
### variables in script './hooks/env'

ARG BASETAG=18.04

FROM ubuntu:${BASETAG} as stage-ubuntu

ARG ARG_VCS_REF
ARG ARG_VERSION_STICKER

LABEL \
    maintainer="https://github.com/accetto" \
    vendor="accetto" \
    version-sticker="${ARG_VERSION_STICKER}" \
    org.label-schema.vcs-ref="${ARG_VCS_REF}" \
    org.label-schema.vcs-url="https://github.com/accetto/ubuntu-vnc-xfce"

### 'apt-get clean' runs automatically
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        inetutils-ping \
        lsb-release \
        net-tools \
        unzip \
        vim \
        zip \
        curl \
        git \
        wget \
        nano \
    && rm -rf /var/lib/apt/lists/*

### install current 'jq' explicitly
RUN \
    { \
    JQ_VERSION="1.6" ; \
    JQ_DISTRO="jq-linux64" ; \
    cd /tmp ; \
    wget -q "https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/${JQ_DISTRO}" ; \
    wget -q "https://raw.githubusercontent.com/stedolan/jq/master/sig/v${JQ_VERSION}/sha256sum.txt" ; \
    test=$(grep "${JQ_DISTRO}" sha256sum.txt | sha256sum -c | grep -c "${JQ_DISTRO}: OK") ; \
    if [[ $test -ne 1 ]] ; then \
        echo "FAILURE: ${JQ_DISTRO} failed checksum test" ; \
        exit 1 ; \
    else \
        rm sha256sum.txt ; \
        chown root "${JQ_DISTRO}" ; \
        chmod +x "${JQ_DISTRO}" ; \
        # mv -f "${JQ_DISTRO}" $(which jq) ; \
        mv -f "${JQ_DISTRO}" /usr/bin/jq ; \
    fi ; \
    cd - ; \
    }

### next ENTRYPOINT command supports development and should be overriden or disabled
### it allows running detached containers created from intermediate images, for example:
### docker build --target stage-vnc -t dev/ubuntu-vnc-xfce:stage-vnc .
### docker run -d --name test-stage-vnc dev/ubuntu-vnc-xfce:stage-vnc
### docker exec -it test-stage-vnc bash
# ENTRYPOINT ["tail", "-f", "/dev/null"]

FROM stage-ubuntu as stage-xfce

ENV \
    LANG='en_US.UTF-8' \
    LANGUAGE='en_US:en' \
    LC_ALL='en_US.UTF-8'

### 'apt-get clean' runs automatically
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        mousepad \
        locales \
        supervisor \
        xfce4 \
        xfce4-terminal \
    && locale-gen en_US.UTF-8 \
    && apt-get purge -y \
        pm-utils \
        xscreensaver* \
    && rm -rf /var/lib/apt/lists/*

FROM stage-xfce as stage-vnc

### 'apt-get clean' runs automatically
### installed into '/usr/share/usr/local/share/vnc'
### Bintray has been deprecated and disabled since 2021-05-01 
# RUN wget -qO- https://dl.bintray.com/tigervnc/stable/tigervnc-1.10.1.x86_64.tar.gz | tar xz --strip 1 -C /
# RUN wget -qO- https://github.com/accetto/tigervnc/releases/download/v1.10.1-mirror/tigervnc-1.10.1.x86_64.tar.gz | tar xz --strip 1 -C /
RUN wget -qO- https://sourceforge.net/projects/tigervnc/files/stable/1.10.1/tigervnc-1.10.1.x86_64.tar.gz | tar xz --strip 1 -C /

FROM stage-vnc as stage-novnc

### same parent path as VNC
ENV NO_VNC_HOME=/usr/share/usr/local/share/noVNCdim

### 'apt-get clean' runs automatically
### 'python-numpy' used for websockify/novnc
### ## Use the older version of websockify to prevent hanging connections on offline containers, 
### see https://github.com/ConSol/docker-headless-vnc-container/issues/50
### installed into '/usr/share/usr/local/share/noVNCdim'
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        python-numpy \
    && mkdir -p "${NO_VNC_HOME}/utils/websockify" \
    && wget -qO- "https://github.com/novnc/noVNC/archive/v1.3.0.tar.gz" | tar xz --strip 1 -C "${NO_VNC_HOME}" \
    && wget -qO- "https://github.com/novnc/websockify/archive/v0.11.0.tar.gz" | tar xz --strip 1 -C "${NO_VNC_HOME}/utils/websockify" \
    && chmod +x -v "${NO_VNC_HOME}/utils/novnc_proxy" \
    && rm -rf /var/lib/apt/lists/*

### add 'index.html' for choosing noVNC client
RUN echo \
"<!DOCTYPE html>\n" \
"<html>\n" \
"    <head>\n" \
"        <title>noVNC</title>\n" \
"        <meta charset=\"utf-8\"/>\n" \
"    </head>\n" \
"    <body>\n" \
"        <p><a href=\"vnc_lite.html\">noVNC Lite Client</a></p>\n" \
"        <p><a href=\"vnc.html\">noVNC Full Client</a></p>\n" \
"    </body>\n" \
"</html>" \
> ${NO_VNC_HOME}/index.html

FROM stage-novnc as stage-wrapper

### 'apt-get clean' runs automatically
### Install nss-wrapper to be able to execute image as non-root user
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        gettext \
        libnss-wrapper \
    && rm -rf /var/lib/apt/lists/*

FROM stage-wrapper as stage-final

LABEL \
    any.accetto.description="Headless Ubuntu VNC/noVNC container with Xfce desktop" \
    any.accetto.display-name="Headless Ubuntu/Xfce VNC/noVNC container" \
    any.accetto.expose-services="6901:http,5901:xvnc" \
    any.accetto.tags="ubuntu, xfce, vnc, novnc"

### Arguments can be provided during build
ARG ARG_HOME
ARG ARG_REFRESHED_AT
ARG ARG_VERSION_STICKER
ARG ARG_VNC_BLACKLIST_THRESHOLD
ARG ARG_VNC_BLACKLIST_TIMEOUT
ARG ARG_VNC_PW
ARG ARG_VNC_RESOLUTION

ENV \
    DISPLAY=:1 \
    HOME=${ARG_HOME:-/home/headless} \
    NO_VNC_PORT="6901" \
    REFRESHED_AT=${ARG_REFRESHED_AT} \
    STARTUPDIR=/dockerstartup \
    VERSION_STICKER=${ARG_VERSION_STICKER} \
    VNC_BLACKLIST_THRESHOLD=${ARG_VNC_BLACKLIST_THRESHOLD:-20} \
    VNC_BLACKLIST_TIMEOUT=${ARG_VNC_BLACKLIST_TIMEOUT:-0} \
    VNC_COL_DEPTH=24 \
    VNC_PORT="5901" \
    VNC_PW=${ARG_VNC_PW:-headless} \
    VNC_RESOLUTION=${ARG_VNC_RESOLUTION:-1360x768} \
    VNC_VIEW_ONLY=false

### Creates home folder
WORKDIR ${HOME}

COPY [ "./src/startup", "${STARTUPDIR}/" ]

### Preconfigure Xfce
COPY [ "./src/home/Desktop", "./Desktop/" ]
COPY [ "./src/home/config/xfce4/panel", "./.config/xfce4/panel/" ]
COPY [ "./src/home/config/xfce4/xfconf/xfce-perchannel-xml", "./.config/xfce4/xfconf/xfce-perchannel-xml/" ]

### 'generate_container_user' has to be sourced to hold all env vars correctly
RUN echo 'source $STARTUPDIR/generate_container_user' >> ${HOME}/.bashrc

### Fix permissions
RUN chmod +x \
        "${STARTUPDIR}/set_user_permissions.sh" \
        "${STARTUPDIR}/vnc_startup.sh" \
        "${STARTUPDIR}/version_of.sh" \
        "${STARTUPDIR}/version_sticker.sh" \
    && gtk-update-icon-cache -f /usr/share/icons/hicolor \
    && "${STARTUPDIR}"/set_user_permissions.sh "${STARTUPDIR}" "${HOME}"    

EXPOSE ${VNC_PORT} ${NO_VNC_PORT}

### Issue #7: Mitigating problems with foreground mode
WORKDIR ${STARTUPDIR}
ENTRYPOINT ["./vnc_startup.sh"]
CMD [ "--wait" ]
