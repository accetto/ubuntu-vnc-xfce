# Headless Ubuntu/Xfce container with VNC/noVNC

## accetto/ubuntu-vnc-xfce

[Docker Hub][this-docker] - [Git Hub][this-github] - [Changelog][this-changelog] - [Wiki][this-wiki]

![badge-docker-pulls][badge-docker-pulls]
![badge-docker-stars][badge-docker-stars]
![badge-github-release][badge-github-release]
![badge-github-release-date][badge-github-release-date]
![badge-github-stars][badge-github-stars]
![badge-github-forks][badge-github-forks]
![badge-github-open-issues][badge-github-open-issues]
![badge-github-closed-issues][badge-github-closed-issues]
![badge-github-releases][badge-github-releases]
![badge-github-commits][badge-github-commits]
![badge-github-last-commit][badge-github-last-commit]

***

- [Headless Ubuntu/Xfce container with VNC/noVNC](#headless-ubuntuxfce-container-with-vncnovnc)
  - [accetto/ubuntu-vnc-xfce](#accettoubuntu-vnc-xfce)
    - [Introduction](#introduction)
    - [Image generations](#image-generations)
    - [Project versions](#project-versions)
    - [Description](#description)
    - [Git Hub subfolders / Docker image sets](#git-hub-subfolders--docker-image-sets)
      - [ubuntu-vnc-xfce](#ubuntu-vnc-xfce)
      - [ubuntu-vnc-xfce-chromium](#ubuntu-vnc-xfce-chromium)
      - [ubuntu-vnc-xfce-firefox](#ubuntu-vnc-xfce-firefox)
      - [ubuntu-vnc-xfce-firefox-plus](#ubuntu-vnc-xfce-firefox-plus)
      - [utils](#utils)
  - [Issues](#issues)
  - [Credits](#credits)

***

### Introduction

This repository contains resources for building Docker images based on [Ubuntu 18.04 LTS][docker-ubuntu] with [Xfce][xfce] desktop environment and [VNC][tigervnc]/[noVNC][novnc] servers for headless use.

The images can be successfully built and used on Linux, Windows, Mac and NAS devices. It has been tested with [Docker Desktop][docker-desktop] on [Ubuntu flavours][ubuntu-flavours], [Windows 10][docker-for-windows] and [Container Station][container-station] from [QNAP][qnap].

### Image generations

This is the **first generation** (G1) of my headless images, that I've retired back in March 2022. However, because I've noticed that the images are still pulled, I've revived the project in November 2022.

If you want newer images based on [Ubuntu 20.04 LTS][docker-ubuntu] with the latest [TigerVNC][tigervnc-releases]/[noVNC][novnc-releases] versions, please check the **third generation** (G3) [accetto/ubuntu-vnc-xfce-g3][accetto-docker-ubuntu-vnc-xfce-g3], [accetto/ubuntu-vnc-xfce-chromium-g3][accetto-docker-ubuntu-vnc-xfce-chromium-g3] or [accetto/ubuntu-vnc-xfce-firefox-g3][accetto-docker-ubuntu-vnc-xfce-firefox-g3].

Unless you need the [nss_wrapper][nsswrapper], you can also use the **second generation** (G2) images [accetto/xubuntu-vnc-novnc][accetto-docker-xubuntu-vnc-novnc], that are streamlined versions of the images from this repository ([image hierarchy][accetto-xubuntu-vnc-novnc-wiki-image-hierarchy]). The images support also the **sudo** command.

### Project versions

This file describes the **second version** (G1v2) of the project.

The **first version** (G1v1, or simply G1) has been retired back in March 2022, but I've revived it in November 2022, because I've noticed, that the images still have been pulled. It will be available in this **GitHub** repository as the archived branch `archived-generation-g1v1`.

The current **second version** (G1v2) brings some improvements, mostly in the building pipeline and supporting scripts.

It also merges the previously separated **GitHub** projects [ubuntu-vnc-xfce-firefox][accetto-github-ubuntu-vnc-xfce-firefox],  [ubuntu-vnc-xfce-firefox-plus][accetto-github-ubuntu-vnc-xfce-firefox-plus] and [ubuntu-vnc-xfce-chromium][accetto-github-ubuntu-vnc-xfce-chromium] into this single one.

The version `G1v2` brings the following changes comparing to the previous version `G1v1`:

- The values of the **version sticker** variables (`VERSION_STICKER_*`) in the `env` hook scripts are not hardcoded, but initialized from the related environment variables.
- The helper utility `util-refresh-readme.sh` does not update the original `README.md` files, but their clones named `scrap_readme.md`. The content of this temporary file is intended to be copy-and-pasted to the **Docker Hub**.

### Description

The resources for the individual images and their variations are stored in the folders of the [Git Hub][this-github] repository and the image features are described in the individual README files. Additional descriptions can be found in the common project [Wiki][this-wiki].

### Git Hub subfolders / Docker image sets

#### [ubuntu-vnc-xfce][this-github-ubuntu-vnc-xfce]

Contains resources for building the [accetto/ubuntu-vnc-xfce][this-docker-ubuntu-vnc-xfce] base image.

The base image already include commonly used utilities **ping**, **wget**, **zip**, **unzip**, **sudo**, [curl][curl], [git][git] and also the current version of [jq][jq] JSON processor.

While the containers does not include any web browsers, the [mousepad][mousepad] and [vim][vim] editors are already included. Other applications can be easily added also at runtime, because the containers runs under the privileged **root** user.

It should be noticed, that the container's root is not the same as the host's root and that it does not automatically get all root privileges on the hosting computer. Please check the [Docker documentation][docker-doc] for more information about it (e.g. [Runtime privilege and Linux capabilities][docker-doc-capabilities]).

Check this [README][this-github-readme-ubuntu-vnc-xfce] file for more information.

#### [ubuntu-vnc-xfce-chromium][this-github-ubuntu-vnc-xfce-chromium]

Contains resources for building the [accetto/ubuntu-vnc-xfce-chromium][this-docker-ubuntu-vnc-xfce-chromium] image with the open-source [Chromium][chromium] web browser.

Check this [README][this-github-readme-ubuntu-vnc-xfce-chromium] file for more information.

#### [ubuntu-vnc-xfce-firefox][this-github-ubuntu-vnc-xfce-firefox]

Contains resources for building the [accetto/ubuntu-vnc-xfce-firefox-default][this-docker-ubuntu-vnc-xfce-firefox-default] image with the current [Firefox][firefox] web browser in its default installation.

Check this [README][this-github-readme-ubuntu-vnc-xfce-firefox] file for more information.

#### [ubuntu-vnc-xfce-firefox-plus][this-github-ubuntu-vnc-xfce-firefox-plus]

Contains resources for building the [accetto/ubuntu-vnc-xfce-firefox-plus][this-docker-ubuntu-vnc-xfce-firefox-plus] image with the current [Firefox][firefox] web browser with pre-configuration support.

Check this [README][this-github-readme-ubuntu-vnc-xfce-firefox-plus] file for more information.

#### [utils][this-github-utils]
  
Contains utilities that make building the images more convenient.

- `util-hdx.sh`  

  Displays the file head and executes the chosen line, removing the first occurrence of '#' and trimming the line from left first. Providing the line number argument skips the interaction and executes the given line directly.
  
  The comment lines at the top of included Dockerfiles are intended for this utility.

  The utility displays the help if started with the `-h` or `--help` argument. It has been developed using my other utilities `utility-argbash-init.sh` and `utility-argbash.sh`, contained in the [accetto/argbash-docker][accetto-github-argbash-docker-utils] Git Hub repository, from which the [accetto/argbash-docker][accetto-docker-argbash-docker] Docker image is built.

- `util-refresh-readme.sh`  
  
  This script can be used for updating the `version sticker` badges in README files. It is intended for local use before publishing the repository.

  The script does not include any help, because it takes only a single argument - the path where to start searching for files (default is `../docker`). However, there is the file `local-building-example.md` explaining how to use it.

## Issues

If you have found a problem or you just have a question, please check the [Issues][this-issues] and the [Troubleshooting][this-wiki-troubleshooting], [FAQ][this-wiki-faq] and [HOWTO][this-wiki-howto] sections in [Wiki][this-wiki] first. Please do not overlook the closed issues.

If you do not find a solution, you can file a new issue. The better you describe the problem, the bigger the chance it'll be solved soon.

## Credits

Credit goes to all the countless people and companies, who contribute to open source community and make so many dreamy things real.

***

[this-docker]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce/
[this-github]: https://github.com/accetto/ubuntu-vnc-xfce

[this-changelog]: https://github.com/accetto/ubuntu-vnc-xfce/blob/master/CHANGELOG.md
[this-issues]: https://github.com/accetto/ubuntu-vnc-xfce/issues

[this-github-utils]: https://github.com/accetto/ubuntu-vnc-xfce/tree/master/utils/

[this-wiki]: https://github.com/accetto/ubuntu-vnc-xfce/wiki
[this-wiki-howto]: https://github.com/accetto/ubuntu-vnc-xfce/wiki/How-to
[this-wiki-troubleshooting]: https://github.com/accetto/ubuntu-vnc-xfce/wiki/Troubleshooting
[this-wiki-faq]: https://github.com/accetto/ubuntu-vnc-xfce/wiki/Frequently-asked-questions

[this-github-ubuntu-vnc-xfce]: https://github.com/accetto/ubuntu-vnc-xfce/tree/master/docker/ubuntu-vnc-xfce/
[this-github-ubuntu-vnc-xfce-chromium]: https://github.com/accetto/ubuntu-vnc-xfce/tree/master/docker/ubuntu-vnc-xfce-chromium/
[this-github-ubuntu-vnc-xfce-firefox]: https://github.com/accetto/ubuntu-vnc-xfce/tree/master/docker/ubuntu-vnc-xfce-firefox/
[this-github-ubuntu-vnc-xfce-firefox-plus]: https://github.com/accetto/ubuntu-vnc-xfce/tree/master/docker/ubuntu-vnc-xfce-firefox-plus/

[this-docker-ubuntu-vnc-xfce]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce/
[this-docker-ubuntu-vnc-xfce-chromium]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-chromium/
[this-docker-ubuntu-vnc-xfce-firefox-default]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-firefox-default/
[this-docker-ubuntu-vnc-xfce-firefox-plus]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-firefox-plus/

[this-github-readme-ubuntu-vnc-xfce]: https://github.com/accetto/ubuntu-vnc-xfce/blob/master/docker/ubuntu-vnc-xfce/README.md
[this-github-readme-ubuntu-vnc-xfce-chromium]: https://github.com/accetto/ubuntu-vnc-xfce/blob/master/docker/ubuntu-vnc-xfce-chromium/README.md
[this-github-readme-ubuntu-vnc-xfce-firefox]: https://github.com/accetto/ubuntu-vnc-xfce/blob/master/docker/ubuntu-vnc-xfce-firefox/README.md
[this-github-readme-ubuntu-vnc-xfce-firefox-plus]: https://github.com/accetto/ubuntu-vnc-xfce/blob/master/docker/ubuntu-vnc-xfce-firefox-plus/README.md

[accetto-github]: https://github.com/accetto/
[accetto-docker]: https://hub.docker.com/u/accetto/

[accetto-docker-ubuntu-vnc-xfce-chromium]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-chromium/
[accetto-docker-ubuntu-vnc-xfce-firefox-plus]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-firefox-plus/
[accetto-docker-ubuntu-vnc-xfce-firefox-default]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-firefox-default/

[accetto-github-ubuntu-vnc-xfce-chromium]: https://github.com/accetto/ubuntu-vnc-xfce-chromium
[accetto-github-ubuntu-vnc-xfce-firefox]: https://github.com/accetto/ubuntu-vnc-xfce-firefox
[accetto-github-ubuntu-vnc-xfce-firefox-plus]: https://github.com/accetto/ubuntu-vnc-xfce-firefox-plus

[accetto-docker-xubuntu-vnc]: https://hub.docker.com/r/accetto/xubuntu-vnc
[accetto-xubuntu-vnc-wiki-image-hierarchy]: https://github.com/accetto/xubuntu-vnc/wiki/Image-hierarchy

[accetto-docker-xubuntu-vnc-novnc]: https://hub.docker.com/r/accetto/xubuntu-vnc-novnc
[accetto-xubuntu-vnc-novnc-wiki-image-hierarchy]: https://github.com/accetto/xubuntu-vnc-novnc/wiki/Image-hierarchy

[accetto-ubuntu-vnc-xfce-g3]: https://github.com/accetto/ubuntu-vnc-xfce-g3

[accetto-docker-ubuntu-vnc-xfce-g3]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-g3
[accetto-docker-ubuntu-vnc-xfce-chromium-g3]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-chromium-g3
[accetto-docker-ubuntu-vnc-xfce-firefox-g3]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-firefox-g3

[accetto-docker-argbash-docker]: https://hub.docker.com/r/accetto/argbash-docker
[accetto-github-argbash-docker-utils]: https://github.com/accetto/argbash-docker/tree/master/utils

[docker-ubuntu]: https://hub.docker.com/_/ubuntu/
[docker-doc]: https://docs.docker.com/
[docker-doc-managing-data]: https://docs.docker.com/storage/
[docker-doc-capabilities]: https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities
[docker-for-windows]: https://hub.docker.com/editions/community/docker-ce-desktop-windows
[docker-desktop]: https://www.docker.com/products/docker-desktop

[consol-docker-ubuntu-xfce-vnc]: https://hub.docker.com/r/consol/ubuntu-xfce-vnc/
[consol-github-docker-headless-vnc-container]: https://github.com/ConSol/docker-headless-vnc-container
[consol-docker]: https://hub.docker.com/u/consol/

[qnap]: https://www.qnap.com/en/
[container-station]: https://www.qnap.com/solution/container_station/en/

[ubuntu-flavours]: https://www.ubuntu.com/download/flavours

[curl]: http://manpages.ubuntu.com/manpages/bionic/man1/curl.1.html
[chromium]: https://www.chromium.org/Home
[firefox]: https://www.mozilla.org
[git]: https://git-scm.com/
[jq]: https://stedolan.github.io/jq/
[mousepad]: https://github.com/codebrainz/mousepad
[nano]: https://www.nano-editor.org/
[novnc]: https://github.com/kanaka/noVNC
[novnc-releases]: https://github.com/novnc/noVNC/releases
[nsswrapper]: https://cwrap.org/nss_wrapper.html
[tigervnc]: http://tigervnc.org
[tigervnc-releases]: https://github.com/TigerVNC/tigervnc/releases
[tightvnc]: http://www.tightvnc.com
[vim]: https://www.vim.org/
[xfce]: http://www.xfce.org

[screenshot-container]: https://raw.githubusercontent.com/accetto/ubuntu-vnc-xfce/master/ubuntu-vnc-xfce.jpg

<!-- docker badges -->

[badge-docker-pulls]: https://badgen.net/docker/pulls/accetto/ubuntu-vnc-xfce?icon=docker&label=pulls

[badge-docker-stars]: https://badgen.net/docker/stars/accetto/ubuntu-vnc-xfce?icon=docker&label=stars

<!-- github badges -->

[badge-github-release]: https://badgen.net/github/release/accetto/ubuntu-vnc-xfce?icon=github&label=release

[badge-github-release-date]: https://img.shields.io/github/release-date/accetto/ubuntu-vnc-xfce?logo=github

[badge-github-stars]: https://badgen.net/github/stars/accetto/ubuntu-vnc-xfce?icon=github&label=stars

[badge-github-forks]: https://badgen.net/github/forks/accetto/ubuntu-vnc-xfce?icon=github&label=forks

[badge-github-releases]: https://badgen.net/github/releases/accetto/ubuntu-vnc-xfce?icon=github&label=releases

[badge-github-commits]: https://badgen.net/github/commits/accetto/ubuntu-vnc-xfce?icon=github&label=commits

[badge-github-last-commit]: https://badgen.net/github/last-commit/accetto/ubuntu-vnc-xfce?icon=github&label=last%20commit

[badge-github-closed-issues]: https://badgen.net/github/closed-issues/accetto/ubuntu-vnc-xfce?icon=github&label=closed%20issues

[badge-github-open-issues]: https://badgen.net/github/open-issues/accetto/ubuntu-vnc-xfce?icon=github&label=open%20issues

<!-- latest tag badges -->

[badge-VERSION_STICKER_LATEST]: https://badgen.net/badge/version%20sticker/ubuntu18.04.6/blue
