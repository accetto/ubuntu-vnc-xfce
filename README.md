# Headless Ubuntu/Xfce containers with VNC/noVNC and customizable Firefox

This repository contains resources for building Docker images based on [Ubuntu][docker-ubuntu], with [Xfce][xfce] desktops and headless **VNC**/[noVNC][novnc] environments. Resources for building images with customizable [Firefox][firefox] browser are included as well.

These images can be successfully built and used on NAS devices. They
have been tested with [Container Station][container-station] from [QNAP][qnap].

The base images (see [below](#user-content-image-set)) are best suited for creating headless [Ubuntu][docker-ubuntu] containers, used for learning, testing or development.

The images with [Firefox][firefox] are perfect for fast creation of secure and light-weight web browser containers. They can be thrown away easily and replaced quickly, improving user's browsing privacy.

They make also excellent long-term browsers, because the preferences and profiles can be easily pre-configured and stored on external volumes that survive container destruction. 

Frequently used preferences and profiles can be also embedded into images themselves, for even faster creation of pre-configured browsers. Check the project [Wiki][wiki] for more details.

All images share the following common components

- light-weight [Xfce][xfce] desktop environment
- high-performance VNC server [TigerVNC][tigervnc] (TCP port **5901**)
- [noVNC][novnc] HTML5 clients (full and light ones) (TCP port **6901**)
- light-weight graphical editor [leafpad][leafpad]
- popular text editor [vim][vim]

Images with Firefox add the following features

- current [Firefox][firefox] Quantum web browser
- support for pre-configured Firefox preferences and profiles

The images are regularly maintained and rebuilt. The history of notable changes is documented in [CHANGELOG][accetto-github-changelog].

## Image set

- [`accetto/ubuntu-vnc-xfce`][acceto-docker-vnc-base]

    This is the base [Ubuntu][docker-ubuntu] image with [Xfce][xfce] desktop and **VNC**/[nonVNC][novnc] headless environments. Containers created from this image are accessible over VNC using a **VNC Viewer** (e.g. [TigerVNC][tigervnc]] or [TightVNC][tightvnc]) or directly from a web browser over [noVNC][novnc]. Any web browser supporting HTML5 can be used. It should be noticed, that these containers do not include any web browser and that they run under the privileged **root** user by default. However, the graphical editor [leafpad][leafpad] and the text editor [vim][vim] are already included.

- [`accetto/ubuntu-vnc-xfce-firefox`][accetto-docker-vnc-firefox]

    This image is based on the one above and it adds **Firefox** web browser. It runs under a non-root **VNC user** by default. The frequently used Firefox preferences can be put into the included file **user.js**, which can be edited or deleted by the non-root **VNC user** (see the project [Wiki][wiki] for more details).

- `accetto/ubuntu-vnc-xfce-firefox-preferences`, `accetto/ubuntu-vnc-xfce-firefox-profile`

    These optional images are based on the one above and they add pre-configured **Firefox preferences** or a complete **Firefox profile**. They are not actually contained in the [Docker repository][accetto-docker] in the form of pre-built images, but the [GitHub repository][accetto-github] includes the ready-to-use [Dockerfiles][accetto-github-extras] to build them yourself. The [HOWTO][wiki-howto] page in [Wiki][wiki] explains how to do it.

## Supported tags and respective `Dockerfile` links

- [`accetto/ubuntu-vnc-xfce`][acceto-docker-vnc-base]

  - `latest` based on `ubuntu:latest` ([`Dockerfile`][acceto-dockerfile-vnc-base-latest])
  - `rolling` based on `ubuntu:rolling` ([`Dockerfile`][acceto-dockerfile-vnc-base-rolling])

    [![version badge](https://images.microbadger.com/badges/version/accetto/ubuntu-vnc-xfce.svg)](https://microbadger.com/images/accetto/ubuntu-vnc-xfce "Get your own version badge on microbadger.com") [![size badge](https://images.microbadger.com/badges/image/accetto/ubuntu-vnc-xfce.svg)](https://microbadger.com/images/accetto/ubuntu-vnc-xfce "Get your own image badge on microbadger.com") [![version badge](https://images.microbadger.com/badges/version/accetto/ubuntu-vnc-xfce:rolling.svg)](https://microbadger.com/images/accetto/ubuntu-vnc-xfce:rolling "Get your own version badge on microbadger.com") [![size badge](https://images.microbadger.com/badges/image/accetto/ubuntu-vnc-xfce:rolling.svg)](https://microbadger.com/images/accetto/ubuntu-vnc-xfce:rolling "Get your own image badge on microbadger.com")

- [`accetto/ubuntu-vnc-xfce-firefox`][accetto-docker-vnc-firefox]

  - `latest` based on `accetto/ubuntu-vnc-xfce:latest` ([`Dockerfile`][accetto-dockerfile-vnc-firefox-latest])
  - `rolling` based on `accetto/ubuntu-vnc-xfce:rolling` ([`Dockerfile`][accetto-dockerfile-vnc-firefox-rolling])

    [![version badge](https://images.microbadger.com/badges/version/accetto/ubuntu-vnc-xfce-firefox.svg)](https://microbadger.com/images/accetto/ubuntu-vnc-xfce-firefox "Get your own version badge on microbadger.com") [![size badge](https://images.microbadger.com/badges/image/accetto/ubuntu-vnc-xfce-firefox.svg)](https://microbadger.com/images/accetto/ubuntu-vnc-xfce-firefox "Get your own image badge on microbadger.com") [![version badge](https://images.microbadger.com/badges/version/accetto/ubuntu-vnc-xfce-firefox:rolling.svg)](https://microbadger.com/images/accetto/ubuntu-vnc-xfce-firefox:rolling "Get your own version badge on microbadger.com") [![size badge](https://images.microbadger.com/badges/image/accetto/ubuntu-vnc-xfce-firefox:rolling.svg)](https://microbadger.com/images/accetto/ubuntu-vnc-xfce-firefox:rolling "Get your own image badge on microbadger.com")

### Ports

All images expose the following **TCP** ports:

- **5901** used for access over **VNC**
- **6901** used for access over [noVNC][novnc]

The default **VNC user** password is **headless**.

### Volumes

The images do not create or use any external volumes by default. However, the following mounting point is available in all images:

- `/headless/Documents`

The images with [Firefox][firefox] add two more mounting points:

- `/headless/Downloads`
- `/headless/.mozilla`

A volume mounted to the latter mounting point can be optionally pre-loaded with a pre-configured Firefox profile.

## How to create containers

The base image can be used for creating headless [Ubuntu][docker-ubuntu] containers with [Xfce][xfce] desktops, that are accessible over **VNC** or [noVNC][novnc]. Be aware that such containers run under the privileged **root** user by default.

The following container will not use any external volumes and it will listen on the host's **TCP** ports **25901** (VNC) and **26901** (noVNC):

```docker
docker run -d -p 25901:5901 -p 26901:6901 accetto/ubuntu-vnc-xfce
```

Containers created from the image with [Firefox][firefox] run under the non-root user **headless:headless** by default.

The following container wil create or re-use the local named volume **my\_Documents** mounted as `/headless/Documents` and the local named volume **my\_Downloads** mounted as `/headless/Downloads`. Its Firefox profile will be created or re-used on the local named volume **my_Profile** mounted as `/headless/.mozilla`. The container will be accessible through the same **TCP** ports as the one above:

```docker
docker run -d -p 25901:5901 -p 26901:6901 -v my_Documents:/headless/Documents -v my_Downloads:/headless/Downloads -v my_Profile:/headless/.mozilla accetto/ubuntu-vnc-xfce-firefox
```

The following container will use the shared folder **/share/homes/joe/download** mounted as `/headless/Downloads` and it will be accessible through the same **TCP** ports:

```docker
docker run -d -p 25901:5901 -p 26901:6901 -v /share/homes/joe/download:/headless/Downloads accetto/ubuntu-vnc-xfce-firefox
```

Be aware that the folder **/share/homes/joe/download** will be automatically created if it hasn't existed yet and that it will not be removed automatically after destroying the container. It will be also necessary to adjust its access permissions, because the folder will belong to the host's account creating the container.

More usage examples can be found in the project's [Wiki][wiki], especially on the [HOWTO][wiki-howto] page.

## How to use headless containers

There are currently three ways, how to use the created headless containers.

Note that the default **VNC user** password for all three cases is **headless**.

### Over VNC

To be able to use the containers over **VNC**, a **VNC Viewer** is needed (e.g. [TigerVNC][tigervnc] or [TightVNC][tightvnc]).

The VNC Viewer should connect to the host running the container, pointing to the host's TCP port mapped to the container's TCP port **5901**. 

For example, if the container have been created on the host called `mynas` using the parameters described above, the VNC Viewer should connect to `mynas:25901`.

### Over noVNC

To be able to use the containers over [noVNC][novnc], an HTML5 capable web browser is needed. It actually means, that any current web browser can be used.

The browser should navigate to the host running the container, pointing to the host's TCP port mapped to the container's TCP port **6901**.

However, since the version **1.2.0** the containers actually offer two [noVNC][novnc] clients. Additionally to the previously available **light noVNC client** there is also the **full noVNC client** with more features. The connection URL differs slightly in both cases.

If the container have been created on the host called `mynas` using the parameters described above, then the web browser should navigate to the following URLs:

- full client: `http://mynas:26901/vnc.html`
- light client: `http://mynas:26901/vnc_lite.html`

It's also possible to provide the password through the URL like this:

- full client: `http://mynas:26901/vnc.html?password=headless`
- light client: `http://mynas:26901/vnc_lite.html?password=headless`

The most convenient way is to bookmark the used URLs.

## Issues

If you have found a problem or just have a question, please check the [Issues][accetto-github-issues] and the [Troubleshooting][wiki-troubleshooting], [FAQ][wiki-faq] and [HOWTO][wiki-howto] pages in [Wiki][wiki] first. Please do not overlook also the closed issues.

If you do not find a solution, you can file a new issue. The better you describe the problem, the bigger the chance it'll be solved soon.

## Credits

This project has been originally inspired by the image [consol/ubuntu-xfce-vnc][consol-docker-repo] and derived from the repository [ConSol/docker-headless-vnc-container][consol-github-repo].

Credit also goes to all the countless people and companies who contribute to open source community and make so many dreamy things real.

<!-- spell-checker: disable -->

[accetto-docker]: https://hub.docker.com/u/accetto/
[acceto-docker-vnc-base]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce/
[accetto-docker-vnc-firefox]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-firefox/
[acceto-dockerfile-vnc-base-latest]: https://github.com/accetto/ubuntu-vnc-xfce/blob/master/Dockerfile-base
[acceto-dockerfile-vnc-base-rolling]: https://github.com/accetto/ubuntu-vnc-xfce/blob/master/Dockerfile-base_rolling
[accetto-dockerfile-vnc-firefox-latest]: https://github.com/accetto/ubuntu-vnc-xfce/blob/master/Dockerfile-firefox
[accetto-dockerfile-vnc-firefox-rolling]: https://github.com/accetto/ubuntu-vnc-xfce/blob/master/Dockerfile-firefox_rolling
[accetto-dockerfile-vnc-firefox-profile]: https://github.com/accetto/ubuntu-vnc-xfce/blob/master/Dockerfile-firefox-profile

[accetto-github]: https://github.com/accetto/ubuntu-vnc-xfce
[accetto-github-changelog]: https://github.com/accetto/ubuntu-vnc-xfce/blob/master/changelog.md
[accetto-github-extras]: https://github.com/accetto/ubuntu-vnc-xfce/tree/master/extras
[accetto-github-issues]: https://github.com/accetto/ubuntu-vnc-xfce/issues

[wiki]: https://github.com/accetto/ubuntu-vnc-xfce/wiki
[wiki-howto]: https://github.com/accetto/ubuntu-vnc-xfce/wiki/How-to
[wiki-troubleshooting]: https://github.com/accetto/ubuntu-vnc-xfce/wiki/Troubleshooting
[wiki-faq]: https://github.com/accetto/ubuntu-vnc-xfce/wiki/Frequently-asked-questions

[docker-ubuntu]: https://hub.docker.com/_/ubuntu/

[xfce]: http://www.xfce.org
[tigervnc]: http://tigervnc.org
[novnc]: https://github.com/kanaka/noVNC
[leafpad]: https://en.wikipedia.org/wiki/Leafpad
[tightvnc]: http://www.tightvnc.com
[firefox]: https://www.mozilla.org
[vim]: https://www.vim.org/

[consol-docker-repo]: https://hub.docker.com/r/consol/ubuntu-xfce-vnc/
[consol-github-repo]: https://github.com/ConSol/docker-headless-vnc-container
[consol-docker]: https://hub.docker.com/u/consol/

[qnap]: https://www.qnap.com/en/
[container-station]: https://www.qnap.com/solution/container_station/en/
