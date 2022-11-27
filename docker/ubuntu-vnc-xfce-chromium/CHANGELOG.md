# CHANGELOG

## accetto/ubuntu-vnc-xfce-chromium

[Docker Hub][this-docker] - [Git Hub][this-github] - [Wiki][this-wiki]

***

### Final release 22.11

The repository has been revived and merged into the repository [ubuntu-vnc-xfce][accetto-github-ubuntu-vnc-xfce], because I've noticed, that the images are still being pulled.

This original repository [ubuntu-vnc-xfce-chromium][this-github] stays retired.

### Final G1v1 release 22.03.1

The repository is **retired** and **archived**. It will not be developed any further and the related images on Docker Hub will not be rebuilt any more. They will phase out and they will be deleted after becoming too old.

Please use the newer **third generation** (G3) repository [accetto/ubuntu-vnc-xfce-g3][accetto-ubuntu-vnc-xfce-g3] and the related images on Docker Hub instead.

If you still need images based on `Ubuntu 18.04 LTS`, then feel free using the repository for building the images locally.

### Release 22.03

- Chromium Browser **99.0.4844.51**

### Release 22.01

- Chromium Browser **97.0.4692.71**

### Release 21.11

- Chromium Browser **95.0.4638.69**

### Release 21.10.1

- Chromium Browser **94.0.4606.81**

### Release 21.10

- base image has been updated to version **18.04.6**
- Chromium Browser **94.0.4606.71**

### Release 21.09

- utility `builder.sh` improved
- Chromium Browser **93.0.4577.63**

### Release 21.08.1

- utility `builder.sh` improved
- Chromium Browser **92.0.4515.159**

### Release 21.08

- Docker Hub has removed auto-builds from free plans since 2021-07-26, therefore
  - **if you stay on the free plan**, then
    - you can still build the images locally and then push them to Docker Hub
      - pushing to Docker Hub is optional
      - just follow the added file `local-building-example.md`
      - you can use the helper utility `builder.sh`
  - regularity of updates of images on Docker Hub cannot be guaranteed any more

### Release 21.06.1

- Chromium Browser **91.0.4472.101**

### Release 21.06

- Chromium Browser **91.0.4472.77**

### Release 21.05

- Chromium Browser **90.0.4430.93**

### Release 21.04.1

- TigerVNC from [Release Mirror on accetto/tigervnc][accetto-tigervnc-release-mirror] because **Bintray** is closing on 2021-05-01 (inherited from the base image)

### Release 21.04

- Chromium Browser **90.0.4430.72**

### Release 21.03.1

- Chromium Browser **89.0.4389.90**

### Release 21.03

- Chromium Browser **89.0.4389.82**

### Release 20.12.1

- README got links to the third generation (G3) of images

### Release 20.12

- Chromium Browser **87.0.4280.66**

### Release 20.11

- Chromium Browser **86.0.4240.198**

### Release 20.10.2

- Chromium Browser **86.0.4240.75**

### Release 20.10.1

- hook scripts updated
  - automatic archiving of previous image versions removed

### Release 20.10

- updated scripts (all images):
  - version_of.sh
  - version_sticker.sh
  - util-hdx.sh
- Chromium Browser **85.0.4183.121**

### Release 20.09

- Chromium Browser **85.0.4183.83**
- **nano** editor added (inherited from base)

### Release 20.08.1

- base image has been updated to version **18.04.5**
- Chromium Browser **84.0.4147.105**

### Release 20.08

- base image has been updated

### Release 20.07

- base **ubuntu-vnc-xfce** image has been updated

### Release 20.06.1

- default VNC resolution changed to 1360x768
- added some help comments into Dockerfile

### Release 20.06

