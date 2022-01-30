# Add path to homebrew utils
[[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)

if [[ -f /opt/dev/dev.sh ]]; then source /opt/dev/dev.sh; fi
if [ -e /Users/lmunro/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/lmunro/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

export SHELL=/bin/zsh

export PATH=/opt/local/bin:/opt/local/sbin:/usr/local/bin:~/bin:$PATH
export MANPATH=/usr/local/man:opt/local/man:/opt/local/share/man:${MANPATH}
export EDITOR=nvim 
export PAGER=less 
export LESS=im # set pager options (see man 1 less)


# ZSH options
bindkey -e # readline `emacs` mode editing
export SAVEHIST=10000
export HISTSIZE=10000
setopt noclobber
setopt nocaseglob
setopt correct
setopt sharehistory
setopt appendhistory
setopt incappendhistory
setopt histignoredups
setopt histreduceblanks
setopt extendedhistory
setopt interactivecomments
# Perform textual history expansion, csh-style, treating the character ‘!’ specially.
setopt banghist 
setopt histverify
# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
# Emacs style
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# use bash style "word" definition for line editing
autoload -U select-word-style
select-word-style bash

# initialize fancy completion
FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
autoload -Uz compinit ; compinit

# cloudplatform: add Shopify clusters to your local kubernetes config
export KUBECONFIG=${KUBECONFIG:+$KUBECONFIG:}/Users/lmunro/.kube/config:/Users/lmunro/.kube/config.shopify.cloudplatform

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

source <(kubectl completion zsh)
for file in /Users/lmunro/src/github.com/Shopify/cloudplatform/workflow-utils/*.bash; do source ${file}; done
kubectl-short-aliases


source ~/.bashlocal
source ~/.bashalias
source ~/.bashfunc

# set prompt 
if [ -n "$PS1" ]; then 
    if [[ -f /opt/homebrew/opt/kube-ps1/share/kube-ps1.sh ]]; then
        # cf https://github.com/jonmosco/kube-ps1
        source /opt/homebrew/opt/kube-ps1/share/kube-ps1.sh
        KUBE_PS1_SYMBOL_ENABLE=false
        KUBE_PS1_CTX_COLOR=yellow
        KUBE_PS1_NS_COLOR=yellow
        NEWLINE=$'\n'
        PS1='$(kube_ps1) %F{green}%3~%f${NEWLINE}%F{cyan}$(parse_git_branch)%f %(?..%F{red}%?%f)> %# '; 
    else
        PS1='%F{green}%3~%f${NEWLINE}%F{cyan}$(parse_git_branch)%f %(?..%F{red}%?%f)> %# '; 
    fi
fi

[[ -f /opt/dev/sh/chruby/chruby.sh ]] && type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; }

