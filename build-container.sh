#!/bin/bash

FEDORA_RELEASE=29
TOOLCHAIN_ARCHIVE=sonnet-toolchain-20190404.tar.gz
TOOLCHAIN_URL=http://assets.sakura-it.pl/binaries/${TOOLCHAIN_ARCHIVE}

container=$(buildah from fedora:${FEDORA_RELEASE})

buildah run $container -- dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-${FEDORA_RELEASE}.noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${FEDORA_RELEASE}.noarch.rpm

buildah run $container -- dnf -y install make lha
buildah run $container -- dnf clean all

buildah add $container ${TOOLCHAIN_URL} /opt/

buildah run $container -- tar zxf /opt/${TOOLCHAIN_ARCHIVE} -C /opt/
buildah run $container -- rm /opt/${TOOLCHAIN_ARCHIVE}
buildah run $container -- ln -s /opt/sonnet-toolchain /opt/amiga-cross

buildah run $container -- mkdir /build
buildah config  --volume /build $container

buildah add $container entrypoint.sh /
buildah config --entrypoint /entrypoint.sh $container

buildah config --label maintainer="Radosław Kujawa <radoslaw.kujawa@gmail.com>" $container

buildah commit $container sonnetamiga-builder:latest

