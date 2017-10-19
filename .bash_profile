# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=/usr/local/bin:$PATH:$HOME/bin

export PATH

unset http_proxy
unset https_proxy
unset no_proxy
unset HTTP_PROXY
unset HTTPS_PROXY
unset NO_PROXY

export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

