#!/bin/bash

yum -y install epel-release
yum -y install man wget which dos2unix screen bind-utils hdparm lsof jwhois nkf expect net-tools nc telnet tar
yum -y update nss
yum -y remove git
curl -s https://setup.ius.io/ | bash
yum -y install git2u
yum -y groupinstall "Development Tools" --exclude=git

if [ ! -d ~/neovim ]; then
    yum -y install libtool automake cmake gcc gcc-c++ make pkgconfig unzip
    cd /usr/local/src
    curl -L -O http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz
    tar zxf autoconf-2.69.tar.gz
    cd autoconf-2.69
    yum install -y openssl-devel
    ./configure
    make && make install
    cd
    git clone https://github.com/neovim/neovim
    cd neovim/
    make
    make install
fi

if [ ! -d ~/.anyenv ]; then
    git clone https://github.com/riywo/anyenv ~/.anyenv
    . ~/.bash_profile
    anyenv install rbenv
    anyenv install pyenv
    anyenv install ndenv
    git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.anyenv/envs/pyenv/plugins/pyenv-virtualenv
    . ~/.bash_profile
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
    
    rpm -ivh http://www.city-fan.org/ftp/contrib/yum-repo/city-fan.org-release-1-13.rhel6.noarch.rpm
    yum -y update --enablerepo=city-fan.org libcurl
    
    VERSION=$(rbenv install --list | grep 2 | grep -v r | grep -v mag | grep -v dev | tail -1)
    rbenv install $VERSION
    rbenv global $VERSION
fi


if [ -n "$PYTHON" ]; then
    yum -y install zlib-devel bzip2 bzip2-devel readline-devel sqlite-devel openssl-devel

    VERSION=$(pyenv install --list | grep anaconda3 | tail -1)
    pyenv install $VERSION
    pyenv virtualenv $VERSION anaconda3
fi

if [ -n "$NODE" ]; then
    VERSION=$(ndenv install --list | grep v8 | tail -1)
    ndenv install $VERSION
fi
