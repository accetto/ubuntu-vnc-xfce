# Docker Ubuntu/Xfce4 images with VNC/noVNC and Firefox

The repository contains Docker images based on **Ubuntu**, with **Xfce** desktop and headless **VNC**/**noVNC** environments.

The images are tested also with [**Container Station**](http://qnap-dev.github.io/container-station-api/index.html) on NAS devices from [**QNAP**](https://www.qnap.com/en/index.php).

The project was originally inspired by [`consol/ubuntu-xfce-vnc`](https://hub.docker.com/r/consol/ubuntu-xfce-vnc/) image and derived from [`ConSol/docker-headless-vnc-container`](https://github.com/ConSol/docker-headless-vnc-container) project. 

Comparing to the images from [`ConSol`](https://hub.docker.com/u/consol/), these are significantly smaller because of excluded features. Particularly they are not intended for multimedia. They are best suited for fast creation of small light-weight containers used for testing or as throw-away web browsers. 

All images are based on the official [`ubuntu:16.04`](https://hub.docker.com/_/ubuntu/) (current LTS version) image and have the following common components installed:

* Desktop environment [**Xfce4**](http://www.xfce.org)
* [**TigerVNC**](http://tigervnc.org) VNC-Server (default VNC port **5901**)
* [**noVNC**](https://github.com/kanaka/noVNC) HTML5 VNC client (default http port **6901**)
* [**leafpad**](http://tarot.freeshell.org/leafpad/) graphical editor

Images with Firefox have the following additional components installed:

* [**Firefox**](https://www.mozilla.org) browser (currently **Firefox Quantum v57.0.1 (64-bit)**)
* optionally also a pre-configured Firefox profile (see below)


### Image set

#### [`accetto/ubuntu-vnc-xfce`](https://hub.docker.com/r/accetto/ubuntu-vnc-xfce/)

This is the base **Ubuntu** image with **Xfce** desktop and **VNC/nonVNC** headless environments.
It's already usable via a **VNC Viewer** (e.g. [**TightVNC Viewer**](http://www.tightvnc.com)) or directly from a web browser with HTML5 support via **noVNC**. It runs under the **root** user by default and it includes no web browser. However, the graphical editor **leafpad** is already installed.

#### [`accetto/ubuntu-vnc-xfce-firefox`](https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-firefox/)

This image is based on the one above and it adds **Firefox** web browser. It runs under a non-root user **headless:headless** by default.

#### `accetto/ubuntu-vnc-xfce-firefox-profile`

This optional image is based on the one above and it adds a **pre-configured Firefox profile**. It's not actually contained in the repository, but it can be easily built using the provided [Dockerfile-firefox-profile](https://github.com/accetto/ubuntu-vnc-xfce.git) (see the hints below).


### Ports

All images expose the following **tcp** ports:

* **5901** is used for access via a **VNC** viewer (e.g. [**TightVNC Viewer**](http://www.tightvnc.com))
* **6901** is used for access via a web browser with **HTML5** support (**noVNC**)

The default VNC password is **headless**.


### Volumes

The images do not create or use any external volumes by default. However, the following mounting point is available in all images:

* `/headless/Documents`

The image with Firefox adds two more mounting points:

* `/headless/Downloads`
* `/headless/.mozilla`

A volume mounted to the latter mounting point can be optionally pre-loaded with a pre-configured Firefox profile.


## Usage

The base image can be used for creating headless **Ubuntu** containers with **Xfce** desktop, that are accessible via **VNC** or **noVNC**. Be aware that such containers run under the privileged **root** user by default.

The following container will not use any external volumes and it will listen on the **tcp** ports **25901** (VNC) and **26901** (nonVNC):

    docker run -d -p 25901:5901 -p 26901:6901 accetto/ubuntu-vnc-xfce

Containers created from the image with Firefox run under the non-root user **headles:headless** by default. 

The following container wil create or re-use the local named volume **my\_Documents** mounted as `/headless/Documents` and the local named volume **my\_Downloads** mounted as `/headless/Downloads`. Its Firefox profile will be created or re-used on the local named volume **my_Profile** mounted as `/headless/.mozilla`. The container will be accessible via the same **tcp** ports as the one above:

    docker run -d -p 25901:5901 -p 26901:6901 -v my_Documents:/headless/Documents -v my_Downloads:/headless/Downloads -v my_Profile:/headless/.mozilla accetto/ubuntu-vnc-xfce-firefox

The following container will use the shared folder **/share/homes/joe/download** mounted as `/headless/Downloads` and it will be accessible via the same **tcp** ports:

    docker run -d -p 25901:5901 -p 26901:6901 -v /share/homes/joe/download:/headless/Downloads accetto/ubuntu-vnc-xfce-firefox

