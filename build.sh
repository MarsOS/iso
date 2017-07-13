#!/bin/bash

function clean() {
  rm -r temp/
}

function download() {
  mkdir temp
  URL_KERNEL=https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.12.1.tar.xz
  URL_COREUTILS=http://ftp.gnu.org/gnu/coreutils/coreutils-8.27.tar.xz
  URL_LIBC=http://mirror.netcologne.de/gnu/libc/glibc-2.25.tar.xz

  curl -o temp/kernel.tar.xz $URL_KERNEL
  curl -o temp/coreutils.tar.xz $URL_COREUTILS
  curl -o temp/libc.tar.xz $URL_LIBC
}

function prepare() {
  cd temp/

  tar -xf kernel.tar.xz
  mv linux-*/ linux/
  tar -xf coreutils.tar.xz
  mv coreutils-*/ coreutils/
  tar -xf libc.tar.xz
  mv glibc-*/ glibc/

  cd ../
}

function compileKernel() {
  cd temp/linux/
  make defconfig
  make -j4
  cd ../..
}

function compileCoreutils() {
  cd temp/coreutils/
  CFLAGS="-static" ./configure && make
  cd ../..
}

function compileLibC() {
  cd temp/glibc/
  mkdir build
  cd build/
  ../configure && make
  cd ../../..
}

#clean
#download
#prepare
#compileKernel
#compileCoreutils
#compileLibC
