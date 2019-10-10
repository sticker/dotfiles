#!/bin/bash

yum -y install epel-release
yum -y install man wget which dos2unix screen bind-utils hdparm lsof jwhois nkf expect net-tools nc telnet tar bash-completion
yum -y update nss
yum -y remove git
curl -s https://setup.ius.io/ | bash
yum -y install git2u
yum -y groupinstall "Development Tools" --exclude=git

if [ ! -d ~/neovim ]; then
    yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
    yum install -y neovim python3-neovim python2-neovim
fi

if [ ! -d ~/.anyenv ]; then
    git clone https://github.com/anyenv/anyenv ~/.anyenv
    source ~/.bash_profile
    yes | anyenv install --init
    anyenv install rbenv
    anyenv install pyenv
    anyenv install nodenv
    source ~/.bash_profile
fi

while getopts rpn OPT
do
    case $OPT in
        r)  RUBY=1
            ;;
        p)  PYTHON=1
            ;;
        n)  NODE=1
            ;;
    esac
done

shift $((OPTIND - 1))

if [ -n "$RUBY" ]; then
    yum -y install openssl-devel readline-devel zlib-devel libcurl-devel bzip2
    VERSION=$(rbenv install --list | grep 2 | grep -v r | grep -v mag | grep -v dev | tail -1)
    rbenv install $VERSION
    rbenv global $VERSION
fi


if [ -n "$PYTHON" ]; then
    yum -y install zlib-devel bzip2 bzip2-devel readline-devel sqlite-devel openssl-devel libffi-devel
    VERSION=$(pyenv install --list | egrep '  3.7..$' | tail -1)
    pyenv install $VERSION
fi

if [ -n "$NODE" ]; then
    VERSION=$(nodenv install --list | grep '  10.' | tail -1)
    nodenv install $VERSION
fi
