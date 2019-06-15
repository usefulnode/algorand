#!/bin/bash
#
# script name: start-relay-node.bash
# script author: munair simpson
# script created: 20190615
# script purpose: start a Algorand relay node on an AWS EC2 c5.4xlarge instance running Ubuntu 18.04 LTS

# additional notes
# for further information, please refer to:
# https://developer.algorand.org/docs/configure-your-node-relay

# create a configuration file from the template provided.
cp ~/algorand/testnet/data/relay/config.json.example ~/algorand/testnet/data/relay/config.json
sed -i.bak 's/"NetAddress": ""/"NetAddress": ":4161"/g' ~/algorand/testnet/data/relay/config.json

# make the Algorand testnet directory the current working directory.
cd ~/algorand/testnet

# specify the node name (configure telemetry).
./diagcfg telemetry name -n usefulnode.algorand.network

# enable metrics.
./diagcfg metric enable -d data/relay/

# install and run as a service.
sudo ./systemd-setup.sh ubuntu ubuntu
sudo systemctl enable algorand@$(systemd-escape /home/ubuntu/algorand/testnet/data/relay)
sudo systemctl start algorand@$(systemd-escape /home/ubuntu/algorand/testnet/data/relay)
crontab -e

# verify syncing of network.
# ./carpenter -d data/relay/
./goal node status -d data/relay/

# exit
echo -en "\a"
echo $0: made a beep to signal the completion of all automated tasks. you still need to manually reboot this server.
echo $0: exiting...
exit 0
