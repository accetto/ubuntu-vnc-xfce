# Headless Ubuntu/Xfce container with VNC/noVNC

## accetto/ubuntu-vnc-xfce

[Docker Hub][this-docker] - [Git Hub][this-github] - [Changelog][this-changelog] - [Wiki][this-wiki]

***

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

**TIP** Unless you need [nss_wrapper][nsswrapper], you can also use my newer image [accetto/xubuntu-vnc-novnc][accetto-docker-xubuntu-vnc-novnc], which is a streamlined version of this image ([image hierarchy][accetto-xubuntu-vnc-novnc-wiki-image-hierarchy]). If you also don't need [noVNC][novnc], you can use even a slimmer image [accetto/xubuntu-vnc][accetto-docker-xubuntu-vnc], which is the base of another growing family of application images ([image hierarchy][accetto-xubuntu-vnc-wiki-image-hierarchy]). The newer images include also **sudo** command.

***

**Attention:** Resources for building images with Firefox and configurable Firefox, previously contained in this repository, have been moved to their own GitHub repositories [ubuntu-vnc-xfce-firefox][accetto-github-ubuntu-vnc-xfce-firefox] and [ubuntu-vnc-xfce-firefox-plus][accetto-github-ubuntu-vnc-xfce-firefox-plus].

**This repository** contains resources for building a Docker image based on [Ubuntu][docker-ubuntu] with [Xfce][xfce] desktop environment and **VNC**/[noVNC][novnc] servers for headless use.

The image can be successfully built and used on Linux, Windows, Mac and NAS devices. It has been tested with [Docker Desktop][docker-desktop] on [Ubuntu flavours][ubuntu-flavours], [Windows 10][docker-for-windows] and [Container Station][container-station] from [QNAP][qnap].

This is also the base of my other Docker images with additional features (e.g. [accetto/ubuntu-vnc-xfce-firefox-plus][accetto-docker-ubuntu-vnc-xfce-firefox-plus] or [accetto/ubuntu-vnc-xfce-firefox-default][accetto-docker-ubuntu-vnc-xfce-firefox-default]).

Containers created from this image are perfect for learning, development or testing, because they can be easily used headless via web browsers (over [noVNC][novnc]) or VNC viewers (e.g. [TigerVNC][tigervnc] or [TightVNC][tightvnc]). Both **lite** and **full** [noVNC][novnc] clients are provided.

While the containers do not include any web browsers, [mousepad][mousepad] and [vim][vim] editors and the **ping** utility are already included. Other applications can be easily added also at runtime, because the containers run under the privileged **root** user.

It should be noticed, that the container's root is not the same as the host's root and that it does not automatically get all root privileges on the hosting computer. Please check the [Docker documentation][docker-doc] for more information about it (e.g. [Runtime privilege and Linux capabilities][docker-doc-capabilities]).

Running in background is the primary scenario for the containers, but using them interactively in foreground is also possible. For examples see the description below or the [HOWTO][this-wiki-howto] section in [Wiki][this-wiki].

The image contains the following components:

- utilities **ping**, **wget**, **zip**, **unzip**, **sudo**, [curl][curl], [git][git] (Ubuntu distribution)
- current version of JSON processor [jq][jq]
- light-weight [Xfce][xfce] desktop environment (Ubuntu distribution)
- current version of high-performance [TigerVNC][tigervnc] server and client
- current version of [noVNC][novnc] HTML5 clients (full and lite) (TCP port **6901**)
- popular text editor [vim][vim] (Ubuntu distribution)
- lite but advanced graphical editor [mousepad][mousepad] (Ubuntu distribution)
- support of **version sticker** (see below)

The image is regularly maintained and rebuilt. The history of notable changes is documented in [CHANGELOG][this-changelog].

![screenshot-container][screenshot-container]

### Image set

- [accetto/ubuntu-vnc-xfce][this-docker]

  Images based on the official [ubuntu][docker-ubuntu] images.

  - `latest` based on `ubuntu:latest`

    ![badge-VERSION_STICKER_LATEST][badge-VERSION_STICKER_LATEST]
    ![badge-github-commit-latest][badge-github-commit-latest]

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

Both **named volumes** and **bind mounts** can be used. More about volumes can be found in the [Docker documentation][docker-doc] (e.g. [Manage data in Docker][docker-doc-managing-data]).

### Version sticker

Version sticker serves multiple purposes that are closer described in [Wiki][this-wiki]. The **version sticker value** identifies the version of the docker image and it is persisted in it when it is built. It is also shown as a badge in the README file.

However, the script `version_sticker.sh` can be used anytime for convenient checking of the current versions of installed applications.

The script is deployed into the startup folder, which is defined by the environment variable `STARTUPDIR` with the default value of `/dockerstartup`.

If the script is executed inside a container without an argument, then it returns the **current version sticker value** of the container. This value is newly calculated and it is based on the current versions of the essential applications in the container.

The **current** version sticker value will differ from the **persisted** value, if any of the included application has been updated to another version.

If the script is called with the argument `-v` (lower case `v`), then it prints out verbose versions of the essential applications that are included in the **version sticker value**.

If it is called with the argument `-V` (upper case `v`), then it prints out verbose versions of some more applications.

Examples can be found in [Wiki][this-wiki].

## Running containers in background (detached)

The containers run under the privileged **root** user by default. However, it's the container's root, which is not the same as the root of the hosting computer (see above).

