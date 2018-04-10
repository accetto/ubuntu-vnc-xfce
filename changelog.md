## CHANGELOG

### `accetto/ubuntu-vnc-xfce`, `accetto/ubuntu-vnc-xfce-firefox`

### Version 1.2.0

(April 2018)

- **noVNC** updated to version **1.0.0** (was 0.6.2)
- **Firefox Quantum** updated to version **59.0.2** (64-bit)
- **vim** editor has been installed back
- **Issue #2**: Firefox tab crashes "Gah. Your tab just crashed."
  - Mitigated by forcing the following Firefox preferences:
    - **browser.tabs.remote.autostart = false**
    - **browser.tabs.remote.autostart.2 = false**


### Version 1.1.3

(March 2018)

- fix: occasional VNC Viewer connection problem ("Too many security failures")
  - VNC parameter **BlacklistTimetout** set to **0**
  - VNC parameter **BlacklistThreshold** set to **20**
  - both VNC parameters configurable through the new build arguments and environment variables **BLACKLIST_TIMEOUT** and **BLACKLIST_THRESHOLD**
- image with Firefox got a new environment variable **VNC_USER** (configurable through the previously added build argument **VNC_USER**)

### Version 1.1.2

(January 2018)

- fixed: Arrow keys not working correctly in Terminal (only Firefox containers)
- purged `pavucontrol` and `pulseaudio` to shrink the base image a little bit

### Version 1.1.1

(December 2017)

- more tagged versions added, all based on the official [`ubuntu`](https://hub.docker.com/_/ubuntu/) images
- README got badges from [MicroBadger](https://microbadger.com/) (still Beta)
- added **lsb-release** package

### Version 1.1.0

(December 2017)

- based on **ubuntu:latest** image (always the current LTS version, currently **16.04**)
- **TigerVNC** updated to version **1.8.0** (was 1.7.0)
- **noVNC** updated to version **0.6.2** (was 0.6.1)
- default **VNC\_RESOLUTION** changed to **1360x768** (was 1024x768)
- **vim** editor has been removed
- **leafpad** editor has been added as part of **Xfce** layer
- base image runs under the **root** user by default
- following changes has been accepted from the newer version **1.2.3** of [`ConSol/docker-headless-vnc-container`](https://github.com/ConSol/docker-headless-vnc-container)
  - using older version **0.6.1** (was 0.8.0) of **websockify** to prevent hanging connections on offline containers (see on [ConSol](https://github.com/ConSol/docker-headless-vnc-container/issues/50))
  - environment variable **VNC\_VIEW\_ONLY** with default value **false** (see on [ConSol](https://github.com/ConSol/docker-headless-vnc-container))
  - VNC startup script has been updated accordingly
- image with Firefox
  - introduces a new build argument **VNC\_USER** with default value **headless:headless**
  - runs under a new non-root **VNC\_USER** by default
  - includes the current Firefox version (currently **Firefox Quantum v57.0.3 (64-bit)**)

### Version 1.0.0

(March 2017)

Derived from [`ConSol/docker-headless-vnc-container`](https://github.com/ConSol/docker-headless-vnc-container) and modified:

- kept only Ubuntu support (v16.04)
- removed Centos7 support
- removed OpenShift support
- removed IceWM as alternative UI
- removed Chromium Browser and related stuff
- added locale EN to fix the problem with UXterm
- changed default VNC password
- redesigned the whole image set
- redesigned Dockerfiles and added new arguments
- added current Firefox (v52.0.2)
- added folders `Downloads`, `Documents` and `.mozilla` (volume mount points)

Created the following set of images:

- `accetto/ubuntu-vnc-xfce` is the base Ubuntu/Xfce image with VNC/nonVNC
- `accetto/ubuntu-vnc-xfce-firefox` adds Firefox
- optional `accetto/ubuntu-vnc-xfce-firefox-profile` adds a pre-configured Firefox profile