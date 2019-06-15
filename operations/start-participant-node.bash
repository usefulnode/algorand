#!/bin/bash
#
# script name: start-participant-node.bash
# script author: munair simpson
# script created: 20190615
# script purpose: start a non-relay Algorand node on an AWS EC2 c5.4xlarge instance running Ubuntu 18.04 LTS

# additional notes
# for further information, please refer to:
# https://developer.algorand.org/docs/installing-ubuntu

# make the node directory the current working directory.
cd ~/node/

# configure telemetry.
./diagcfg telemetry name -n usefulnode

# output node name for Algorand community.
./goal logging

# start participant node.
./goal node start -d data

# verify algod is running.
pgrep algod

# verify syncing of network.
# ./carpenter -d data
goal node status -d data

# exit
echo -en "\a"
echo $0: made a beep to signal the completion of all automated tasks. you still need to manually reboot this server.
echo $0: exiting...
exit 0
