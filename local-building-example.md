# Local building example

- [Local building example](#local-building-example)
  - [Preparation](#preparation)
  - [Building pipeline](#building-pipeline)
    - [Step 1: `build`](#step-1-build)
    - [Step 2: `test`](#step-2-test)
    - [Step 3: `push`](#step-3-push)
    - [All steps at once](#all-steps-at-once)

Docker Hub has removed auto-building from free plans since 2021-07-26.

This page describes how to build the image locally and optionally push it to Docker Hub.

If you just want to build the image locally without publishing it on Docker Hub, then you can use the `one-liners` shown at the top of the Dockerfile.

There is a helper utility `builder.sh`, which supports executing the whole building pipeline locally, including pushing the image to Docker Hub.

## Preparation

Open a terminal windows and change the current directory to the root of the project (where the license file is).

There is an example secrets file in the `utils` subdirectory of the project. Copy and modify it and then source it in the terminal:

```bash
### make a copy and then modify it
cp utils/example-secrets.rc secrets.rc

### source the secrets
source ./secrets.rc
```

## Building pipeline

The full building pipeline consists of the following four hook scripts and one utility script:

- `build`
- `test`
- `push`
- `util-refresh-readme.sh`

The order of executing the scripts is important.

The commands in the following example would build and publish the image `accetto/ubuntu-vnc-xfce:latest`.

The helper utility `builder.sh` will be used. Alternatively you can also use the hook scripts directly.

### Step 1: `build`

```bash
./builder.sh latest build
```

This command builds a new local image.

### Step 2: `test`

```bash
./builder.sh latest test
```

This command checks if the version sticker has changed. This step is optional and you can skip it if you are not interested in the version sticker value.

Otherwise, if the version sticker has changed since the last project update, then adjust the version sticker variables in the `env` hook script and repeat the steps 1 and 2.

Also update the `README` file using the helper utility `util-refresh-readme.sh`.

### Step 3: `push`

```bash
./builder.sh latest push
```

This command will push the new image to Docker Hub.

Note that currently you have to update the `README` file on Docker Hub yourself. You can do it in edit mode by simple copy-and-paste from the local file, which you've already updated by the helper utility described above.

### All steps at once

Alternatively you can execute the whole building pipeline using the `all` command:

```bash
./builder.sh latest all
```

Note that this command doesn't update the `README` file. You still have to do it yourself using the helper utility described above.
