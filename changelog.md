## Changelog of `accetto/ubuntu-vnc-xfce` repository

### Version 1.0.0

Derived from `ConSol/docker-headless-vnc-container` on `github.com` and modified:

* kept only Ubuntu support (v16.04)
* removed Centos7 support
* removed OpenShift support
* removed IceWM as alternative UI
* removed Chromium Browser and related stuff
* added locale EN to fix the problem with UXterm
* changed default VNC password
* redesigned the whole image stack
* redesigned Dockerfiles and added arguments
* added current Firefox (v52.0.2)
* added folders `Downloads`, `Documents` and `.mozilla` (volume mount points)

Created the following set of images:

* `accetto/ubuntu-vnc-xfce` is the base Ubuntu/Xfce image with VNC/nonVNC
* `accetto/ubuntu-vnc-xfce-firefox` adds Firefox
* optional `accetto/ubuntu-vnc-xfce-firefox-profile` adds a pre-configured Firefox profile
