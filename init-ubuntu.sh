# steps for ubuntu linux
sudo apt update
sudo apt upgrade

# add steam user
sudo useradd -m steam
sudo passwd steam # will prompt for a new password
sudo usermod -aG sudo steam
sudo -u steam -s
cd /home/steam

# install SteamCMD
sudo apt install wget screen
sudo add-apt-repository multiverse; sudo dpkg --add-architecture i386; sudo apt update
sudo apt install steamcmd
sudo ln -s /usr/games/steamcmd /home/steam/steamcmd


# Launch SteamCMD and update game
export SteamAppId="1690800"
sudo ./steamcmd +force_install_dir ~/SatisfactoryDedicatedServer +login anonymous +app_update $SteamAppId -beta public validate +quit


# create service
cat > /tmp/satisfactory.service << EOF
[Unit]
Description=Satisfactory dedicated server
Wants=network-online.target
After=syslog.target network.target nss-lookup.target network-online.target

[Service]
Environment="LD_LIBRARY_PATH=./linux64"
ExecStartPre=/usr/games/steamcmd +force_install_dir "/home/steam/SatisfactoryDedicatedServer" +login anonymous +app_update 1690800 validate +quit
ExecStart=/home/steam/SatisfactoryDedicatedServer/FactoryServer.sh -multihome <ip-address>
User=steam
Group=steam
StandardOutput=journal
Restart=on-failure
WorkingDirectory=/home/steam

[Install]
WantedBy=multi-user.target
EOF

sudo chmod +x /tmp/satisfactory.service
sudo cp /tmp/satisfactory.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl start satisfactory
sudo systemctl enable satisfactory

# End of line
