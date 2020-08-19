#!/bin/sh
      
CURL_CMD=$(which curl) # curl tool
YUM_CMD=$(which yum) # yum package manager for RHEL & CentOS
DNF_CMD=$(which dnf) # dnf package manager for new RHEL & CentOS
APT_GET_CMD=$(which apt-get) # apt package manager for Ubuntu & other Debian based distributions
PACMAN_CMD=$(which pacman) # pacman package manager for ArchLinux
APK_CMD=$(which apk) # apk package manager for Alpine
GIT_CMD=$(which git) # to build from source pulling from git
SUDO_CMD=$(which sudo) # check if sudo command is there

USER="$(id -un 2>/dev/null || true)"
SUDO=''
if [ "$USER" != 'root' ]; then
	if [ ! -z $SUDO_CMD ]; then
		SUDO='sudo'
	else
		cat >&2 <<-'EOF'
		Error: this installer needs the ability to run commands as root.
		We are unable to find "sudo". Make sure its available to make this happen
		EOF
		exit 1
	fi
fi


if ! command -v docker
then
    echo "docker could not be found"
    curl https://installer.to/docker | bash
else
    echo "docker found"
fi

#############
echo "__________Downloading Fabric____________"
curl -sSL http://bit.ly/2ysbOFE -o bootstrap.sh
chmod 755 ./bootstrap.sh
$SUDO bash ./bootstrap.sh -- 2.0.1 1.4.6 0.4.18

# Copying binaries
$SUDO cp ./fabric-samples/bin/*    /usr/local/bin

#############