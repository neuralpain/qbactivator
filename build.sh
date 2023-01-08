#!/bin/bash

version=$(<VERSION)
buildfile=./build/qbactivator.cmd

case "$1" in
  -i) buildfile=./dist/qbactivator.cmd
    [ ! -d "./dist" ] && mkdir dist || rm -r ./dist/*
    cp ./src/qbpatch.dat ./dist;;
  *) build="$(date "+$version.%y%m%d.%H%M%S")"
    version="$version-beta [Build $build]"
    buildfile=./build/qbactivator-$build.cmd
    [ ! -d "./build" ] && mkdir build;;
esac

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
echo ":: export instructions to text file">> $buildfile
echo ":qbreadme:">> $buildfile

# add instructions
cat ./src/qbreadme.min.md >> $buildfile
echo ":qbreadme:" >> $buildfile
echo >> $buildfile

# add powershell functions
echo "# ---------- powershell script ---------- #>" >> $buildfile
echo >> $buildfile
cat ./src/Invoke-LicenseInstallation.ps1 >> $buildfile

printf "Created \"$buildfile\"\n\n"
