#!/bin/bash

yum -y install git
cd
git clone https://github.com/sticker/dotfiles

~/dotfiles/deploy.sh
~/dotfiles/init.sh $@
