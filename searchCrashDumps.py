#!/bin/bash

# Searches across multiple mounted volumes searching for hiberfil.sys, memory.dmp, pagefile.sys and swapfile.sys

fileLocations='log.crashDumps'

for volume in '/mnt/mount0' '/mnt/mount1'
do
        find $volume -type f -iname hiberfil.sys >> $fileLocations
        find $volume -type f -iname memory.dmp >> $fileLocations
        find $volume -type f -iname pagefile.sys >> $fileLocations
        find $volume -type f -iname swapfile.sys >> $fileLocations
done
