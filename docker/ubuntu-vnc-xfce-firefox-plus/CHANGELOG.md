# CHANGELOG

## accetto/ubuntu-vnc-xfce-firefox-plus

[Docker Hub][this-docker] - [Git Hub][this-github] - [Wiki][this-wiki]

***

### Final release 22.11

The repository has been revived and merged into the repository [ubuntu-vnc-xfce][accetto-github-ubuntu-vnc-xfce], because I've noticed, that the images are still being pulled.

This original repository [ubuntu-vnc-xfce-firefox-plus][this-github] stays retired.

### Final G1v1 release 22.03.1

The repository is **retired** and **archived**. It will not be developed any further and the related images on Docker Hub will not be rebuilt any more. They will phase out and they will be deleted after becoming too old.

Please use the newer **third generation** (G3) repository [accetto/ubuntu-vnc-xfce-g3][accetto-ubuntu-vnc-xfce-g3] and the related images on Docker Hub instead.

If you still need images based on `Ubuntu 18.04 LTS`, then feel free using the repository for building the images locally.

- Updated versions:
  - Firefox **98.0**

### Release 22.03

- Firefox **97.0.2**

### Release 22.02

- Firefox **97.0**

### Release 22.01

- Firefox **96.0**

### Release 21.12.1

- Firefox **95.0.1**

### Release 21.12

- Firefox **95.0**

### Release 21.11

- Firefox **94.0**

### Release 21.10

- base image has been updated to version **18.04.6**
- Firefox **93.0**

### Release 21.09.1

- utility `builder.sh` improved
- Firefox **92.0**

### Release 21.09

- Firefox **91.0.2**

### Release 21.08.1

- utility `builder.sh` improved
- Firefox **91.0.1**

### Release 21.08

- Docker Hub has removed auto-builds from free plans since 2021-07-26, therefore
  - **if you stay on the free plan**, then
    - you can still build the images locally and then push them to Docker Hub
      - pushing to Docker Hub is optional
      - just follow the added file `local-building-example.md`
      - you can use the helper utility `builder.sh`
  - regularity of updates of images on Docker Hub cannot be guaranteed any more
- Firefox **90.0.2**

### Release 21.07.1

- Firefox **90.0**

### Release 21.07

- Firefox **89.0.2**

### Release 21.06.1

- Firefox **89.0.1**

### Release 21.06

- Firefox **89.0**

### Release 21.05

- Firefox **88.0.1**

### Release 21.04

- TigerVNC from [Release Mirror on accetto/tigervnc][accetto-tigervnc-release-mirror] because **Bintray** is closing on 2021-05-01 (inherited from the base image)
- Firefox **88.0**

### Release 21.03.1

- Firefox **87.0**

### Release 21.03

- Firefox **86.0**

### Release 21.02.1

- Firefox **85.0.1**

### Release 21.02

- Firefox **85.0**

### Release 21.01.1

- Firefox **84.0.2**

### Release 21.01

- Firefox **84.0.1**

### Release 20.12

- README got links to the third generation (G3) of images
- Firefox **84.0**

### Release 20.11

- Firefox **83.0**

### Release 20.10.2

- Firefox **82.0**

### Release 20.10.1

- hook scripts updated
  - automatic archiving of previous image versions removed
- switch **MOZ_FORCE_DISABLE_E10S=1** seems not working any more
  - build argument **ARG_MOZ_FORCE_DISABLE_E10S** removed 
  - environment variable **MOZ_FORCE_DISABLE_E10S** removed
  - `singleprocess` tag removed
  - hook scripts updated accordingly

### Release 20.10

- updated scripts (all images):
  - version_of.sh
  - version_sticker.sh
  - util-hdx.sh
- Firefox **81.0**

### Release 20.09.1

- **nano** editor added (inherited from base)

### Release 20.09

- Firefox **80.0.1**

### Release 20.08.2

- Firefox **80.0**

### Release 20.08.1

- base image has been updated to version **18.04.5**

### Release 20.08

- base image has been updated
- Firefox **79.0**

### Release 20.07.1

- base **ubuntu-vnc-xfce** image has been updated
- Firefox **78.0.2**

### Release 20.07

- Firefox **78.0.1**
- fix in `push` hook script

### Release 20.06.2

