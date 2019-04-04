#!/bin/bash

FEDORA_RELEASE=29
TOOLCHAIN_ARCHIVE=sonnet-toolchain-20190404.tar.gz
TOOLCHAIN_URL=http://assets.sakura-it.pl/binaries/${TOOLCHAIN_ARCHIVE}

container=$(buildah from fedora:${FEDORA_RELEASE})

buildah run $container -- dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-${FEDORA_RELEASE}.noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${FEDORA_RELEASE}.noarch.rpm

buildah run $container -- dnf -y install make lha

buildah add $container ${TOOLCHAIN_URL}

buildah run $container -- tar zxf /opt/${TOOLCHAIN_ARCHIVE} -C /opt/
buildah run $container -- rm /opt/${TOOLCHAIN_ARCHIVE}

echo $container 

