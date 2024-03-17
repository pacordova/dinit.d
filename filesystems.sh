#!/bin/sh
export PATH=/usr/bin

set -e

if [ "$1" != "stop" ]; then

  echo "Mounting auxillary filesystems...."
  
  # If you want to enable swap, enable a swapfile or partition below.
  #swapon /swapfile

  mount -avt noproc,nonfs

fi;
