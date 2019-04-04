# SonnetAmiga-builder
Linux container with all tools necessary to build SonnetAmiga project.

## Using the container to build SonnetAmiga

The container should run using any OCI-compatible runtime. It was tested with
podman only. Built image is available at quay.io.

```
$ git clone https://github.com/Sakura-IT/SonnetAmiga.git
$ podman pull quay.io/rkujawa/sonnetamiga-builder:latest
$ sudo chcon -Rt container_file_t SonnetAmiga
$ podman run  -v ${PWD}/SonnetAmiga/:/build quay.io/rkujawa/sonnetamiga-builder:latest
```

You can find built `sonnet.lha` in the SonnetAmiga directory.

## Building the container itself

Install `buildah`, run `build-container.sh`. Done.
