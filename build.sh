#!/bin/bash

# Name: build.sh
# Author: neuralpain
# Version: 1.2
# Description: build script for qbactivator.cmd

version=$(<VERSION)
buildfile=./build/qbactivator.cmd
zipfile=qbactivator-$version.zip

build() {
  # script header
  echo "<# :# DO NOT REMOVE THIS LINE" > $buildfile
  echo >> $buildfile
  # script info
  echo ":: Name: qbactivator.cmd" >> $buildfile
  echo ":: Author: neuralpain" >> $buildfile
  echo ":: Version: $version" >> $buildfile
  echo ":: Description: Activation script body written in batch" >> $buildfile
  echo >> $buildfile
  # add main body
  echo '@set "uivr='$version'"' >> $buildfile
  cat ./src/main.cmd >> $buildfile
  echo >> $buildfile
  # add instructions
  echo ":: export instructions to text file">> $buildfile
  echo ":qbreadme:">> $buildfile
  cat ./src/qbreadme.min.md >> $buildfile
  echo ":qbreadme:" >> $buildfile
  echo >> $buildfile
  # add powershell functions
  echo "# ---------- powershell script ---------- #>" >> $buildfile
  echo >> $buildfile
  cat ./src/Invoke-LicenseInstallation.ps1 >> $buildfile
  printf "\033[1;32mBuild complete.\n\033[0m"
}

compress() {
  cd dist && zip -q $zipfile * &>/dev/null || ( printf "\033[0;31mFailed to archive files.\033[0m" && return )
  if [ -f $zipfile ]; then printf "\033[0;37mArchived to \"dist/$zipfile\"\n\033[0m"; fi
}

case "$1" in
  -i) buildfile=./dist/qbactivator.cmd
    [ ! -d "./dist" ] && mkdir dist || rm -r ./dist/*
    cp ./src/qbpatch.dat ./dist
    build && compress;;
  *) build="$(date "+$version.%y%m%d.%H%M%S")"
    version="$version-beta [Build $build]"
    buildfile=./build/qbactivator-$build.cmd
    [ ! -d "./build" ] && mkdir build
    build;;
esac