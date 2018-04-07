# Ubuntu/Xfce images with VNC/noVNC and Firefox

This repository contains resources for building Docker images based on [Ubuntu](https://hub.docker.com/_/ubuntu/), with **Xfce** desktops and headless **VNC**/**noVNC** environments. Images with **Firefox** browser are also included.

These images have been also tested with [Container Station](https://www.qnap.com/solution/container_station/en/) on NAS devices from [QNAP](https://www.qnap.com/en/).

The project was originally inspired by [consol/ubuntu-xfce-vnc](https://hub.docker.com/r/consol/ubuntu-xfce-vnc/) image and derived from [ConSol/docker-headless-vnc-container](https://github.com/ConSol/docker-headless-vnc-container) project.

Comparing to [ConSol](https://hub.docker.com/u/consol/), these images are significantly smaller because of excluded features. They are best suited for fast creation of small light-weight containers, used for testing or as throw-away web browsers. Such containers are not intended for multimedia, as any other container used remotely over VNC.

The images include the following common components:

- Light-weight [Xfce](http://www.xfce.org) desktop environment
- High-performance VNC server [TigerVNC](http://tigervnc.org) (default VNC port **5901**)
- HTML5 VNC client [noVNC](https://github.com/kanaka/noVNC) (default http port **6901**)
- Light-weight graphical editor [leafpad](http://tarot.freeshell.org/leafpad/)

Images with Firefox have the following additional components installed:

- [Firefox Quantum](https://www.mozilla.org) web browser
- optionally also a pre-configured Firefox profile (see below)

## Image set

- [`accetto/ubuntu-vnc-xfce`](https://hub.docker.com/r/accetto/ubuntu-vnc-xfce/)

    This is the base **Ubuntu** image with **Xfce** desktop and **VNC/nonVNC** headless environments. Containers created from this image are accessible over VNC using a **VNC Viewer** (e.g. [TigerVNC](http://tigervnc.org/) or [TightVNC](http://www.tightvnc.com)) or directly from a web browser over **noVNC**. Any web browser with HTML5 support will do. It should be noticed, that these containers do not include any web browser and that they run under the privileged **root** user by default. However, the graphical editor **leafpad** is already included.

- [`accetto/ubuntu-vnc-xfce-firefox`](https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-firefox/)

    This image is based on the one above and it adds **Firefox** web browser. It runs under a non-root user **headless:headless** by default.

- `accetto/ubuntu-vnc-xfce-firefox-profile`

    This optional image is based on the one above and it adds a **pre-configured Firefox profile**. It's not actually contained in the Docker repository as a pre-built image, but the GitHub repository includes the ready-to-use [Dockerfile-firefox-profile](https://github.com/accetto/ubuntu-vnc-xfce/blob/master/Dockerfile-firefox-profile) to create your very own version of the image. This [wiki page](https://github.com/accetto/ubuntu-vnc-xfce/wiki/How-to) explains how to do it.
    
## Supported tags and respective `Dockerfile` links

The following images are regularly built:

- [`accetto/ubuntu-vnc-xfce`](https://hub.docker.com/r/accetto/ubuntu-vnc-xfce/)

    - `latest` based on `ubuntu:latest` ([`Dockerfile`](https://github.com/accetto/ubuntu-vnc-xfce/blob/master/Dockerfile-base))
    - `rolling` based on `ubuntu:rolling` ([`Dockerfile`](https://github.com/accetto/ubuntu-vnc-xfce/blob/master/Dockerfile-base_rolling))

    [![version badge](https://images.microbadger.com/badges/version/accetto/ubuntu-vnc-xfce.svg)](https://microbadger.com/images/accetto/ubuntu-vnc-xfce "Get your own version badge on microbadger.com") [![size badge](https://images.microbadger.com/badges/image/accetto/ubuntu-vnc-xfce.svg)](https://microbadger.com/images/accetto/ubuntu-vnc-xfce "Get your own image badge on microbadger.com") [![version badge](https://images.microbadger.com/badges/version/accetto/ubuntu-vnc-xfce:rolling.svg)](https://microbadger.com/images/accetto/ubuntu-vnc-xfce:rolling "Get your own version badge on microbadger.com") [![size badge](https://images.microbadger.com/badges/image/accetto/ubuntu-vnc-xfce:rolling.svg)](https://microbadger.com/images/accetto/ubuntu-vnc-xfce:rolling "Get your own image badge on microbadger.com")

- [`accetto/ubuntu-vnc-xfce-firefox`](https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-firefox/)

    - `latest` based on `accetto/ubuntu-vnc-xfce:latest` ([`Dockerfile`](https://github.com/accetto/ubuntu-vnc-xfce/blob/master/Dockerfile-firefox))
    - `rolling` based on `accetto/ubuntu-vnc-xfce:rolling` ([`Dockerfile`](https://github.com/accetto/ubuntu-vnc-xfce/blob/master/Dockerfile-firefox_rolling))

    [![version badge](https://images.microbadger.com/badges/version/accetto/ubuntu-vnc-xfce-firefox.svg)](https://microbadger.com/images/accetto/ubuntu-vnc-xfce-firefox "Get your own version badge on microbadger.com") [![size badge](https://images.microbadger.com/badges/image/accetto/ubuntu-vnc-xfce-firefox.svg)](https://microbadger.com/images/accetto/ubuntu-vnc-xfce-firefox "Get your own image badge on microbadger.com") [![version badge](https://images.microbadger.com/badges/version/accetto/ubuntu-vnc-xfce-firefox:rolling.svg)](https://microbadger.com/images/accetto/ubuntu-vnc-xfce-firefox:rolling "Get your own version badge on microbadger.com") [![size badge](https://images.microbadger.com/badges/image/accetto/ubuntu-vnc-xfce-firefox:rolling.svg)](https://microbadger.com/images/accetto/ubuntu-vnc-xfce-firefox:rolling "Get your own image badge on microbadger.com")

### Ports

All images expose the following **TCP** ports:

- **5901** is used for access over **VNC**
- **6901** is used for access over **noVNC**

The default VNC password is **headless**.

### Volumes

The images do not create or use any external volumes by default. However, the following mounting point is available in all images:

- `/headless/Documents`

The image with Firefox adds two more mounting points:

- `/headless/Downloads`
- `/headless/.mozilla`

A volume mounted to the latter mounting point can be optionally pre-loaded with a pre-configured Firefox profile.

## Usage

The base image can be used for creating headless **Ubuntu** containers with **Xfce** desktops, that are accessible over **VNC** or **noVNC**. Be aware that such containers run under the privileged **root** user by default.

The following container will not use any external volumes and it will listen on the **TCP** ports **25901** (VNC) and **26901** (noVNC):

```
docker run -d -p 25901:5901 -p 26901:6901 accetto/ubuntu-vnc-xfce
```

Containers created from the image with Firefox run under the non-root user **headless:headless** by default.

The following container wil create or re-use the local named volume **my\_Documents** mounted as `/headless/Documents` and the local named volume **my\_Downloads** mounted as `/headless/Downloads`. Its Firefox profile will be created or re-used on the local named volume **my_Profile** mounted as `/headless/.mozilla`. The container will be accessible through the same **TCP** ports as the one above:

```
docker run -d -p 25901:5901 -p 26901:6901 -v my_Documents:/headless/Documents -v my_Downloads:/headless/Downloads -v my_Profile:/headless/.mozilla accetto/ubuntu-vnc-xfce-firefox
```

The following container will use the shared folder **/share/homes/joe/download** mounted as `/headless/Downloads` and it will be accessible through the same **tTCPcp** ports:

```    
docker run -d -p 25901:5901 -p 26901:6901 -v /share/homes/joe/download:/headless/Downloads accetto/ubuntu-vnc-xfce-firefox
```

Be aware that the folder **/share/homes/joe/download** will be created if it hasn't existed yet and that it will not be removed automatically after destroying the container. It will be also necessary to adjust the access permissions, because the folder will belong to the local account creating the container.

More usage examples can be found in [wiki](https://github.com/accetto/ubuntu-vnc-xfce/wiki), especially on the [HOWTO](https://github.com/accetto/ubuntu-vnc-xfce/wiki/How-to) page.

## Issues

If you have a problem or a question, please check the repository [Issues](https://github.com/accetto/ubuntu-vnc-xfce/issues) and the [Troubleshooting](troubleshooting), [FAQ](frequently-asked-questions) and [HOWTO](how-to) pages first. Please do not overlook the closed issues.

If you do not find a solution, you can file a new issue. The better you describe the problem, the bigger the chance it'll be solved soon.
