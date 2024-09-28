#!/bin/bash
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

stty -ixon # Disable ctrl-s and ctrl-q.
export EDITOR='nvim'
export VISUAL='nvim'
#PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
PS1='[\u@\h \W]\$ '

# Aliases
alias sudo='sudo '
alias vim='nvim'
alias c='clear'
alias bashrc='nvim ~/.bashrc'
alias vimconfig='nvim ~/.config/nvim/'
alias i3config='nvim ~/.config/i3/config'
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Aliases DWM
alias dwmclean='make clean && rm -f config.h && git reset --hard upstream/master'
