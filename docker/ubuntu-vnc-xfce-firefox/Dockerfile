# ./hooks/build latest
# ./hooks/test latest

### Example: Build and test 'dev' tag locally like
### ./hooks/build dev
### ./hooks/test dev
### or with additional arguments
### ./hooks/build dev --no-cache
### ./hooks/test dev
### or using the utility
### ./utils/util-hdx.sh Dockerfile 3
### ./utils/util-hdx.sh Dockerfile 4
### The last output line should be '+ exit 0'
### If '+ exit 1' then adjust the version sticker
### variables in script './hooks/env'

ARG BASETAG=latest

FROM accetto/ubuntu-vnc-xfce:${BASETAG} as stage-install

### Be sure to use root user
USER 0

### 'apt-get clean' runs automatically
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        firefox \
    && rm -rf /var/lib/apt/lists/*

### Alternatively install an explicit Firefox version
### http://releases.mozilla.org/pub/firefox/releases/67.0.4/linux-x86_64/en-US/firefox-67.0.4.tar.bz2
# RUN \
#     FIREFOX_VERSION=67.0.4 \
#     FIREFOX_DISTRO=linux-x86_64 \
#     FIREFOX_PATH=/usr/lib/firefox \
#     && mkdir -p ${FIREFOX_PATH} \
#     && wget -qO- http://releases.mozilla.org/pub/firefox/releases/${FIREFOX_VERSION}/${FIREFOX_DISTRO}/en-US/firefox-${FIREFOX_VERSION}.tar.bz2 \
#         | tar xvj -C /usr/lib/ \
#     && ln -s ${FIREFOX_PATH}/firefox /usr/bin/firefox

FROM stage-install as stage-config

### Arguments can be provided during build
ARG ARG_VNC_USER

ENV VNC_USER=${ARG_VNC_USER:-headless:headless}

WORKDIR ${HOME}
SHELL ["/bin/bash", "-c"]

COPY [ "./src/create_user_and_fix_permissions.sh", "./" ]

### 'sync' mitigates automated build failures
RUN chmod +x \
        ./create_user_and_fix_permissions.sh \
    && sync \
    && ./create_user_and_fix_permissions.sh $STARTUPDIR $HOME \
    && rm ./create_user_and_fix_permissions.sh

FROM stage-config as stage-final

### Arguments can be provided during build
ARG ARG_REFRESHED_AT
ARG ARG_VCS_REF
ARG ARG_VERSION_STICKER
ARG ARG_VNC_BLACKLIST_THRESHOLD
ARG ARG_VNC_BLACKLIST_TIMEOUT
ARG ARG_VNC_RESOLUTION

LABEL \
    any.accetto.description="Headless Ubuntu VNC/noVNC container with Xfce desktop and Firefox" \
    any.accetto.display-name="Headless Ubuntu/Xfce VNC/noVNC container with Firefox" \
    any.accetto.tags="ubuntu, xfce, vnc, novnc, firefox" \
    version-sticker="${ARG_VERSION_STICKER}" \
    org.label-schema.vcs-ref="${ARG_VCS_REF}" \
    org.label-schema.vcs-url="https://github.com/accetto/ubuntu-vnc-xfce-firefox"

ENV \
  REFRESHED_AT=${ARG_REFRESHED_AT} \
  VERSION_STICKER=${ARG_VERSION_STICKER} \
  VNC_BLACKLIST_THRESHOLD=${ARG_VNC_BLACKLIST_THRESHOLD:-20} \
  VNC_BLACKLIST_TIMEOUT=${ARG_VNC_BLACKLIST_TIMEOUT:-0} \
  VNC_RESOLUTION=${ARG_VNC_RESOLUTION:-1360x768}

### Preconfigure Xfce
COPY [ "./src/home/Desktop", "./Desktop/" ]
COPY [ "./src/home/config/xfce4/panel", "./.config/xfce4/panel/" ]
COPY [ "./src/home/config/xfce4/xfconf/xfce-perchannel-xml", "./.config/xfce4/xfconf/xfce-perchannel-xml/" ]
COPY [ "./src/startup/version_sticker.sh", "${STARTUPDIR}/" ]

### Fix permissions
RUN \
    chmod a+wx "${STARTUPDIR}"/version_sticker.sh \
    && "${STARTUPDIR}"/set_user_permissions.sh "${STARTUPDIR}" "${HOME}"

### Switch to non-root user
USER ${VNC_USER}

### Issue #7 (base): Mitigating problems with foreground mode
WORKDIR ${STARTUPDIR}