The following container will listen on automatically selected **TCP** ports of the host computer:

```docker
docker run -d -P accetto/ubuntu-vnc-xfce
```

The following container will listen on the host's explicit **TCP** ports **25901** (VNC) and **26901** (noVNC):

```docker
docker run -d -p 25901:5901 -p 26901:6901 accetto/ubuntu-vnc-xfce
```

The following container will create or re-use the local named volume **my\_Downloads** mounted as `/headless/Downloads`:

```docker
docker run -d -P -v my_Downloads:/home/headless/Downloads accetto/ubuntu-vnc-xfce
```

or using the newer syntax with **--mount** flag:

```docker
docker run -d -P --mount source=my_Downloads,target=/home/headless/Downloads accetto/ubuntu-vnc-xfce
```

More usage examples can be found in [Wiki][this-wiki] (section [HOWTO][this-wiki-howto]).

## Running containers in foreground (interactively)

The image supports the following container start-up options: `--wait` (default), `--skip`, `--debug` (also `--tail-log`) and `--help`.

The following container will print out the help and then it'll remove itself:

```docker
docker run --rm accetto/ubuntu-vnc-xfce --help
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
docker run --name foo accetto/ubuntu-vnc-xfce --debug
```

In the second terminal window on the host computer, execute the shell inside the **foo** container:

```docker
docker exec -it foo /bin/bash
```

## Using headless containers

There are two ways, how to use the created headless containers. Note that the default **VNC user** password is **headless**.

### Over VNC

To be able to use the containers over **VNC**, some **VNC Viewer** is needed (e.g. [TigerVNC][tigervnc] or [TightVNC][tightvnc]).

The VNC Viewer should connect to the host running the container, pointing to its TCP port mapped to the container's TCP port **5901**.

For example, if the container has been created on the host called `mynas` using the parameters described above, the VNC Viewer should connect to `mynas:25901`.

### Over noVNC

To be able to use the containers over [noVNC][novnc], an HTML5 capable web browser is needed. It actually means, that any current web browser can be used.

The browser should navigate to the host running the container, pointing to its TCP port mapped to the container's TCP port **6901**.

However, since the version **1.2.0** the containers offer two [noVNC][novnc] clients. Additionally to the previously available **lite** client there is also the **full** client with more features. The connection URL differs slightly in both cases. To make it easier, a **simple startup page** is implemented.

If the container has been created on the host called `mynas` using the parameters described above, then the web browser should navigate to `http://mynas:26901`.

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

This project has been originally inspired by the docker image [consol/ubuntu-xfce-vnc][consol-docker-ubuntu-xfce-vnc] and derived from its GitHub repository [ConSol/docker-headless-vnc-container][consol-github-docker-headless-vnc-container].

Credit also goes to all the countless people and companies who contribute to open source community and make so many dreamy things real.

***

[this-docker]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce/
[this-github]: https://github.com/accetto/ubuntu-vnc-xfce

[this-changelog]: https://github.com/accetto/ubuntu-vnc-xfce/blob/master/CHANGELOG.md
[this-issues]: https://github.com/accetto/ubuntu-vnc-xfce/issues

[this-wiki]: https://github.com/accetto/ubuntu-vnc-xfce/wiki
[this-wiki-howto]: https://github.com/accetto/ubuntu-vnc-xfce/wiki/How-to
[this-wiki-troubleshooting]: https://github.com/accetto/ubuntu-vnc-xfce/wiki/Troubleshooting
[this-wiki-faq]: https://github.com/accetto/ubuntu-vnc-xfce/wiki/Frequently-asked-questions

[accetto-github]: https://github.com/accetto/
[accetto-docker]: https://hub.docker.com/u/accetto/

[accetto-docker-ubuntu-vnc-xfce-firefox-plus]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-firefox-plus/
[accetto-docker-ubuntu-vnc-xfce-firefox-default]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-firefox-default/

[accetto-github-ubuntu-vnc-xfce-firefox]: https://github.com/accetto/ubuntu-vnc-xfce-firefox
[accetto-github-ubuntu-vnc-xfce-firefox-plus]: https://github.com/accetto/ubuntu-vnc-xfce-firefox-plus

[accetto-docker-xubuntu-vnc]: https://hub.docker.com/r/accetto/xubuntu-vnc
[accetto-xubuntu-vnc-wiki-image-hierarchy]: https://github.com/accetto/xubuntu-vnc/wiki/Image-hierarchy

[accetto-docker-xubuntu-vnc-novnc]: https://hub.docker.com/r/accetto/xubuntu-vnc-novnc
[accetto-xubuntu-vnc-novnc-wiki-image-hierarchy]: https://github.com/accetto/xubuntu-vnc-novnc/wiki/Image-hierarchy

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
[firefox]: https://www.mozilla.org
[git]: https://git-scm.com/
[jq]: https://stedolan.github.io/jq/
[mousepad]: https://github.com/codebrainz/mousepad
[novnc]: https://github.com/kanaka/noVNC
[nsswrapper]: https://cwrap.org/nss_wrapper.html
[tigervnc]: http://tigervnc.org
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

[badge-VERSION_STICKER_LATEST]: https://badgen.net/badge/version%20sticker/ubuntu18.04.4/blue

[badge-github-commit-latest]: https://images.microbadger.com/badges/commit/accetto/ubuntu-vnc-xfce.svg
