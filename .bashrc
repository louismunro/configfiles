# allow ^-o
stty discard '^-'

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# set prompt 
if [ -n "$PS1" ]; then 
    PS1='\033[1;33m\]$( __kube_ps1 ) \[\033[1;32m\]: \w  $( parse_git_branch ) \n ${?##0}\$ \[\033[1;37m\]'; 
fi

# VARIABLES 
export PATH=/opt/local/bin:/opt/local/sbin:/usr/local/bin:~/bin:$PATH
export MANPATH=/usr/local/man:opt/local/man:/opt/local/share/man:${MANPATH}
export HISTCONTROL=ignoredups # ignore duplicate commands in history
export HISTSIZE=10000
export EDITOR=/usr/bin/vim # set vi as default editor
export PAGER=less # use less
export LESS=im # set pager options (see man 1 less)

# SHELL OPTIONS
# Make bash check it's window size after a process completes
shopt -s checkwinsize

# prevent file clobbering
set -o noclobber

# Make Bash append rather than overwrite the history on disk
shopt -s histappend

# Whenever displaying the prompt, write the previous line to disk
export PROMPT_COMMAND='history -a'

# correct minor spelling errors in a cd command
shopt -s cdspell

# ksh-88 egrep-style extended pattern matching
shopt -s extglob

# source bash completion on OS X 
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

source ~/.bashfunc
source ~/.bashalias
source ~/.bashlocal

complete -C /usr/local/bin/vault vault
