# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias vi='nvim'
alias view='nvim -R'
alias vim='nvim'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
