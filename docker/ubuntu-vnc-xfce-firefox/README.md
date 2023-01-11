# Headless Ubuntu/Xfce container with VNC/noVNC and Firefox

## accetto/ubuntu-vnc-xfce-firefox-default

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

- [Headless Ubuntu/Xfce container with VNC/noVNC and Firefox](#headless-ubuntuxfce-container-with-vncnovnc-and-firefox)
  - [accetto/ubuntu-vnc-xfce-firefox-default](#accettoubuntu-vnc-xfce-firefox-default)
    - [Introduction](#introduction)
    - [Description](#description)
  - [Image set](#image-set)
    - [Ports](#ports)
    - [Volumes](#volumes)
    - [Version sticker](#version-sticker)
  - [Firefox multi-process](#firefox-multi-process)
    - [Setting shared memory size](#setting-shared-memory-size)
  - [Running containers in background (detached)](#running-containers-in-background-detached)
  - [Running containers in foreground (interactively)](#running-containers-in-foreground-interactively)
  - [Using headless containers](#using-headless-containers)
    - [Over VNC](#over-vnc)
    - [Over noVNC](#over-novnc)
  - [Issues](#issues)
  - [Credits](#credits)

***

**Attention:** The **Docker Hub** repository is called [*ubuntu-vnc-xfce-firefox*-**default**][this-docker] to avoid conflicts with the previously existing older image.

**Tip** If you want newer images based on [Ubuntu 20.04 LTS][docker-ubuntu] with the latest [TigerVNC][tigervnc-releases]/[noVNC][novnc-releases] versions, please check the **third generation** (G3) [accetto/ubuntu-vnc-xfce-g3][accetto-docker-ubuntu-vnc-xfce-g3], [accetto/ubuntu-vnc-xfce-chromium-g3][accetto-docker-ubuntu-vnc-xfce-chromium-g3] or [accetto/ubuntu-vnc-xfce-firefox-g3][accetto-docker-ubuntu-vnc-xfce-firefox-g3].

**Tip** Unless you need the [nss_wrapper][nsswrapper], you can also use the **second generation** (G2) image [accetto/xubuntu-vnc-novnc-firefox:default][accetto-docker-xubuntu-vnc-novnc-firefox:default], which is a streamlined version of this image ([image hierarchy][accetto-xubuntu-vnc-novnc-wiki-image-hierarchy]). The image supports also the **sudo** command.

***

**WARNING** about images with Firefox

Starting from the release **20.10.1**, there is no single-process Firefox image and the multi-process mode is always enabled. Be aware, that multi-process requires larger shared memory (`/dev/shm`). At least 256MB is recommended. Please check the [Firefox multi-process][that-wiki-firefox-multiprocess] page in Wiki for more information and the instructions, how to set the shared memory size in different scenarios.

***

### Introduction

This repository contains resources for building a Docker image based on [Ubuntu 18.04 LTS][docker-ubuntu] with [Xfce][xfce] desktop environment, **VNC**/[noVNC][novnc] servers for headless use and the current [Firefox][firefox] web browser in its default installation.

The image can be successfully built and used on Linux, Windows, Mac and NAS devices. It has been tested with [Docker Desktop][docker-desktop] on [Ubuntu flavours][ubuntu-flavours], [Windows 10][docker-for-windows] and [Container Station][container-station] from [QNAP][qnap].

This is the **first generation** (G1) of my headless images, that I've retired back in March 2022. However, because I've noticed that the images are still pulled, I've revived the project in November 2022.

The current **second version** (G1v2) brings some improvements, mostly in the building pipeline and supporting scripts.

It also merges the previously separated **GitHub** projects [ubuntu-vnc-xfce-firefox][accetto-github-ubuntu-vnc-xfce-firefox],  [ubuntu-vnc-xfce-firefox-plus][accetto-github-ubuntu-vnc-xfce-firefox-plus] and [ubuntu-vnc-xfce-chromium][accetto-github-ubuntu-vnc-xfce-chromium] into the single project [ubuntu-vnc-xfce][accetto-github-ubuntu-vnc-xfce].

### Description

**This image** `accetto/ubuntu-vnc-xfce-firefox-default` adds the [Firefox Browser][firefox] in its default installation to the base image [ubuntu-vnc-xfce][accetto-github-ubuntu-vnc-xfce].

Note that the [Firefox Browser][firefox] runs in the **multi-process mode** and therefore requires larger shared memory (`/dev/shm`). At least 256MB is recommended. Please check the [Firefox multi-process][that-wiki-firefox-multiprocess] page in Wiki for more information.

Containers created from this image make perfect light-weight web browsers. They can be thrown away easily and replaced quickly, improving browsing privacy. They run under a non-root user by default, improving browsing security.

Running in background is the primary scenario for the containers, but using them interactively in foreground is also possible. For examples see the description below or the [HOWTO][this-wiki-howto] section in [Wiki][this-wiki].

The image inherits the following components from its [base image][accetto-docker-ubuntu-vnc-xfce]:

- utilities **ping**, **wget**, **zip**, **unzip**, [curl][curl], [git][git] (Ubuntu distribution)
- current version of JSON processor [jq][jq]
- light-weight [Xfce][xfce] desktop environment (Ubuntu distribution)
- current version of high-performance [TigerVNC][tigervnc] server and client
- current version of [noVNC][novnc] HTML5 clients (full and lite) (TCP port **6901**)
- popular text editors [vim][vim] and [nano][nano] (Ubuntu distribution)
- lite but advanced graphical editor [mousepad][mousepad] (Ubuntu distribution)
- support of **version sticker** (see below)

The image is regularly maintained and rebuilt. The history of notable changes is documented in [CHANGELOG][this-changelog].

![screenshot-container][screenshot-container]

## Image set

- [accetto/ubuntu-vnc-xfce-firefox-default][this-docker]

  - `latest` based on `accetto/ubuntu-vnc-xfce:latest`

    ![badge-VERSION_STICKER_LATEST][badge-VERSION_STICKER_LATEST]

### Ports

Following **TCP** ports are exposed:

- **5901** used for access over **VNC**
- **6901** used for access over [noVNC][novnc]

The default **VNC user** password is **headless**.

### Volumes

The containers do not create or use any external volumes by default. However, the following folders make good mounting points:

- /home/headless/Documents/
- /home/headless/Downloads/
- /home/headless/Music/
- /home/headless/Pictures/
- /home/headless/Public/
- /home/headless/Templates/
- /home/headless/Videos/

The following mounting point is specific to Firefox:

- /home/headless/.mozilla

Both *named volumes* and *bind mounts* can be used. More about volumes can be found in [Docker documentation][docker-doc] (e.g. [Manage data in Docker][docker-doc-managing-data]).

### Version sticker

Version sticker serves multiple purposes that are closer described in [Wiki][this-wiki]. The **version sticker value** identifies the version of the docker image and it is persisted in it when it is built. It is also shown as a badge in the README file.

However, the script `version_sticker.sh` can be used anytime for convenient checking of the current versions of installed applications.

The script is deployed into the startup folder, which is defined by the environment variable `STARTUPDIR` with the default value of `/dockerstartup`.

If the script is executed inside a container without an argument, then it returns the **current version sticker value** of the container. This value is newly calculated and it is based on the current versions of the essential applications in the container.

The **current** version sticker value will differ from the **persisted** value, if any of the included application has been updated to another version.

If the script is called with the argument `-v` (lower case `v`), then it prints out verbose versions of the essential applications that are included in the **version sticker value**.

If it is called with the argument `-V` (upper case `v`), then it prints out verbose versions of some more applications.

Examples can be found in [Wiki][this-wiki].

## Firefox multi-process

Firefox multi-process (also known as **Electrolysis** or just **E10S**) can cause heavy crashing in Docker containers if there is not enough shared memory (**Gah. Your tab just crashed.**).

In Firefox versions till **76.0.1** it has been possible to disable multi-process by setting the environment variable **MOZ_FORCE_DISABLE_E10S**. However, in Firefox **77.0.1** it has caused ugly scrambling of almost all web pages, because they were not decompressed.

Mozilla has fixed the problem in the next release, but they warned about not supporting the switch in future. That is why I've decided, that the mainstream image tagged as `latest` will use multi-process by default, even if it requires larger shared memory. On the positive side, performance should be higher and Internet browsing should be sand-boxed.

For some time I've maintained also `singleprocess` images intended for scenarios, where increasing the shared memory size is not possible or not wanted. However, by Firefox **81.0** I've noticed, that the environment variable **MOZ_FORCE_DISABLE_E10S** has no effect any more. Since then all images run Firefox in multi-process mode.

Please check the Wiki page [Firefox multi-process][that-wiki-firefox-multiprocess] for more information and the instructions, how the shared memory size can be set in different scenarios.

### Setting shared memory size

Instability of multi-process Firefox is caused by setting the shared memory size too low. Docker assigns only **64MB** by default. Testing on my computers has shown, that using at least **256MB** completely eliminates the problem. However, it could be different on your system.

The Wiki page [Firefox multi-process][that-wiki-firefox-multiprocess] describes several ways, how to increase the shared memory size. It's really simple, if you need it for a single container started from the command line.

For example, the following container will have its shared memory size set to 256MB:

```bash
docker run -d -P --shm-size=256m accetto/xubuntu-vnc-xfce-firefox-default
```

You can check the current shared memory size by executing the following command inside the container:

```bash
df -h /dev/shm
```

## Running containers in background (detached)

Created containers will run under the non-root user **headless:headless** by default.

The following container will listen on automatically selected **TCP** ports of the host computer:

```docker
docker run -d -P accetto/ubuntu-vnc-xfce-firefox-default
```

The following container will listen on the host's explicit **TCP** ports **25901** (VNC) and **26901** (noVNC):

```docker
docker run -d -p 25901:5901 -p 26901:6901 accetto/ubuntu-vnc-xfce-firefox-default
```

The following container wil create or re-use the local named volume **my\_Downloads** mounted as `/home/headless/Downloads`. The container will be accessible through the same **TCP** ports as the one above:

```docker
docker run -d -P -v my_Downloads:/home/headless/Downloads accetto/ubuntu-vnc-xfce-firefox-default
```

or using the newer syntax with **--mount** flag:

```docker
docker run -d -P --mount source=my_Downloads,target=/home/headless/Downloads accetto/ubuntu-vnc-xfce-firefox-default
```

More usage examples can be found in [Wiki][this-wiki] (section [HOWTO][this-wiki-howto]).

## Running containers in foreground (interactively)

The image supports the following container start-up options: `--wait` (default), `--skip`, `--debug` (also `--tail-log`) and `--help`. This functionality is inherited from the [base image][accetto-docker-ubuntu-vnc-xfce].

The following container will print out the help and then it'll remove itself:

```docker
docker run --rm accetto/ubuntu-vnc-xfce-firefox-default --help
```

Excerpt from the output, which describes the other options:

```docker
OPTIONS:
-w, --wait      (default) Keeps the UI and the vnc server up until SIGINT or SIGTERM are received.
                An optional command can be executed after the vnc starts up.
                example: docker run -d -P accetto/ubuntu-vnc-xfce
                example: docker run -it -P --rm accetto/ubuntu-vnc-xfce bash

-s, --skip      Skips the vnc startup and just executes the provided command.
                example: docker run -it -P --rm accetto/ubuntu-vnc-xfce --skip echo $BASH_VERSION

-d, --debug     Executes the vnc startup and tails the vnc/noVNC logs.
                Any parameters after '--debug' are ignored. CTRL-C stops the container.
                example: docker run -it -P --rm accetto/ubuntu-vnc-xfce --debug

-t, --tail-log  same as '--debug'

-h, --help      Prints out this help.
                example: docker run --rm accetto/ubuntu-vnc-xfce
```

It should be noticed, that the `--debug` start-up option does not show the command prompt even if the `-it` run arguments are provided. This is because the container is watching the incoming vnc/noVNC connections and prints out their logs in real time. However, it is easy to attach to the running container like in the following example.

In the first terminal window on the host computer, create a new container named **foo**:

```docker
docker run --name foo accetto/ubuntu-vnc-xfce-firefox-default --debug
```

In the second terminal window on the host computer, execute the shell inside the **foo** container:

```docker
docker exec -it foo /bin/bash
```

## Using headless containers

There are two ways, how to use the created headless containers. Note that the default **VNC user** password is **headless**.

### Over VNC

To be able to use the containers over **VNC**, a **VNC Viewer** is needed (e.g. [TigerVNC][tigervnc] or [TightVNC][tightvnc]).

The VNC Viewer should connect to the host running the container, pointing to the host's TCP port mapped to the container's TCP port **5901**.

For example, if the container has been created on the host called `mynas` using the parameters described above, the VNC Viewer should connect to `mynas:25901`.

### Over noVNC

To be able to use the containers over [noVNC][novnc], an HTML5 capable web browser is needed. It actually means, that any current web browser can be used.

The browser should navigate to the host running the container, pointing to the host's TCP port mapped to the container's TCP port **6901**.

However, the containers offer two [noVNC][novnc] clients - **lite** and **full**. The connection URL differs slightly in both cases. To make it easier, a simple startup page is implemented.

If the container have been created on the host called `mynas` using the parameters described above, then the web browser should navigate to `http://mynas:26901`.

The startup page will show two hyperlinks pointing to the both noVNC clients:

- `http://mynas:26901/vnc_lite.html`
- `http://mynas:26901/vnc.html`

It's also possible to provide the password through the links:

- `http://mynas:26901/vnc_lite.html?password=headless`
- `http://mynas:26901/vnc.html?password=headless`

## Issues

If you have found a problem or you just have a question, please check the [Issues][this-issues] and the [Troubleshooting][this-wiki-troubleshooting], [FAQ][this-wiki-faq] and [HOWTO][this-wiki-howto] sections in [Wiki][this-wiki] first. Please do not overlook the closed issues.

If you do not find a solution, you can file a new issue. The better you describe the problem, the bigger the chance it'll be solved soon.

## Credits

Credit goes to all the countless people and companies who contribute to open source community and make so many dreamy things real.

***

[this-docker]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-firefox-default/
[this-github]: https://github.com/accetto/ubuntu-vnc-xfce

[this-changelog]: https://github.com/accetto/ubuntu-vnc-xfce/blob/master/CHANGELOG.md
[this-issues]: https://github.com/accetto/ubuntu-vnc-xfce/issues

[this-wiki]: https://github.com/accetto/ubuntu-vnc-xfce-firefox/wiki
[this-wiki-howto]: https://github.com/accetto/ubuntu-vnc-xfce-firefox/wiki/How-to
[this-wiki-troubleshooting]: https://github.com/accetto/ubuntu-vnc-xfce-firefox/wiki/Troubleshooting
[this-wiki-faq]: https://github.com/accetto/ubuntu-vnc-xfce-firefox/wiki/Frequently-asked-questions

[that-wiki-firefox-multiprocess]: https://github.com/accetto/xubuntu-vnc/wiki/Firefox-multiprocess

[accetto-github]: https://github.com/accetto/
[accetto-docker]: https://hub.docker.com/u/accetto/

[accetto-github-ubuntu-vnc-xfce]: https://github.com/accetto/ubuntu-vnc-xfce
[accetto-github-ubuntu-vnc-xfce-chromium]: https://github.com/accetto/ubuntu-vnc-xfce-chromium
[accetto-github-ubuntu-vnc-xfce-firefox]: https://github.com/accetto/ubuntu-vnc-xfce-firefox
[accetto-github-ubuntu-vnc-xfce-firefox-plus]: https://github.com/accetto/ubuntu-vnc-xfce-firefox-plus
[accetto-docker-ubuntu-vnc-xfce]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce/

[accetto-docker-xubuntu-vnc-firefox:default]:https://hub.docker.com/r/accetto/xubuntu-vnc-firefox/
[accetto-xubuntu-vnc-wiki-image-hierarchy]: https://github.com/accetto/xubuntu-vnc/wiki/Image-hierarchy

[accetto-ubuntu-vnc-xfce-g3]: https://github.com/accetto/ubuntu-vnc-xfce-g3

[accetto-docker-ubuntu-vnc-xfce-g3]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-g3
[accetto-docker-ubuntu-vnc-xfce-chromium-g3]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-chromium-g3
[accetto-docker-ubuntu-vnc-xfce-firefox-g3]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-firefox-g3

[accetto-docker-xubuntu-vnc-novnc-firefox:default]: https://hub.docker.com/r/accetto/xubuntu-vnc-novnc-firefox/
[accetto-xubuntu-vnc-novnc-wiki-image-hierarchy]: https://github.com/accetto/xubuntu-vnc-novnc/wiki/Image-hierarchy

[accetto-github-ubuntu-vnc-xfce-firefox-plus]: https://github.com/accetto/ubuntu-vnc-xfce-firefox-plus/
[accetto-docker-ubuntu-vnc-xfce-firefox-plus]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-firefox-plus/

[docker-ubuntu]: https://hub.docker.com/_/ubuntu/
[docker-doc]: https://docs.docker.com/
[docker-doc-managing-data]: https://docs.docker.com/storage/
[docker-for-windows]: https://hub.docker.com/editions/community/docker-ce-desktop-windows
[docker-desktop]: https://www.docker.com/products/docker-desktop

[qnap]: https://www.qnap.com/en/
[container-station]: https://www.qnap.com/solution/container_station/en/

[ubuntu-flavours]: https://www.ubuntu.com/download/flavours

[curl]: http://manpages.ubuntu.com/manpages/bionic/man1/curl.1.html
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

[screenshot-container]: https://raw.githubusercontent.com/accetto/ubuntu-vnc-xfce/master/docker/ubuntu-vnc-xfce-firefox/ubuntu-vnc-xfce-firefox.jpg

<!-- docker badges -->

[badge-docker-pulls]: https://badgen.net/docker/pulls/accetto/ubuntu-vnc-xfce-firefox-default?icon=docker&label=pulls

[badge-docker-stars]: https://badgen.net/docker/stars/accetto/ubuntu-vnc-xfce-firefox-default?icon=docker&label=stars

<!-- github badges -->

[badge-github-release]: https://badgen.net/github/release/accetto/ubuntu-vnc-xfce-firefox?icon=github&label=release

[badge-github-release-date]: https://img.shields.io/github/release-date/accetto/ubuntu-vnc-xfce-firefox?logo=github

[badge-github-stars]: https://badgen.net/github/stars/accetto/ubuntu-vnc-xfce-firefox?icon=github&label=stars

[badge-github-forks]: https://badgen.net/github/forks/accetto/ubuntu-vnc-xfce-firefox?icon=github&label=forks

[badge-github-releases]: https://badgen.net/github/releases/accetto/ubuntu-vnc-xfce-firefox?icon=github&label=releases

[badge-github-commits]: https://badgen.net/github/commits/accetto/ubuntu-vnc-xfce-firefox?icon=github&label=commits

[badge-github-last-commit]: https://badgen.net/github/last-commit/accetto/ubuntu-vnc-xfce-firefox?icon=github&label=last%20commit

[badge-github-closed-issues]: https://badgen.net/github/closed-issues/accetto/ubuntu-vnc-xfce-firefox?icon=github&label=closed%20issues

[badge-github-open-issues]: https://badgen.net/github/open-issues/accetto/ubuntu-vnc-xfce-firefox?icon=github&label=open%20issues

<!-- latest tag badges -->

[badge-VERSION_STICKER_LATEST]: https://badgen.net/badge/version%20sticker/ubuntu18.04.6-firefox108.0.2/blue

