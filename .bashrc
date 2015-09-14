# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# set prompt 
if [ -n "$PS1" ]; then 
    PS1='\[\033[1;33m\]\H \[\033[1;32m\]\u: \w  $( parse_git_branch )\n${?##0}\$ \[\033[1;37m\]'; 
fi

# VARIABLES 
export PATH=/opt/local/bin:/opt/local/sbin:/usr/local/bin:$PATH
export CDPATH=$CDPATH:.:/usr/local
export MANPATH=/usr/local/man:opt/local/man:/opt/local/share/man:${MANPATH}
export HISTCONTROL=ignoredups # ignore duplicate commands in history
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


# complete ssh hostnames
complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | cut -f 1 -d, | sort -u | grep -v '\['`; )" ssh

source ~/.bashfunc
source ~/.bashalias
source ~/.bashlocal
