#!/bin/bash

# build.sh Version 1.3
# Copyright (c) 2023, neuralpain
# Build script for qbactivator.cmd

version=$(<VERSION)
buildfile=./build/qbactivator.cmd
zipfile=qbactivator-$version.zip
main=./src/main.cmd
helpfile=./src/qbreadme.txt
encoded=./src/qbclient.bin
decoder=./src/decode.ps1
pwshscript=./src/ExecutionModule.ps1

build() {
  # script header
  echo "<# :# DO NOT REMOVE THIS LINE" > $buildfile
  echo >> $buildfile
  # script info
  echo ":: qbactivator.cmd, Version $version" >> $buildfile
  echo ":: Copyright (c) 2023, neuralpain" >> $buildfile
  echo ":: Activation script body written in batch" >> $buildfile
  echo >> $buildfile
  # add main body
  echo "@echo off" >> $buildfile
  echo '@set "uivr='$version'"' >> $buildfile
  cat $main >> $buildfile
  echo >> $buildfile
  # add instructions
  echo ":: export instructions to text file" >> $buildfile
  echo ":qbreadme:">> $buildfile
  cat $helpfile >> $buildfile
  echo ":qbreadme:" >> $buildfile
  echo >> $buildfile
  echo ":qbclient:" >> $buildfile
  cat $decoder >> $buildfile
  echo >> $buildfile
  cat $encoded >> $buildfile
  echo >> $buildfile
  # add powershell functions
  echo "# ---------- powershell script ---------- #>" >> $buildfile
  echo >> $buildfile
  cat $pwshscript >> $buildfile
  echo "Build complete."
}

compress() {
  cp ./LICENSE dist
  cd dist && zip -q $zipfile * &>/dev/null || ( echo -e "\033[0;31mE:\033[0m Failed to create archive." && return )
  rm ./LICENSE
  if [ -f $zipfile ]; then echo -e "\033[0;37mArchived to \"dist/$zipfile\"\033[0m"; fi
}

printusage() {
  echo "Usage: build [OPTION]"
  echo -e "Build script for qbactivator.cmd\n"
  echo "  -i, --release      Build for stable release"
  echo "  -t, --test         Build unit tests"
  echo "  -C, --clear-all    Delete \"build\" and \"dist\" folder"
  echo "  -c, --clear        Clear all unit test builds"
  echo "  -h, --help         Display this help message"
}

case "$1" in
  -h|--help) printusage;;
  -c|--clear) rm ./build/* &>/dev/null;;
  -C|--clear-all) rm -r ./build ./dist &>/dev/null;;
  -i|--release) buildfile=./dist/qbactivator.cmd
    [ ! -d "./dist" ] && mkdir dist || rm ./dist/*
    cp ./src/qbpatch.dat ./dist
    build && compress;;
  -t|--test) build="$(date "+$version.%y%m%d%H%M%S")"
    version="$version [Build $build]"
    buildfile=./build/qbactivator-$build.cmd
    [ ! -d "./build" ] && mkdir build
    build;;
  *) printusage && exit;;
esac