- Chromium Browser **83.0.4103.61**
- minor changes in **README**
  - making it more similar to [accetto/xubuntu-vnc](https://hub.docker.com/r/accetto/xubuntu-vnc) and [accetto/xubuntu-vnc-novnc](https://hub.docker.com/r/accetto/xubuntu-vnc-novnc)

### Release 20.05

- Chromium Browser **81.0.4044.138**

### Release 20.04.2

- All changes inherited from the base image:
  - based explicitly on **ubuntu:18.04** tag
    - note that the tag **latest** now means **based on ubuntu:18.04**
  - **TigerVNC** version **1.10.1**
  - **websockify** updated to version **0.9.0**

### Release 20.04.1

- Chromium Browser **80.0.3987.163**

### Release 20.04

- Chromium Browser **80.0.3987.149**

### Release 20.03

- **Ubuntu** base image updated (inherited from base)

### Release 20.02.2

- **Ubuntu** base image updated to version **18.04.4**

### Release 20.02.1

- Chromium Browser **80.0.3987.87**
- desktop launcher for version sticker script (verbose) (inherited from the base)
- container screenshot updated
- **README** updated

### Release 20.02

- Chromium Browser **79.0.3945.130**

### Release 20.01

- **Ubuntu** base image has been updated

### Release 19.12

- **Ubuntu** base image has been updated
- Chromium Browser **79.0.3945.79**

### Version 19.11.3

- **TigerVNC** server and client updated to version **1.10.0** (inherited from the base)

### Version 19.11.2

- Chromium Browser **78.0.3904.108**

### Version 19.11.1

- simplified output of `vnc_startup.sh` script (inherited from the base)
- bottom panel's auto-hide behavior changed from `Intelligently` to `Always`
- Chromium Browser **78.0.3904.97**

### Version 19.11

- inherited from the base:
  - **ubuntu** base image updated
- Chromium Browser **78.0.3904.70**

### Version 19.10.4

- inherited from the base:
  - **ubuntu** base image updated
  - **zip**, **unzip**, **curl** and **git** added
  - **jq** (JSON processor) added in its latest version **1.6**
  - **version_of.sh** script handles also **jq**
- **version_sticker.sh** reports new apps inherited from the base
- `test` build hook updated
- README file updated
  
### Version 19.10.3

- README updated
  - **version sticker** described
  - new badges added
- build hooks updated
  - command line arguments passed to `build` hook

### Version 19.10.2

- badges re-designed
  - previous badges removed and new status badges from `badge.net` and `shields.io` introduced
  - `commit` badge from `microbadger.com` introduced (per tag)
  - `version sticker` badge introduced (as static badge from `badge.net`)
  - remark: it can take several hours until new badges are actually shown (caused by caching)
- build hooks updated
- script **util-refresh-readme.sh** introduced

### Version 19.10.1

- README updated

### Version 19.10

- Chromium Browser version **77.0.3865.90**

### Version 19.09

- Initial version with **Chromium Browser** version **76.0.3809.100**

***

[this-docker]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-chromium/
[this-github]: https://github.com/accetto/ubuntu-vnc-xfce-chromium
[this-wiki]: https://github.com/accetto/ubuntu-vnc-xfce-chromium/wiki
[this-base]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce

[accetto-github-ubuntu-vnc-xfce]: https://github.com/accetto/ubuntu-vnc-xfce
[accetto-github-ubuntu-vnc-xfce-firefox-plus]: https://github.com/accetto/ubuntu-vnc-xfce-firefox-plus
[accetto-docker-xubuntu-vnc]: https://hub.docker.com/r/accetto/xubuntu-vnc
[accetto-docker-xubuntu-vnc-firefox]:https://hub.docker.com/r/accetto/xubuntu-vnc-firefox

[accetto-ubuntu-vnc-xfce-g3]: https://github.com/accetto/ubuntu-vnc-xfce-g3

[accetto-docker-argbash-docker]: https://hub.docker.com/r/accetto/argbash-docker
[accetto-github-argbash-docker]: https://github.com/accetto/argbash-docker

[accetto-tigervnc-release-mirror]: https://github.com/accetto/tigervnc/releases

[mousepad]: https://github.com/codebrainz/mousepad
[novnc]: https://github.com/kanaka/noVNC
[nsswrapper]: https://cwrap.org/nss_wrapper.html
