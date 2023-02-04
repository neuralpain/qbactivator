#!/bin/bash

# build.sh Version 1.4
# Copyright (c) 2023, neuralpain
# Build script for qbactivator.cmd

version=$(<VERSION)
name=qbactivator.cmd
buildfile=./build/$name
zipfile=qbactivator-$version.zip
zipfile2=qbactivator-$version-standalone.zip
main=./src/main/main.cmd
patchfile=./src/main/qbpatch.dat
helpfile=./src/main/qbreadme.txt
pwshscript=./src/main/ExecutionModule.ps1

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
  # add powershell functions
  echo "# ---------- powershell script ---------- #>" >> $buildfile
  echo >> $buildfile
  cat $pwshscript >> $buildfile
  echo "Build complete."
}

compress() {
  cp ./LICENSE ./VERSION $patchfile dist && cd dist 
  ( zip -q $zipfile * && zip -q $zipfile2 * -x qbpatch.dat *.zip ) || ( echo -e "\033[0;31mE:\033[0m Failed to create archive." && return )
  rm ./LICENSE ./VERSION ./qbpatch.dat
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
    [[ ! -d "./dist" ]] && mkdir dist || rm ./dist/*
    build && compress;;
  -t|--test) build="$(date "+$version.%y%m%d%H%M%S")"
    version="$version [Build $build]"
    buildfile=./build/qbactivator-$build.cmd
    [[ ! -d "./build" ]] && mkdir build
    build && exit;;
  *) printusage && exit;;
esac