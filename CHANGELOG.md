<!-- spell-checker:words pavucontrol websockify Centos -->

# CHANGELOG

## accetto/ubuntu-vnc-xfce

[Docker Hub][this-docker] - [Git Hub][this-github] - [Wiki][this-wiki]

***

### Release 20.06.01

- default VNC resolution changed to 1360x768
- `version_of.sh` updated (Firefox version pattern)
  - both changes be inherited by all derived images
- added some help comments into Dockerfile

### Release 20.06

- minor changes in **vnc_startup.sh** and **README**
  - making it more similar to [accetto/xubuntu-vnc](https://hub.docker.com/r/accetto/xubuntu-vnc) and [accetto/xubuntu-vnc-novnc](https://hub.docker.com/r/accetto/xubuntu-vnc-novnc)

### Release 20.04

- using base image tag **ubuntu:18.04** explicitly
  - **env** hook script updated accordingly
  - note that the tag **latest** now means **based on ubuntu:18.04**
- **TigerVNC** version **1.10.1**
- **websockify** updated to version **0.9.0**
- all above changes inherited by all derived images

### Release 20.03

- **Ubuntu** base image updated (inherited by all derived images)

### Release 20.02.1

- **Ubuntu** base image updated to version **18.04.4**

### Release 20.02

- desktop launcher for version sticker script (verbose) added
  - derived images inherit this change
- container screenshot updated
- **README** updated

### Release 20.01

- **Ubuntu** base image has been updated

### Release 19.12

- **Ubuntu** base image has been updated

### Version 19.11.2

- **TigerVNC** server and client updated to version **1.10.0**

### Version 19.11.1

- simplified output of `vnc_startup.sh` script
- bottom panel's auto-hide behavior changed from `Intelligently` to `Always`

### Version 19.11

- **ubuntu** base image updated

### Version 19.10.3

- **ubuntu** base image updated
- **zip**, **unzip**, **curl** and **git** added
- **jq** (JSON processor) added in its latest version **1.6**
- **version_of.sh** script handles also **jq**
- **version_sticker.sh** reports added apps
- `test` build hook updated
- README file updated

### Version 19.10.2

- README updated
  - **version sticker** described
  - new badges added
- build hooks updated
  - command line arguments passed to `build` hook

### Version 19.10.1

- badges re-designed
  - previous badges removed and new status badges from `badge.net` and `shields.io` introduced
  - `commit` badge from `microbadger.com` introduced (per tag)
  - `version sticker` badge introduced (as static badge from `badge.net`)
  - remark: it can take several hours until new badges are actually shown (caused by caching)
- build hooks updated
- script **util-refresh-readme.sh** introduced

### Version 19.10

- README updated

### Version 19.09

- environment variable **VERSION_STICKER** and build argument **ARG_VERSION_STICKER** introduced
- scripts **version_sticker.sh** and **version_of.sh** introduced

### Version 19.08.1

- newer base image (**Ubuntu 18.04.3 LTS**)
- build argument **ARG_REFRESHED_AT** introduced
  - environment variable **REFRESHED_AT** set to the actual build date
  - utility **util-update-refreshed-at** removed

### Version 19.08

- just refreshed because of newer base image (Ubuntu)

### Version 19.06.2

- **README** updated
  - reference to [accetto/xubuntu-vnc][accetto-docker-xubuntu-vnc] added - a streamlined and simplified version of this image, without [noVNC][novnc] and [nss_wrapper][nsswrapper], with a growing family of derived images with various applications

### Version 19.06.1

- File manager (Thunar) pre-configured
  - *Owner*, *Permissions* and *Group* columns shown by default
  - *Type* column suppressed
- Script **set_user_permissions.sh** updated
  - current user group replaced by group zero

### Version 19.06

- Script **set_user_permissions.sh** updated
  - root group replaced by the current user group
- **TigerVNC Viewer** desktop launcher icon fixed

### Version 19.05

- Fixed [Issue #8](https://github.com/accetto/ubuntu-vnc-xfce/issues/8) (Error if changing default user)
- **Dockerfile** updated
  - new intermediate stage `stage-wrapper` added
  - some commands moved out from `stage-wrapper` to `stage-final`
  - user permissions set using `set_user_permissions.sh` script
  - **STARTUPDIR** changed from `/boot/dockerstartup` to `/dockerstartup`
- Launchers for **Vim** and **TigerVNC Viewer** added to the desktop
- Utility `util-hdx.sh` updated (using [accetto/argbash-docker][accetto-docker-argbash-docker])

### Version 19.04

- **noVNC** updated to version **1.1.0** (formerly 1.0.0)
- **ping** utility added
- Environment variable **REFRESHED_AT** added back
- Display settings launcher added to the desktop and the panels
  - to make resolution switching more convenient also with **noVNC** lite client
- **Dockerfile_rolling** file removed
  - it can be easily cloned from the Dockerfile file for the **latest** build
  - **rolling** build will not be maintained on **Docker Hub** any more

### Version 19.01

- **TigerVNC** updated to version **1.9.0** (formerly 1.8.0)
- **websockify** updated to version **0.8.0** (formerly 0.6.1)
- Environment variable **REFRESHED_AT** removed
- Xfce panels are pre-configured now
- Container screenshot added to README

### Version 18.10

- Fixed [Issue #7](https://github.com/accetto/ubuntu-vnc-xfce/issues/7) (Problem with foreground mode)
  - supported startup options: `--wait` (default), `--skip`, `--debug` (also `--tail-log`) and `--help`
  - getting help: `docker run --rm accetto/ubuntu-vnc-xfce --help`
  - README file is extended

### Version 18.06.1

- Fixed [Issue #6](https://github.com/accetto/ubuntu-vnc-xfce/issues/6) ("--wait: /boot/dockerstartup/vnc_startup.sh: Permission denied" on startup)
  - Only automated builds have been plagued by this issue.

### Version 18.06

- Dockerfile redesigned
  - multi-staged and explicit
  - helper installation scripts mostly removed
- Changes in folders
  - home path `/headless` changed to `/home/headless` (careful by mounting volumes!)
  - startup path `/dockerstartup` changed to `/boot/dockerstartup`
  - *TigerVNC* and *noVNC* installed into `/usr` tree
- Standard *Xfce* desktop, incl. initial panel configuration on the first start
- Editor **leafpad** replaced by more advanced but still lite [mousepad][mousepad]
- **pulseaudio** and **pavucontrol** not purged any more

### Version 18.05.1

- Dockerfiles - build arguments and environment variables interaction redesigned
- Default **VNC_RESOLUTION=1024x768** and it can be set also through build arguments

### Version 18.05

- Resources for base Ubuntu/VNC images and images with Firefox split into separate GitHub repositories, consequently
  - README, CHANGELOG and Wiki are not common any more
  - Resources for images with the default Firefox installation moved to repository [accetto/ubuntu-vnc-xfce-firefox][accetto-github-ubuntu-vnc-xfce-firefox]
  - Resources for images with configurable Firefox installation moved to repository [accetto/ubuntu-vnc-xfce-firefox-plus][accetto-github-ubuntu-vnc-xfce-firefox-plus]
- Dockerfile *rolling* removed, **FROM** uses build arguments
- Folder **/headless/Documents** not created explicitly any more
- Simple startup page for choosing noVNC client added
- This is the first version of generation 2 after repository split and version numbering change
  - Branch **master** has been reset to this version

### Version 1.4.3 and 18.04

(April 2018)

- Quick-fix [Issue #4](https://github.com/accetto/ubuntu-vnc-xfce/issues/4) (Volume '/headless/Documents' owned by 'root')
- Essentially a rollback to the previous version
  - **VOLUME** instructions removed
  - Environment variables **LANG**, **LANGUAGE** and **LC_ALL** declared at the previous place
- [Issue #5](https://github.com/accetto/ubuntu-vnc-xfce/issues/5) mitigated by setting the lite noVNC client as the default one. Full client can be used by navigating to *vnc.html*.
- This is the final version of generation 1 before repository split and version numbering change
  - Branch **18.04** keeps this stage which will not be developed any more

### Version 1.4.2

(April 2018)

- Adjustments in Dockerfiles
  - **VOLUME** instructions added
  - Build arguments and environment variables sorted alphabetically

### Version 1.4.1

(April 2018)

- Fixed [Issue #1](https://github.com/accetto/ubuntu-vnc-xfce/issues/1) (Occasional VNC Viewer connection problem "Too many security failures")
- **Ubuntu 18.04 LTS** (bionic) as **ubuntu:latest**

### Version 1.4.0

(April 2018)

- Warning, the [issue #1](https://github.com/accetto/ubuntu-vnc-xfce/issues/1) is unfortunately back in this release.
- Fixed [Issue #3](https://github.com/accetto/ubuntu-vnc-xfce/issues/3) (Default Firefox profile not initialized on external volumes)
- Handling of Firefox profiles has been improved
  - Firefox proto-profile **profile0.default** is created also on external volumes if there is no Firefox profile yet
  - Proto-profile is backed-up as folder **/headless/firefox.backup**
- Startup scripts has been improved
- Default **noVNC** startup page has been set to *vnc.html* (full client). Lite client can be used by navigating to *vnc_lite.html*.
- Locale related environment variables **LANG**, **LANGUAGE** and **LC_ALL** has been added

### Version 1.3.0

(April 2018)

- Handling of Firefox profiles has been redesigned
  - The folder **profile0.default** for the default Firefox profile has been pre-created and initialized with the **user.js** file, which includes the fix of the [issue #2](https://github.com/accetto/ubuntu-vnc-xfce/issues/2) (see the version 1.2.0).
  - The actual Firefox profile is created on the first Firefox start.
  - The non-root **VNC user** got permissions to modify the **user.js** file and the whole profile.
  - The backup copy **user.js.txt** is in the folder **/headless/.mozilla/firefox**, so the default profile can be safely deleted.
- In the images with Firefox is the non-root **VNC user** (**headless:headless** by default) the owner of the most folders created in his home folder **/headless**.
- File permissions have been sorted-out.

### Version 1.2.0

(April 2018)

- **noVNC** updated to version **1.0.0** (was 0.6.2)
- **Firefox Quantum** updated to version **59.0.2** (64-bit)
- **vim** editor has been installed back
- Fixed: [Issue #2](https://github.com/accetto/ubuntu-vnc-xfce/issues/2) (Firefox tab crashes "Gah. Your tab just crashed.")
  - Mitigated by forcing the following Firefox preferences:
    - **browser.tabs.remote.autostart = false**
    - **browser.tabs.remote.autostart.2 = false**

### Version 1.1.3

(March 2018)

- Fixed [Issue #1](https://github.com/accetto/ubuntu-vnc-xfce/issues/1) (Occasional VNC Viewer connection problem "Too many security failures")
  - VNC parameter **BlacklistTimeout** set to **0**
  - VNC parameter **BlacklistThreshold** set to **20**
  - both VNC parameters configurable through the new build arguments and environment variables **BLACKLIST_TIMEOUT** and **BLACKLIST_THRESHOLD**
- image with Firefox got a new environment variable **VNC_USER** (configurable through the previously added build argument **VNC_USER**)

### Version 1.1.2

(January 2018)

- fixed: Arrow keys not working correctly in Terminal (only Firefox containers)
- purged `pavucontrol` and `pulseaudio` to shrink the base image a little bit

### Version 1.1.1

(December 2017)

- more tagged versions added, all based on the official [`ubuntu`][docker-ubuntu] images
- README got badges from [MicroBadger][microbadger] (still Beta)
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
- following changes has been accepted from the newer version **1.2.3** of [ConSol/docker-headless-vnc-container][consol-github-docker-headless-vnc-container]
  - using older version **0.6.1** (was 0.8.0) of **websockify** to prevent hanging connections on offline containers (see on [ConSol][consol-issue-50])
  - environment variable **VNC\_VIEW\_ONLY** with default value **false** (see on [ConSol][consol-github-docker-headless-vnc-container])
  - VNC startup script has been updated accordingly
- image with Firefox
  - introduces a new build argument **VNC\_USER** with default value **headless:headless**
  - runs under a new non-root **VNC\_USER** by default
  - includes the current Firefox version (currently **Firefox Quantum v57.0.3 (64-bit)**)

### Version 1.0.0

(March 2017)

Derived from [ConSol/docker-headless-vnc-container][consol-github-docker-headless-vnc-container] and modified:

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

***

[this-docker]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce/
[this-github]: https://github.com/accetto/ubuntu-vnc-xfce
[this-wiki]: https://github.com/accetto/ubuntu-vnc-xfce/wiki

[accetto-github-ubuntu-vnc-xfce-firefox]: https://github.com/accetto/ubuntu-vnc-xfce-firefox
[accetto-github-ubuntu-vnc-xfce-firefox-plus]: https://github.com/accetto/ubuntu-vnc-xfce-firefox-plus

[accetto-docker-argbash-docker]: https://hub.docker.com/r/accetto/argbash-docker
[accetto-github-argbash-docker]: https://github.com/accetto/argbash-docker

[accetto-docker-xubuntu-vnc]: https://hub.docker.com/r/accetto/xubuntu-vnc

[docker-ubuntu]: https://hub.docker.com/_/ubuntu/

[microbadger]: https://microbadger.com/

[consol-github-docker-headless-vnc-container]: https://github.com/ConSol/docker-headless-vnc-container
[consol-docker]: https://hub.docker.com/u/consol/
[consol-issue-50]: https://github.com/ConSol/docker-headless-vnc-container/issues/50

[mousepad]: https://github.com/codebrainz/mousepad
[novnc]: https://github.com/kanaka/noVNC
[nsswrapper]: https://cwrap.org/nss_wrapper.html
