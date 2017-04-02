# Docker Ubuntu/Xfce4 images with VNC/noVNC and Firefox

The repository contains a collection of Docker images, based on **Ubuntu** with **Xfce** desktop and headless **VNC**/**noVNC** environments.

The project is inspired by `consol/ubuntu-xfce-vnc` image on `hub.docker.com` and originally derived from `ConSol/docker-headless-vnc-container` project on `github.com`.

All images are based on the official `ubuntu:16.04` image and have the following common components installed:

* Desktop environment [**Xfce4**](http://www.xfce.org)
* VNC-Server (default VNC port `5901`)
* [**noVNC**](https://github.com/kanaka/noVNC) - HTML5 VNC client (default http port `6901`)

Images with Firefox have the following additional components installed:

* Firefox browser (currently v52.0.2)
* optionally pre-configured Firefox profile 

### Image set

* `accetto/ubuntu-vnc-xfce`
    * is the base Ubuntu image with Xfce desktop and VNC/nonVNC headless environment
* `accetto/ubuntu-vnc-xfce-firefox`
    * adds Firefox browser
* `accetto/ubuntu-vnc-xfce-firefox-profile` (optional)
    * adds a pre-configured Firefox profile

### Ports

All images expose the following **tcp** ports:

* `5901` is used for access via a **VNC** viewer (e.g. [**TightVNC Viewer**](http://www.tightvnc.com))
* `6901` is used for access via an **HTML5**-enabled web browser (**noVNC**)

The default VNC password is `docker`.

### Volumes

The images do not cause any local volumes to be created by default. However, the following mounting point is available:

* `/headless/Documents`

The images with Firefox add two more mounting points:

* `/headless/Downloads`
* `/headless/.mozilla`

A volume mounted to the latter mounting point can be optionally pre-loaded with a pre-configured Firefox profile.

## Usage

The base image can be used for creating headless **Ubuntu** containers with **Xfce4** desktop, accessible via **VNC** or **noVNC** (HTML5).

The following container will not create any local volumes and will listen on **tcp** ports `25901` (VNC) and `26901` (nonVNC):

    docker run -d -p 25901:5901 -p 26901:6901 accetto/ubuntu-vnc-xfce

The same container with a non-root default user (`uid:gid`):

    docker run -d -p 25901:5901 -p 26901:6901 --user 2017:2000 accetto/ubuntu-vnc-xfce

The same container using a local volume `Documents`:

    docker run -d -p 25901:5901 -p 26901:6901 -v Documents:/headless/Documents accetto/ubuntu-vnc-xfce

Image with Firefox can also mount `Downloads` volume and even expose its Firefox profile:

    docker run -d -p 25901:5901 -p 26901:6901 -v Documents:/headless/Documents -v Downloads:/headless/Downloads -v Profile:/headless/.mozilla accetto/ubuntu-vnc-xfce-firefox

The volume `Profile` can be pre-loaded with a pre-configured Firefox profile data and also shared by several containers.

## Hints

### Overriding the VNC password
Simply provide a value for the environment variable `VNC_PW`. For example in
the docker run command:

    docker run -d -p 25901:5901 -p 26901:6901 -e "VNC_PW=newpassword" accetto/ubuntu-vnc-xfce
    
### Override the VNC resolution
Simply provide a value for the environment variable `VNC_RESOLUTION`. For example in
the docker run command:

    docker run -it -p 25901:5901 -p 26901:6901 -e VNC_RESOLUTION=800x600 accetto/ubuntu-vnc-xfce