Be aware that the folder **/share/homes/joe/download** will be created if it hasn't existed yet and that it will not be removed automatically after destroying the container. It will be also necessary to adjust the access permissions, because the folder will belong to the local account creating the container.

## Hints

### Override  VNC password
Simply provide a value for the environment variable **VNC_PW**:

    docker run -d -p 25901:5901 -p 26901:6901 -e "VNC_PW=newpassword" accetto/ubuntu-vnc-xfce-firefox
    
### Override  VNC resolution
Simply provide a value for the environment variable **VNC\_RESOLUTION**:

    docker run -it -p 25901:5901 -p 26901:6901 -e VNC_RESOLUTION=800x600 accetto/ubuntu-vnc-xfce-firefox

### Override  VNC user
For running a container under some new non-root user **2017:2000** use the `user` parameter of the docker `run` command. There will be some minor limitations because of the simplified configuration of such a user. Note that in this case the user must be specified numerically (as **uid** or **uid:gid**):

    docker run -d -p 25901:5901 -p 26901:6901 --user 2017:2000 accetto/ubuntu-vnc-xfce-firefox

The **root** user can be specified numerically or by its name (as **0**, **0:0**, **root** or **root:root**):

    docker run -d -p 25901:5901 -p 26901:6901 --user root accetto/ubuntu-vnc-xfce-firefox

### Use pre-configured Firefox profile

Containers based on the image with Firefox can make use of the additional mounting point `/headless/.mozilla` and mount some externally accessible folder on it. It can be a local named volume (e.g. **my_Profile**) or a shared folder (e.g. **/share/homes/joe/fxprofile**). 

The following container uses the shared folder **/share/homes/joe/fxprofile** for the Firefox profile data: 

    docker run -d -p 25901:5901 -p 26901:6901 -v /share/homes/joe/fxprofile:/headless/.mozilla accetto/ubuntu-vnc-xfce-firefox

The shared profile folder can be already pre-loaded with some pre-configured Firefox profile data or the default profile created on the first Firefox run can be overwritten afterwards. That way it is possible to quickly create containers with prefabricated web browser configurations.

Make sure that the container has the correct access permissions to the volume folder. Note also that volumes survive container re-creation.

Be aware that the folder **/share/homes/joe/fxprofile** will be created if it hasn't existed yet and that it will belong to the local account creating the container. The access permission must be adjusted, so the user **headless:headless** from **inside the container** will get writing permissions to the folder. Otherwise Firefox fails to start ("Profile Missing" message). Note also that the folder will not be removed automatically after destroying the container.

### Create image with pre-configured Firefox profile

Using a simple `Dockerfile` it is easy to create a new Docker image, which will already include a pre-configured Firefox profile data. 

You can begin by starting Firefox with parameter **P** (notice the capital 'P'). 

For example, on Linux type the following into the terminal window:

    firefox -P 

On Windows type something like the following into the command prompt window:

    "C:\Program Files\Mozilla Firefox\firefox.exe" -P

A Firefox start-up dialog will show up and you can create a fresh new Firefox profile in a folder of your choice. Then you can start Firefox with the new profile and complete its configuration. Optionally do some cleaning afterwards and copy the whole Firefox profile (the folder named **firefox**) into the working folder in which you will build the new docker image. 

For example, the provided [Dockerfile-firefox-profile](https://github.com/accetto/ubuntu-vnc-xfce.git) expects the Firefox profile data in the folder **./src/firefox/profile/** because it includes the following `COPY` command:

    COPY ./src/firefox/profile/ $HOME/.mozilla/

Using the provided [Dockerfile-firefox-profile](https://github.com/accetto/ubuntu-vnc-xfce.git) you can build the new image like this:

    docker build -f Dockerfile-firefox-profile -t my/ubuntu-vnc-xfce-firefox-profile .

The image `my/ubuntu-vnc-xfce-firefox-profile` now includes your very own Firefox configuration and makes it even easier to create light-weight and pre-configured web browser containers.
