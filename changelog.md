## Changelog of `accetto/ubuntu-vnc-xfce` image stack

### Version 1.1.0

(December 2017)

* still based on **ubuntu:16.04** image (current LTS version)
* **TigerVNC** updated to version **1.8.0** (was 1.7.0)
* **noVNC** updated to version **0.6.2** (was 0.6.1)
* default **VNC\_RESOLUTION** changed to **1360x768** (was 1024x768)
* **vim** editor has been removed
* **leafpad** editor has been added as part of **Xfce4** layer
* base image runs under the **root** user by default
* following changes has been accepted from the newer version **1.2.3** of [`ConSol/docker-headless-vnc-container`](https://github.com/ConSol/docker-headless-vnc-container)
	* using older version **0.6.1** (was 0.8.0) of **websockify** to prevent hanging connections on offline containers (see on [ConSol](https://github.com/ConSol/docker-headless-vnc-container/issues/50))
	* environment variable **VNC\_VIEW\_ONLY** with default value **false** (see on [ConSol](https://github.com/ConSol/docker-headless-vnc-container))
	* VNC startup script has been updated accordingly
* image with Firefox
	* introduces a new build argument **VNC\_USER** with default value **headless:headless**
	* runs under a new non-root **VNC\_USER** by default
	* includes the current Firefox version (currently **Firefox Quantum v57.0.3 (64-bit)**)

### Version 1.0.0

(March 2017)

Derived from [`ConSol/docker-headless-vnc-container`](https://github.com/ConSol/docker-headless-vnc-container) and modified:

* kept only Ubuntu support (v16.04)
* removed Centos7 support
* removed OpenShift support
* removed IceWM as alternative UI
* removed Chromium Browser and related stuff
* added locale EN to fix the problem with UXterm
* changed default VNC password
* redesigned the whole image set
* redesigned Dockerfiles and added new arguments
* added current Firefox (v52.0.2)
* added folders `Downloads`, `Documents` and `.mozilla` (volume mount points)

Created the following set of images:

* `accetto/ubuntu-vnc-xfce` is the base Ubuntu/Xfce image with VNC/nonVNC
* `accetto/ubuntu-vnc-xfce-firefox` adds Firefox
* optional `accetto/ubuntu-vnc-xfce-firefox-profile` adds a pre-configured Firefox profile

