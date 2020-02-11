export SHELL=/bin/zsh

export PATH=/opt/local/bin:/opt/local/sbin:/usr/local/bin:~/bin:$PATH
export MANPATH=/usr/local/man:opt/local/man:/opt/local/share/man:${MANPATH}
export EDITOR=nvim 
export PAGER=less 
export LESS=im # set pager options (see man 1 less)


# ZSH options
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
# Perform textual history expansion, csh-style, treating the character ‘!’ specially.
setopt banghist 
setopt histverify

# initialize fancy completion
autoload -Uz compinit && compinit

# cloudplatform: add Shopify clusters to your local kubernetes config
export KUBECONFIG=${KUBECONFIG:+$KUBECONFIG:}/Users/lmunro/.kube/config:/Users/lmunro/.kube/config.shopify.cloudplatform

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

for file in /Users/lmunro/src/github.com/Shopify/cloudplatform/workflow-utils/*.bash; do source ${file}; done
kubectl-short-aliases


source ~/.bashlocal
source ~/.bashalias
source ~/.bashfunc

# set prompt 
if [ -n "$PS1" ]; then 
  export PROMPT_DIRTRIM=5
    if [[ -f /usr/local/opt/kube-ps1/share/kube-ps1.sh ]]; then
        # cf https://github.com/jonmosco/kube-ps1
        source /usr/local/opt/kube-ps1/share/kube-ps1.sh
        KUBE_PS1_SYMBOL_ENABLE=false
        KUBE_PS1_CTX_COLOR=yellow
        KUBE_PS1_NS_COLOR=yellow
        NEWLINE=$'\n'
        PS1='$(kube_ps1) %F{green}%3~%f${NEWLINE}%F{cyan}$(parse_git_branch)%f %?> %# '; 
    else
        PS1='%F{green}%3~%f${NEWLINE}%F{cyan}$(parse_git_branch)%f %?> %# '; 
    fi
fi