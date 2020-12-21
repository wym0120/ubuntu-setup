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

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#######################################
#          coq environment
#######################################
# emacs
sudo snap install emacs --classic
cp init.el ~/.emacs.d/init.el
# opam
sudo add-apt-repository ppa:avsm/ppa
sudo apt update
sudo apt install opam
opam init
eval $(opam env)
opam install opam-depext
opam-depext coq
opam pin add coq 8.12.2
# general proof
git clone https://github.com/ProofGeneral/PG ~/.emacs.d/lisp/PG
cd ~/.emacs.d/lisp/PG
make
# Finally, install general proof and company-coq in emacs
