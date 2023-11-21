#!/bin/bash
# startup user data for ec2 instance.
sudo yum update -y

# Install SteamCMD pre-reqs
sleep 10
sudo yum install -y glibc.i686 libstdc++48.i686

# Create SteamCMD directory
sudo mkdir ~/steamcmd && cd ~/steamcmd

# Download SteamCMD
sudo wget 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz'

# Unpack SteamCMD
sudo tar -xzvf steamcmd_linux.tar.gz && sudo rm -f steamcmd_linux.tar.gz

export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
export SteamAppId="1690800" # -beta latest_experimental

# Launch SteamCMD and update 7 Days to Die (gameid=294420 )
sudo ./steamcmd.sh +force_install_dir ~/SatisfactoryDedicatedServer +login anonymous +app_update $SteamAppId -beta public validate +quit

# copy service file from s3
sudo aws s3 cp s3://8dot3/satisfactory/satisfactory.service /tmp/

sudo chmod +x /tmp/satisfactory.service
sudo cp /tmp/satisfactory.service /etc/systemd/system
sudo systemctl start satisfactory
sudo systemctl enable satisfactory

# End of line