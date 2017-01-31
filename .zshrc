# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
bindkey -v
autoload -U colors && colors
# End of lines configured by zsh-newuser-install
zstyle :compinstall filename '/home/envielox/.zshrc'

autoload -Uz compinit && compinit
# End of lines added by compinstall
autoload -U promptinit && promptinit

function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^h' backward-delete-char
bindkey '^?' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

export KEYTIMEOUT=1
#export PROMPT="[%{$fg_no_bold[green]%}%n%{$reset_color%}] %~: "
#export RPROMPT="[%{$fg_no_bold[cyan]%}%?%{$reset_color%}]"

PROMPT="(%{$fg_no_bold[red]%}%h%{$reset_color%}) %{$fg_no_bold[blue]%}%~ %{$reset_color%}> "
RPROMPT="[%{$fg_no_bold[green]%}%?%{$reset_color%}]"

alias ls="ls --color=auto"
alias la="ls -a --color=auto"
alias ll="ls -lat --color=auto"

export GOPATH=/home/aleksander/.gopath/
export PATH=${GOPATH//://bin:}/bin:$PATH

export TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S'

# Antibody Instalation
#curl -s https://raw.githubusercontent.com/getantibody/installer/master/install | bash -s
source <(antibody init)

plugins=(autojump command-not-found common-aliases compleat docker fasd git jsontools pip pylint python virtualenvwrapper)

antibody bundle zsh-users/zsh-syntax-highlighting
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=magenta
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=blue,bold
antibody bundle zsh-users/zsh-completions
antibody bundle zsh-users/zsh-autosuggestions
bindkey '^ ' autosuggest-execute
bindkey '^l' autosuggest-accept
antibody bundle zsh-users/zsh-history-substring-search
bindkey '^k' history-beginning-search-backward
bindkey '^j' history-beginning-search-forward
bindkey '^p' history-substring-search-up

# z - for jumping around, v - for vim files, autojump for cd's
antibody bundle clvv/fasd # some help with selecting paths
eval "$(fasd --init auto)"

#antibody bundle tonyseek/oh-my-zsh-virtualenv-prompt
#antibody bundle command-not-found
#antibody bundle common-aliases
#antibody bundle compleat
##antibody bundle docker
#antibody bundle git
##antibody bundle jsontools
#antibody bundle pip
##antibody bundle pylint
#antibody bundle python

# TODO rest of plugins
# TODO neat color scheme
# TODO git repo, branch, vEnv, time of last command, return code in prompt

export WECHALLUSER="Envielox"
export WECHALLTOKEN="4AA28-99A75-71600-AA205-95043-1A94C"

export WORKON_HOME=$HOME/.virtualenvs
#export PROJECT_HOME=$HOME/dev
source /usr/local/bin/virtualenvwrapper.sh

alias v='fasd -e vim -sif'
