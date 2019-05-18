#!/bin/bash

FEDORA_RELEASE=30
FEDORA_IMAGE=registry.fedoraproject.org/fedora-minimal:${FEDORA_RELEASE}

TOOLCHAIN_ARCHIVE=sonnet-toolchain-20190404.tar.gz
TOOLCHAIN_URL=http://assets.sakura-it.pl/binaries/${TOOLCHAIN_ARCHIVE}

container=$(buildah from ${FEDORA_IMAGE})
DNF_TOOL=microdnf

RPMFUSION_RPMS="https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-${FEDORA_RELEASE}.noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${FEDORA_RELEASE}.noarch.rpm"

buildah copy $container ${RPMFUSION_RPMS} /root/
buildah run $container -- rpm -ivh /root/*rpm

buildah run $container -- $DNF_TOOL -y install make lha tar
buildah run $container -- $DNF_TOOL clean all

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

