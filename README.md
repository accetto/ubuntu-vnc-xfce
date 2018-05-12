# Headless Ubuntu/Xfce containers with VNC/noVNC

## accetto/ubuntu-vnc-xfce

[Docker Hub][this-docker] - [Git Hub][this-github] - [Changelog][this-changelog] - [Wiki][this-wiki]

**Attention:** Resources for building images with Firefox and configurable Firefox, previously contained in this repository, have been moved to their own GitHub repositories [ubuntu-vnc-xfce-firefox][accetto-github-ubuntu-vnc-xfce-firefox] and [ubuntu-vnc-xfce-firefox-plus][accetto-github-ubuntu-vnc-xfce-firefox-plus].

***

**This repository** contains resources for building Docker images based on [Ubuntu][docker-ubuntu], with [Xfce][xfce] desktops and headless **VNC**/[noVNC][novnc] environments.

These images can be also successfully built and used on NAS devices. They
have been tested with [Container Station][container-station] from [QNAP][qnap].

The images are also used as bases for other Docker images with additional features (e.g. [accetto/ubuntu-vnc-xfce-firefox-default][accetto-docker-ubuntu-vnc-xfce-firefox-default] or [accetto/ubuntu-vnc-xfce-firefox-plus][accetto-docker-ubuntu-vnc-xfce-firefox-plus]).

Containers created from these images are perfect for learning, testing or development, because they can be used headless over VNC using a **VNC Viewer** (e.g. [TigerVNC][tigervnc]] or [TightVNC][tightvnc]) or directly from a web browser over [noVNC][novnc]. Any web browser supporting HTML5 can be used. Both **lite** and **full** [noVNC][novnc] clients are provided.

It should be noticed, that the containers do not include any web browser and that they run under the privileged **root** user by default. However, the graphical editor [leafpad][leafpad] and the text editor [vim][vim] are already included and other applications can be added by the user easily.

The image contains the following components:

- light-weight [Xfce][xfce] desktop environment
- high-performance VNC server [TigerVNC][tigervnc] (TCP port **5901**)
- [noVNC][novnc] HTML5 clients (full and lite) (TCP port **6901**)
- light-weight graphical editor [leafpad][leafpad]
- popular text editor [vim][vim]

The images are regularly maintained and rebuilt. The history of notable changes is documented in [CHANGELOG][this-changelog].

### Image set

- [accetto/ubuntu-vnc-xfce][this-docker]

  Images based on the official [ubuntu][docker-ubuntu] images.

  - `latest` based on `ubuntu:latest`
  - `rolling` based on `ubuntu:rolling`

    [![version badge](https://images.microbadger.com/badges/version/accetto/ubuntu-vnc-xfce.svg)](https://microbadger.com/images/accetto/ubuntu-vnc-xfce "Get your own version badge on microbadger.com") [![size badge](https://images.microbadger.com/badges/image/accetto/ubuntu-vnc-xfce.svg)](https://microbadger.com/images/accetto/ubuntu-vnc-xfce "Get your own image badge on microbadger.com") [![version badge](https://images.microbadger.com/badges/version/accetto/ubuntu-vnc-xfce:rolling.svg)](https://microbadger.com/images/accetto/ubuntu-vnc-xfce:rolling "Get your own version badge on microbadger.com") [![size badge](https://images.microbadger.com/badges/image/accetto/ubuntu-vnc-xfce:rolling.svg)](https://microbadger.com/images/accetto/ubuntu-vnc-xfce:rolling "Get your own image badge on microbadger.com")

### Ports

Following **TCP** ports are exposed:

- **5901** used for access over **VNC**
- **6901** used for access over [noVNC][novnc]

The default **VNC user** password is **headless**.

### Volumes

The images do not create or use any external volumes by default. However, the following folders make good mounting points:

- /headless/Documents/
- /headless/Downloads/
- /headless/Music/
- /headless/Pictures/
- /headless/Public/
- /headless/Templates/
- /headless/Videos/

Both **named volumes** and **bind mounts** can be used. More about volumes can be found in [Docker documentation][docker-doc-managing-data].

## Creating containers

Created containers will run under the privileged **root** user by default.

The following container will listen on the host's **TCP** ports **25901** (VNC) and **26901** (noVNC):

```docker
docker run -d -p 25901:5901 -p 26901:6901 accetto/ubuntu-vnc-xfce
```

The following container wil create or re-use the local named volume **my\_Downloads** mounted as `/headless/Downloads`. The container will be accessible through the same **TCP** ports as the one above:

```docker
docker run -d -p 25901:5901 -p 26901:6901 -v my_Downloads:/headless/Downloads accetto/ubuntu-vnc-xfce
```

or using the newer syntax with **--mount** flag:

```docker
docker run -d -p 25901:5901 -p 26901:6901 --mount source=my_Downloads,target=/headless/Downloads accetto/ubuntu-vnc-xfce
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

However, since the version **1.2.0** the containers offer two [noVNC][novnc] clients. Additionally to the previously available **lite** client there is also the **full** client with more features. The connection URL differs slightly in both cases. To make it easier, a simple startup page is implemented.

If the container have been created on the host called `mynas` using the parameters described above, then the web browser should navigate to `http://mynas:26901`.

The startup page will show two hyperlinks pointing to the both noVNC clients:

- `http://mynas:26901/vnc_lite.html`
- `http://mynas:26901/vnc.html`

It's also possible to provide the password through the links:

- `http://mynas:26901/vnc_lite.html?password=headless`
- `http://mynas:26901/vnc.html?password=headless`

## Issues

If you have found a problem or just have a question, please check the [Issues][this-issues] and the [Troubleshooting][this-wiki-troubleshooting], [FAQ][this-wiki-faq] and [HOWTO][this-wiki-howto] pages in [Wiki][this-wiki] first. Please do not overlook the closed issues.

If you do not find a solution, you can file a new issue. The better you describe the problem, the bigger the chance it'll be solved soon.

## Credits

This project has been originally inspired by the docker image [consol/ubuntu-xfce-vnc][consol-docker-ubuntu-xfce-vnc] and derived from its GitHub repository [ConSol/docker-headless-vnc-container][consol-github-docker-headless-vnc-container].

Credit also goes to all the countless people and companies who contribute to open source community and make so many dreamy things real.

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

[docker-ubuntu]: https://hub.docker.com/_/ubuntu/
[docker-doc-managing-data]: https://docs.docker.com/storage/

[xfce]: http://www.xfce.org
[tigervnc]: http://tigervnc.org
[novnc]: https://github.com/kanaka/noVNC
[leafpad]: https://en.wikipedia.org/wiki/Leafpad
[tightvnc]: http://www.tightvnc.com
[firefox]: https://www.mozilla.org
[vim]: https://www.vim.org/

[consol-docker-ubuntu-xfce-vnc]: https://hub.docker.com/r/consol/ubuntu-xfce-vnc/
[consol-github-docker-headless-vnc-container]: https://github.com/ConSol/docker-headless-vnc-container
[consol-docker]: https://hub.docker.com/u/consol/

[qnap]: https://www.qnap.com/en/
[container-station]: https://www.qnap.com/solution/container_station/en/
