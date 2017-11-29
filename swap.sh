#!/bin/bash
set -e

if [ $# -eq 0 ]
  then
    echo "Usage: $(basename $0) SIZE"
    exit 0
fi

SIZE=$1

# Create Swap
echo "[Creating swap of $SIZE]"
fallocate -l $SIZE /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile   none    swap    sw    0   0" >> /etc/fstab

# Written by Vikesh Tiwari [https://www.github.com/vicky002]