- Firefox **77.0.1**
  - **IMPORTANT**: Firefox multi-process mode is default now and therefore larger shared memory (`/dev/shm`) is required (see bellow)
    - environment variable **MOZ_FORCE_DISABLE_E10S** is not set by default any more
    - **containers with Firefox require larger shared memory** (`/dev/shm`) to run reliably
      - at least **256MB** is recommended (default is just 64MB)
      - use `docker run --shm-size=256m`
        - or `shm_size: 256m` at service level in docker-compose files
        - see [Firefox multi-process][that-wiki-firefox-multiprocess] in Wiki for description and instructions
    - this fixes the [issue #7 (Firefox 77.0.1 scrambles pages)](https://github.com/accetto/ubuntu-vnc-xfce-firefox-plus/issues/7)
    - Internet browsing should be **sand-boxed** now
    - tag `singleprocess` introduced
      - which is single-threaded, but
      - please be aware that in **this** release (still Firefox **77.0.1**) webpages still will be scrambled (issue #7)
      - it should be fixed by Mozilla in the next Firefox release
- Other changes:
  - default VNC resolution changed to 1360x768
  - added some help comments into Dockerfile
  - README updated

### Release 20.06.1

- Quick mitigation of issue [#7 (Firefox 77.0.1 scrambles pages)](https://github.com/accetto/ubuntu-vnc-xfce-firefox-plus/issues/7)
  - by rolling back **Firefox** to version **76.0.1**

### Release 20.06

- Firefox **77.0.1**
- minor changes in **README**
  - making it more similar to [accetto/xubuntu-vnc](https://hub.docker.com/r/accetto/xubuntu-vnc) and [accetto/xubuntu-vnc-novnc](https://hub.docker.com/r/accetto/xubuntu-vnc-novnc)

### Release 20.05

- Firefox **76.0.1**

### Release 20.04.2

- All changes inherited from the base image:
  - based explicitly on **ubuntu:18.04** tag
    - note that the tag **latest** now means **based on ubuntu:18.04**
  - **TigerVNC** version **1.10.1**
  - **websockify** updated to version **0.9.0**

### Release 20.04.1

- Firefox **75.0**

### Release 20.04

- Firefox **74.0.1**

### Release 20.03.1

- **Ubuntu** base image updated (inherited from base)

### Release 20.03

- Firefox **74.0**

### Release 20.02.3

- Firefox **73.0.1**

### Release 20.02.2

- **Ubuntu** base image updated to version **18.04.4**

### Release 20.02.1

- Firefox **73.0**
- desktop launcher for version sticker script (verbose) (inherited from the base)
- container screenshot updated
- **README** updated

### Release 20.02

- Firefox **72.0.2**

### Release 20.01

- **Ubuntu** base image has been updated
- Firefox **72.0.1**

### Release 19.12.1

- **Ubuntu** base image has been updated

### Release 19.12

- Firefox **71.0**

### Version 19.11.2

- **TigerVNC** server and client updated to version **1.10.0** (inherited from the base)

### Version 19.11.1

- simplified output of `vnc_startup.sh` script (inherited from the base)
- bottom panel's auto-hide behavior changed from `Intelligently` to `Always`

### Version 19.11

- inherited from the base:
  - **ubuntu** base image updated
- Firefox **70.0.1**

### Version 19.10.5

- Firefox **70.0**

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
- Firefox updated to version **69.0.2**

### Version 19.10.1

- README updated

### Version 19.10

- Firefox version **69.0.1**

### Version 19.09

- environment variable **VERSION_STICKER** and build argument **ARG_VERSION_STICKER** introduced
- scripts **version_sticker.sh** and **version_of.sh** introduced
- Firefox version **69.0**

### Version 19.08.1

- newer base image (**Ubuntu 18.04.3 LTS**) (inherited from the base image)
- **Firefox** updated to version **68.0.2**
- environment variable **MOZ_FORCE_DISABLE_E10S** and build argument **ARG_MOZ_FORCE_DISABLE_E10S** introduced
  - Firefox multi-process is **disabled** by default
- build argument **ARG_REFRESHED_AT** introduced
  - environment variable **REFRESHED_AT** set to the actual build date
  - utility **util-update-refreshed-at** removed

### Version 19.08

- keeping Firefox on version **67.0.4** because **68.0** and **68.0.1** crash a lot (Gah. Your tab just crashed.)
  - installed explicitly from Mozilla distribution

### Version 19.06.4

- **README** updated
  - reference to [accetto/xubuntu-vnc-firefox][accetto-docker-xubuntu-vnc-firefox] based on [accetto/xubuntu-vnc][accetto-docker-xubuntu-vnc] added - a streamlined and simplified image, without [noVNC][novnc] and [nss_wrapper][nsswrapper], with a growing family of derived images with various applications
- Firefox version **67.0.4**

### Version 19.06.3

- File manager (Thunar) pre-configured (inherited from the [base image][this-base])
  - *Owner*, *Permissions* and *Group* columns shown by default
  - *Type* column suppressed
- Fix in **create_user_and_fix_permissions.sh**
- Firefox version **67.0.3**

### Version 19.06.2

- Fix in **create_user_and_fix_permissions.sh**

### Version 19.06.1

- Fix in **Dockerfile-plus-preferences**

### Version 19.06

- Script **set_user_permissions.sh** updated (inherited from the [base image][this-base])
  - root group replaced by the current user group
- **TigerVNC Viewer** desktop launcher icon updated (inherited from the [base image][this-base])
- Folder **firefox.backup** renamed to **firefox.plus**
  - script **create_user_and_fix_permissions.sh** and related also updated
- Helper utility script **copy_firefox_user_preferences.sh** added
  - desktop launcher **Copy FF Preferences** for the utility added
  - desktop launcher **FF Profile Manager** added
- File **all-accetto.js** removed because the related functionality doesn't seem to be supported any more
  - related scripts updated accordingly
- Firefox version **67.0.1**

### Version 19.05

- Fixed [Issue #2](https://github.com/accetto/ubuntu-vnc-xfce-firefox-plus/issues/2) (How to run as non-root user) (actually the **issue #8** of the [base image][this-base])
- **Dockerfile** updated
  - user permissions set using `set_user_permissions.sh` script (inherited from the [base image][this-base])
- Launchers for **Vim** and **TigerVNC Viewer** added to the desktop (inherited from the [base image][this-base])
- Utility `util-hdx.sh` updated (using [accetto/argbash-docker][accetto-docker-argbash-docker])

### Version 19.04

- **noVNC** updated to version **1.1.0** (formerly 1.0.0), inherited from the [base image][this-base]
- **ping** utility added, inherited from the [base image][this-base]
- Environment variable **REFRESHED_AT** added back
- Display settings launcher added to the desktop and the panels
  - to make resolution switching more convenient also with **noVNC** lite client
  - inherited from the [base image][this-base]
- **Dockerfile_rolling** file removed
  - it can be easily cloned from the Dockerfile file for the **latest** build
  - **rolling** build will not be maintained on **Docker Hub** any more

### Version 19.01

- **TigerVNC** updated to version **1.9.0** (formerly 1.8.0), inherited from the [base image][this-base]
- **websockify** updated to version **0.8.0** (formerly 0.6.1), inherited from the [base image][this-base]
- Environment variable **REFRESHED_AT** removed
- Xfce panels are pre-configured now
- container screenshot added to README
- **Firefox Quantum** version **64.0** (gets updated to the current version on each re-build)

### Version 18.10

- Fixed **Issue #7** (Problem with foreground mode) inherited from the [base image][this-base]
  - supported startup options: `--wait` (default), `--skip`, `--debug` (also `--tail-log`) and `--help`
  - getting help: `docker run --rm accetto/ubuntu-vnc-xfce --help`
  - README file is extended

### Version 18.06

- Dockerfile redesigned
  - multi-staged and explicit
  - helper installation scripts mostly removed
- Some other changes inherited from the [base image][this-base]
  - standard *Xfce* desktop, incl. initial panel configuration on the first start
  - editor **leafpad** replaced by more advanced but still lite [mousepad][mousepad]
  - **pulseaudio** and **pavucontrol** not purged any more
- Firefox updated

### Version 18.05.2

- Dockerfiles - build arguments and environment variables interaction redesigned
- Default **VNC_RESOLUTION=1024x768** and it can be set also through build arguments

### Version 18.05.1

- Firefox Quantum updated to version **60.0** (64-bit)

### Version 18.05

- This is the first version after splitting from the former common base repository [accetto/ubuntu-vnc-xfce][accetto-github-ubuntu-vnc-xfce]
- Resources for base Ubuntu/VNC images and images with configurable Firefox split into separate GitHub repositories, consequently
  - README, CHANGELOG and Wiki are not common any more
  - Resources for base images moved to repository [accetto/ubuntu-vnc-xfce][accetto-github-ubuntu-vnc-xfce]
  - Resources for images with default Firefox installation moved to repository [accetto/ubuntu-vnc-xfce-firefox][accetto-github-ubuntu-vnc-xfce-firefox]
  - This image contains Firefox installation with pre-configuration support

***

[this-docker]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-firefox-plus/
[this-github]: https://github.com/accetto/ubuntu-vnc-xfce-firefox-plus
[this-base]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce
[this-wiki]: https://github.com/accetto/ubuntu-vnc-xfce-firefox-plus/wiki

[that-wiki-firefox-multiprocess]: https://github.com/accetto/xubuntu-vnc/wiki/Firefox-multiprocess

[accetto-github-ubuntu-vnc-xfce]: https://github.com/accetto/ubuntu-vnc-xfce
[accetto-github-ubuntu-vnc-xfce-firefox]: https://github.com/accetto/ubuntu-vnc-xfce-firefox

[accetto-ubuntu-vnc-xfce-g3]: https://github.com/accetto/ubuntu-vnc-xfce-g3

[accetto-docker-xubuntu-vnc]: https://hub.docker.com/r/accetto/xubuntu-vnc
[accetto-docker-xubuntu-vnc-firefox]:https://hub.docker.com/r/accetto/xubuntu-vnc-firefox

[accetto-docker-argbash-docker]: https://hub.docker.com/r/accetto/argbash-docker
[accetto-github-argbash-docker]: https://github.com/accetto/argbash-docker

[accetto-tigervnc-release-mirror]: https://github.com/accetto/tigervnc/releases

[mousepad]: https://github.com/codebrainz/mousepad
[novnc]: https://github.com/kanaka/noVNC
[nsswrapper]: https://cwrap.org/nss_wrapper.html
