#!/bin/bash
# UTSC source
sudo mv sources.list /etc/apt/sources.list
sudo apt update
sudo apt -y upgrade
sudo apt -y autoremove

# install basic utils
cat basic-utils-list | while read line; do
	sudo apt -y install $line
done

# install umake
sudo add-apt-repository ppa:lyzardking/ubuntu-make
sudo apt-get update
sudo apt-get install ubuntu-make

# install nodejs
sudo snap install node --classic
npm config set registry https://registry.npm.taobao.org
# install tldr
#npm install -g tldr

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
