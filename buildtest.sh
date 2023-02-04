#!/bin/bash

source=$(pwd)/dist
source=${source////\\}
source=${source/mnt\\??}

name=qbactivator
file=$name.cmd
outfile=$source\\$name.exe

sedprop=properties.sed
cat build.cfg > $sedprop
echo "TargetName=$outfile" >> $sedprop
echo "FriendlyName=$name" >> $sedprop
echo "AppLaunched=cmd /c $file" >> $sedprop
# program file name
echo "FILE0=\"$file\"" >> $sedprop
# directory of program file
echo "[SourceFiles]" >> $sedprop
echo "SourceFiles0=$source" >> $sedprop
echo "[SourceFiles0]" >> $sedprop
echo "%FILE0%=" >> $sedprop

iexpress.exe /n /q /m $sedprop
# rm $sedprop