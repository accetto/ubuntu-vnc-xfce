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
        chromium-browser \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/*

### Chromium browser requires some presets
### Note that 'no-sandbox' flag is required, but intended for development only
RUN echo "CHROMIUM_FLAGS='--no-sandbox --disable-gpu --user-data-dir --window-size=${VNC_RESOLUTION%x*},${VNC_RESOLUTION#*x} --window-position=0,0'" > ${HOME}/.chromium-browser.init

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
    any.accetto.description="Headless Ubuntu VNC/noVNC container with Xfce desktop and Chromium Browser" \
    any.accetto.display-name="Headless Ubuntu/Xfce VNC/noVNC container with Firefox and Chromium" \
    any.accetto.tags="ubuntu, xfce, vnc, novnc, chromium" \
    version-sticker="${ARG_VERSION_STICKER}" \
    org.label-schema.vcs-ref="${ARG_VCS_REF}" \
    org.label-schema.vcs-url="https://github.com/accetto/ubuntu-vnc-xfce-chromium"

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
