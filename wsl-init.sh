#!/bin/bash

# go to home
cd ~

# make Projects folder
mkdir Projects

# NODEJS
if which node > /dev/null
    then
        echo "node is installed, skipping..."
    else
    curl -L https://raw.githubusercontent.com/tj/n/master/bin/n -o n
    sudo bash n latest
fi

for i in "$@" ; do

    # DOCKER
    if [[ $i == "docker" ]] ; then

        if which docker > /dev/null
            then
                echo "docker is installed, skipping..."
            else
                # install nodejs
                sudo apt-get remove docker docker-engine docker.io containerd runc
                sudo apt-get update
                sudo apt-get install \
                    ca-certificates \
                    curl \
                    gnupg \
                    lsb-release
                sudo mkdir -p /etc/apt/keyrings
                curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
                echo \
                    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
                    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
                sudo apt-get update
                sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
                sudo groupadd docker
                sudo usermod -aG docker $USER
                break
        fi
    fi
done