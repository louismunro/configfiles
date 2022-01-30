# dev fuckery? force SHELL to bash
export SHELL=$(which bash)
# allow ^-o
stty discard '^-'

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# VARIABLES 
export PATH=/opt/local/bin:/opt/local/sbin:/usr/local/bin:~/bin:$PATH
export MANPATH=/usr/local/man:opt/local/man:/opt/local/share/man:${MANPATH}
export HISTCONTROL=ignoredups 
export HISTSIZE=10000
export EDITOR=nvim 
export PAGER=less 
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
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
source ~/.kube/kubectl_autocompletion

source ~/.bashfunc
source ~/.bashalias
source ~/.bashlocal

# load dev, but only if present and the shell is interactive
if [[ -f /opt/dev/dev.sh ]] && [[ $- == *i* ]]; then
 source /opt/dev/dev.sh
fi

# cloudplatform: add Shopify clusters to your local kubernetes config
export KUBECONFIG=${KUBECONFIG:+$KUBECONFIG:}/Users/lmunro/.kube/config:/Users/lmunro/.kube/config.shopify.cloudplatform
for file in /Users/lmunro/src/github.com/Shopify/cloudplatform/workflow-utils/*.bash; do source ${file}; done
kubectl-short-aliases

# set prompt 
if [ -n "$PS1" ]; then 
  export PROMPT_DIRTRIM=5
    if [[ -f /usr/local/opt/kube-ps1/share/kube-ps1.sh ]]; then
        # cf https://github.com/jonmosco/kube-ps1
        source /usr/local/opt/kube-ps1/share/kube-ps1.sh
        KUBE_PS1_SYMBOL_ENABLE=false
        KUBE_PS1_CTX_COLOR=yellow
        KUBE_PS1_NS_COLOR=yellow
        PS1='$(kube_ps1)\[\033[1;32m\] \w  $( parse_git_branch ) \n ${?##0}\$ \[\033[1;37m\]'; 
    else
        PS1='\[\033[1;32m\]\w  $( parse_git_branch ) \n ${?##0}\$ \[\033[1;37m\]'; 
    fi
fi

# init rbenv
# eval "$(rbenv init -)"

[[ -f /opt/dev/sh/chruby/chruby.sh ]] && type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; }

[[ -x /usr/local/bin/brew ]] && eval $(/usr/local/bin/brew shellenv)

[[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)
