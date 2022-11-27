# Local building example

Version G2v2

***

- [Local building example](#local-building-example)
  - [Introduction](#introduction)
  - [Preparation](#preparation)
    - [Version sticker values](#version-sticker-values)
  - [Building pipeline](#building-pipeline)
    - [Step 1: `build`](#step-1-build)
    - [Step 2: `test`](#step-2-test)
    - [Step 3: `push`](#step-3-push)
    - [All steps at once](#all-steps-at-once)
  - [Utility `util-refresh-readme.sh`](#utility-util-refresh-readmesh)

## Introduction

The **Docker Hub** has removed the **auto-building** feature from the free plans since 2021-07-26.

This page describes how to build the images locally and optionally push them to the **Docker Hub**.

If you just want to build the images locally without publishing them to the **Docker Hub**, then you can use the `one-liners` shown at the top of each `Dockerfile`.

There is a helper utility `builder.sh`, which supports executing the **building pipeline** locally, including the pushing to the **Docker Hub**.

Another helper utility `util-refresh-readme.sh` will create updated clones `scrap_readme.md` of all `README.md` files. You can copy-and-past the content of these temporary files to the **Docker Hub**.

## Preparation

Before executing the building pipeline or using the helper utilities, it's necessary to initialize the required environment variables.

Note that the helper utility `util-refresh-readme.sh` expects, that it's run from inside the `utils/` folder.

Sourcing a file exporting the variables is the fastest way to do it. 

You can use the provided template file `example-secrets.rc`, which is stored in the `utils/` folder.

Open a terminal window and change the current directory to the root of the project (where the license file is).

Copy the template file and modify it appropriately. Then source the modified file `secrets.rc` in the terminal:

```bash
### make a copy and then modify it
cp utils/example-secrets.rc secrets.rc

### source the secrets
source ./secrets.rc

### or from inside the 'utils/' folder
source ../secrets.rc
```

### Version sticker values

Since the **second version** of the project (G2v2), the values of the **version sticker** variables (`VERSION_STICKER_*`) in the `env` hook scripts are not hardcoded, but initialized from the following environment variables:

- `G1_STICKER_BASE`
- `G1_STICKER_CHROMIUM`
- `G1_STICKER_FIREFOX`

Note that these variables are used also by the helper utility `util-refresh-readme.sh`.

The code in the `env` scripts looks similar to this:

```shell
VERSION_STICKER_LATEST="${G1_STICKER_BASE:-ubuntu18.04.6}-${G1_STICKER_FIREFOX:-firefox}"
```

The most reliable way to get the most current values of the version stickers is to build the images locally in a test run. For example:

```shell
### PWD = project root
./builder.sh firefox latest build
./builder.sh firefox latest test
```

Then extract the value from the line similar to this:

```text
+ actual=ubuntu18.04.6-firefox107.0
```

Note that the **version sticker** values are optional and they are not a technical requirement for building the images. You can ignore them completely if you don't need them.

## Building pipeline

The full building pipeline consists of the following four hook scripts and one utility script:

- `build`
- `test`
- `push`
- `util-refresh-readme.sh`

The order of executing the scripts is important.

The commands in the following example would build and publish the image `accetto/ubuntu-vnc-xfce:latest`.

The easiest way is to use the helper utility `builder.sh`. However, you can also execute the hook scripts directly.

Note that the `base` image is used by all other images as a base, so it's advisable to rebuild it first in all cases.

### Step 1: `build`

```bash
./builder.sh base latest build
```

This command builds a new local image.

### Step 2: `test`

```bash
./builder.sh base latest test
```

This command checks if the version sticker has changed. This step is optional and you can skip it if you are not interested in the version sticker value.

Otherwise, if the version sticker has changed since the last project update, then adjust the version sticker variables in the `env` hook script and repeat the steps 1 and 2.

Also update the `README` file using the helper utility `util-refresh-readme.sh`.

### Step 3: `push`

```bash
./builder.sh base latest push
```

This command will push the new image to the **Docker Hub**.

Note that currently you have to update the `README` file on Docker Hub yourself. You can do it in edit mode by simple copy-and-paste from the local file, which you've already updated by the helper utility described above.

### All steps at once

Alternatively you can execute the whole building pipeline using the `all` command:

```bash
./builder.sh base latest all
```

Note that this command doesn't update the `README` file. You still have to do it yourself using the helper utility described above.

## Utility `util-refresh-readme.sh`

Helper utility `util-refresh-readme.sh` is stored in the folder `utils/` and it also expects to be executed from it.

The utility creates updated clones `scrap_readme.md` of all `README.md` files.

The content of these temporary files is intended to be copy-and-pasted manually to the **Docker Hub**.

The utility actually updates only the **version sticker** badge hyperlinks.

To do it correctly, the related environment variables must be set correctly. For example:

```shell
### current version sticker values
export G1_STICKER_BASE="ubuntu18.04.6"
export G1_STICKER_CHROMIUM="chromium107.0.5304.87"
export G1_STICKER_FIREFOX="firefox107.0"
```

A typical usage looks like this:

```shell
### if starting from project's root directory 
### and if the 'secrets.rc' file is also there
source ./secrets.rc
cd utils/
./util-refresh-readme.sh
```
