# Fabric 2.0
# May 2020

# how to use vagrant (If you are on Windows)
Make sure to install Virtual Box and Vagrant
cd into this directory.
vagrant up


# 1 Open a terminal
cd network/setup

# 2 Install Pre-Requisites & Validate
./install-prereqs.sh
./validate-prereqs.sh

# 3 Install the Fabric binaries & images
sudo -E ./install-fabric.sh
./validate-fabric.sh

# 4 Install Hyperledger Explorer tool
./install-explorer.sh
./validate-explorer.sh

# 5 Install the Go Tools
./install-gotools.sh





