#!/bin/bash
#
# script name: participation-node-recipe.bash
# script author: munair simpson
# script created: 20190615
# script purpose: spin up a non-relay Algorand node on an AWS EC2 c5.4xlarge instance running Ubuntu 18.04 LTS

# additional notes
# for further information, please refer to:
# https://developer.algorand.org/docs/installing-ubuntu

# make a directory to house the installer.
mkdir ~/inst

# make the installer directory the current working directory.
cd ~/inst

# download the installer.
git clone https://github.com/algorand/go-algorand-doc.git
cd go-algorand-doc/downloads/installers/linux_amd64/

# verify the download.
OFFICIAL_ALGORAND_INSTALLER_SHA=$(curl https://raw.githubusercontent.com/algorand/go-algorand-doc/master/downloads/installers/linux_amd64/install_master_linux-amd64.sha256 2>/dev/null | awk '{print $1}')
DOWNLOADED_SHA=$(sha256sum go-algorand-doc/downloads/installers/linux_amd64/install_master_linux-amd64.tar.gz | awk '{print $1}')
if [ "$OFFICIAL_ALGORAND_INSTALLER_SHA" -ne "$DOWNLOADED_SHA" ]; then echo -en "\a" && echo "the file you downloaded is not the same as the official Algorand installer. exiting..."; exit ; fi

# run the installer.
tar -xf install_master_linux-amd64.tar.gz
./update.sh -i -c stable -p ~/node -d ~/node/data -n

# exit
echo -en "\a"
echo $0: made a beep to signal the completion of all automated tasks. you still need to manually reboot this server.
echo $0: exiting...
exit 0
