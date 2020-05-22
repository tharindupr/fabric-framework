#!/bin/bash

if [ -z $SUDO_USER ]
then
    echo "===== Script need to be executed with sudo ===="
    exit 0
fi

source ./to_absolute_path.sh

# Get the version 1.13 from google
wget https://dl.google.com/go/go1.13.3.linux-amd64.tar.gz
act='ttyout="*"'
tar -xf go1.13.3.linux-amd64.tar.gz --checkpoint --checkpoint-action=$act -C /usr/local 
rm go1.13.3.linux-amd64.tar.gz

# If GOROOT already set then DO Not set it again

echo "export GOROOT=/usr/local/go" >> ~/.profile
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.profile

GOPATH=$PWD/../../gocc
to-absolute-path $GOPATH
GOPATH=$ABS_PATH

echo "export GOPATH=$GOPATH" >> ~/.profile
echo "======== Updated .profile with GOROOT/GOPATH/PATH===="

echo "export GOROOT=/usr/local/go" >> ~/.bashrc
echo "export GOPATH=$GOPATH" >> ~/.bashrc
echo "======== Updated .profile with GOROOT/GOPATH/PATH===="

echo "export GOCACHE=~/.go-cache" >> ~/.bashrc
mkdir -p $GOCACHE
chown -R $USER $GOCACHE


i

