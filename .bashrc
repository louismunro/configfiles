# set prompt 
if [ -n "$PS1" ]; then 
    PS1='\[\033[1;33m\]\h \[\033[1;32m\]\u: \w\n${?##0}\$ \[\033[1;37m\]'; 
fi

# VARIABLES 
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

# ALIASES
alias pu="pushd"
alias po="popd"
alias rm="rm -i"
alias l="ls -hFG"
alias ll="ls -lhFG"
alias la="ls -alhFG"
alias addalias="$EDITOR ~/.bashrc; source ~/.bashrc"

bak () {
    cp -i $1 ${1}.`date +%y%m%d`
}

cstream () {
    perl -p -e "s/$1/\e[31m$&\e[0m/i"
}
