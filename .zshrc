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
