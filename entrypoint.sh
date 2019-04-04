#!/bin/bash
cd /build
VBCC=/opt/sonnet-toolchain
INCLUDE_I=${VBCC}/NDK_3.9/Include/include_i
export VBCC PATH INCLUDE_I
PATH=$PATH:${VBCC}/bin
make HOST=unix
make HOST=unix distribution

