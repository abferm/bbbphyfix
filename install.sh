#!/bin/bash

#first install the bbbrtc command that we will need
DIR=$(mktemp -d -t bbbrtc.XXXXXX) || exit 1
echo "tmpdir = $DIR"
pushd "$DIR"
git clone https://github.com/bigjosh/bbbrtc
cd bbbrtc
make
popd
rm -r $DIR

#next install the bbbphyreg command that we will need
DIR=$(mktemp -d -t bbbrtc.XXXXXX) || exit 1
echo "tmpdir = $DIR"
pushd "$DIR"
git clone https://github.com/bigjosh/phyreg
cd phyreg
make
popd
rm -r $DIR

#remove an existing init.rc if present
update-rc.d -f chkphy remove
#install our script to run every boot
cp chkphy /etc/init.d
chmod +x /etc/init.d/chkphy
sudo update-rc.d chkphy defaults
