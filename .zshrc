# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
#setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
#setopt HIST_REDUCE_BLANKS
#setopt HIST_VERIFY

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
function zle-line-finish {
RPS1=""
RPS2=""
zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
zle -N zle-line-finish

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^h' backward-delete-char
bindkey '^?' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^k' history-beginning-search-backward
bindkey '^j' history-beginning-search-forward


autoload zkbd
[[ ! -f ${ZDOTDIR:-$HOME}/.zkbd/$TERM-:0 ]] && zkbd
source ${ZDOTDIR:-$HOME}/.zkbd/$TERM-:0

[[ -n ${key[Backspace]} ]] && bindkey "${key[Backspace]}" backward-delete-char
[[ -n ${key[Insert]} ]] && bindkey "${key[Insert]}" overwrite-mode
[[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n ${key[PageUp]} ]] && bindkey "${key[PageUp]}" up-line-or-history
[[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
[[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
[[ -n ${key[PageDown]} ]] && bindkey "${key[PageDown]}" down-line-or-history
[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-search
[[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-search
[[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char

export KEYTIMEOUT=1
#export PROMPT="[%{$fg_no_bold[green]%}%n%{$reset_color%}] %~: "
#export RPROMPT="[%{$fg_no_bold[cyan]%}%?%{$reset_color%}]"


# variable names for g4 workspaces
CITC_ALL_ROOT=/google/src/cloud/abulanowski/
#CITC_PATTERN='/google/src/cloud/abulanowski/\([^\/]\)/google3/\(.*\)'
CITC_PATTERN='/google/src/cloud/abulanowski/([^/]*)/google3/?(.*)'

function msec_now {
  echo $(($(date +%s%N)/1000000))
}

function preexec() {
  timer=$(msec_now)
}

function precmd() {
  if [ ! -z $timer ]; then
    time_end=$(msec_now)
    timer_diff=$(($time_end - $timer))


    if [ "$timer_diff" -le "1000" ]
    then
      unset timer
      return
    fi

    echo "Started on: \t" $(show_date_msec $timer)
    echo "Ended on: \t" $(show_date_msec $time_end)
    echo "Time taken: \t" $(show_time_msec $timer_diff)
    unset timer
  fi
}

function show_date_msec {
  echo $(date "+%H:%M:%S" --date="@$(($1 / 1000))").$(printf "%03d" $(($1 % 1000)))
}

function show_time_msec {
  timer=$1
  msec=$(($timer % 1000))
  timer=$(($timer / 1000))
  sec=$(($timer% 60))
  timer=$(($timer / 60))
  min=$(($timer % 60))
  timer=$(($timer / 60))
  hour=$(($timer % 60))

  printf "%02d:%02d:%02d.%03d" $hour $min $sec $msec
}

export C=~
PATH_PATTERN="%{$fg_no_bold[blue]%}%~%{$reset_color%}"

function chpwd {
  if [[ `pwd` =~ $CITC_PATTERN ]]
  then
    repo_name="%{$fg_no_bold[cyan]%}[$match[1]]%{$reset_color%}"
    repo_path="%{$fg_no_bold[blue]%}//$match[2]%{$reset_color%}"
    PATH_PATTERN="$repo_name $repo_path"
    C=${CITC_ALL_ROOT}${match[1]}/google3/
  else
    PATH_PATTERN="%{$fg_no_bold[blue]%}%~%{$reset_color%}"
    C=~
  fi
}
chpwd # Update path variables on new terminals that get started in non-home directory
      # it would be nice to initialize them to correct values instead of assuming home
      # but it would make code more complicated. Fix if you put any statefull logic 
      # in chpwd

red_if_exit_non_zero='%(?/ /%{$fg_no_bold[red]%}!%{$reset_color%})'
#cwd='%{$fg_no_bold[blue]%}%~%{$reset_color%}'
cwd='$(echo $PATH_PATTERN)'
line_break_if_long='%($((${COLUMNS} - 30))l/
/)'

function get_special_func() {
  echo -n $SPECIAL
}
get_special='$(get_special_func)'
setopt prompt_subst
PROMPT="${red_if_exit_non_zero}${cwd}${line_break_if_long} ${get_special}> "


# TODO prompt
# time taken by command (possibly if higher than some threshold)
# git branch and status - optional for now
# virtual env - optional for now
# cool looking powerline fonts ?


alias ls="ls --color=auto"
alias la="ls -a --color=auto"
alias ll="ls -lat --color=auto"

function font_size {
    printf '\e]710;%s\007' "xft:Sauce Code Powerline:pixelsize=$1"
}

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
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=7'
bindkey '^ ' autosuggest-execute
bindkey '^l' autosuggest-accept
antibody bundle zsh-users/zsh-history-substring-search
bindkey '^p' history-substring-search-up
bindkey '^n' history-substring-search-down

# z - for jumping around, v - for vim files, autojump for cd's
antibody bundle 'clvv/fasd kind:path' # some help with selecting paths
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

#export WORKON_HOME=$HOME/.virtualenvs
#export PROJECT_HOME=$HOME/dev
#source /usr/local/bin/virtualenvwrapper.sh

alias l='ls'
alias v='fasd -e vim -sif'

function set_font {
    printf '\e]710;%s\007' $1
}

function set_size {
    set_font "xft:Sauce Code Powerline:pixelsize="$1
}

alias u="cd ../"
alias uu="cd ../../"
alias uuu="cd ../../../"
alias uuuu="cd ../../../../"
alias uuuuu="cd ../../../../../"

export LESS=-FXMRiS#8j.5
alias cdg='cd `git rev-parse --show-toplevel 2> /dev/null`'

alias sudo='sudo '
alias cal='ncal -M -b'

## Google ##
source /etc/bash_completion.d/g4d
export EDITOR=vim
export P4INGORE=tags
alias ag="ag --path-to-ignore ~/.ignore "
export PATH=$PATH:~/.bin/
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'
export P4DIFF='git --no-pager diff --color=always --no-index'
alias g4diff='g4 diff | less -XR'
alias ssh='TERM=xterm ssh '

function expand_alias() {
  res=$(alias | grep "^$1=" | cut -d= -f 2- | cut -d\' -f 2)
  if [ $? -eq 0 ]
  then
    echo $res
  else
    echo $1
  fi
}

function replace_with_alias() {
  al=$(expand_alias $(echo "$1 " | cut -d' ' -f 1))
  if [ $? -eq 0 ]
  then
    echo $al $(echo "$1 " | cut -d' ' -f 2-)
  else
    echo $1
  fi
}


alias prod='gcert -s -m usps-testbed,bm-testbed,borg-test'
alias staging_gcloud='CLOUDSDK_API_CLIENT_OVERRIDES_COMPUTE=staging_v1 TERM=xterm /google/data/ro/teams/cloud-sdk/gcloud'
alias cl='build_cleaner ... && $(replace_with_alias "$(fc -ln -1)")'
alias bc='build_cleaner ...'

alias T='echo TEST'
alias -g bt='blaze test'
alias -g bta='blaze test ...'
alias -g btl='blaze test --test_output=streamed'
alias -g bb='blaze build'
alias -g bba='blaze build ...'

# regenerate using  TERMINFO=~/.hgterm tic -x ~/.hgterminfo
alias hg='TERMINFO=~/.hgterm hg'
alias hup='hg fix && hg uploadchain'

alias N='notify-send $( [ $? -eq 0 ] && echo "Success" || echo "Failure" )'

source /etc/bash.bashrc.d/shell_history_forwarder.sh
alias admin_session='SPECIAL="$fg_no_bold[red]ADMIN$reset_color " /google/data/ro/projects/tonic/admin_session'
alias test_zsh='SPECIAL="$fg_no_bold[red]ADMIN$reset_color " zsh'

alias bm='cd $C/borg/bare_metal'
alias bo='cd $C/borg/borglet/offload'
alias exp='cd $C/experimental/users/abulanowski'

function blaze-bin {
  if [[ `pwd` =~ $CITC_PATTERN ]]
  then
    if [[ $match[2] =~ 'blaze-bin/(.*)' ]]
    then
      cd $C/$match[1]
    else
      cd $C/blaze-bin/$match[2]
    fi
  else
    echo "Not in Citc"
  fi
}

alias bm_ssh='staging_gcloud --project=bare-metal-staging compute ssh --tunnel-through-iap --iap-tunnel-url-override=wss://tunnel-staging.cloudproxy.app/v4'
alias bm_scp='staging_gcloud --project=bare-metal-staging compute scp --tunnel-through-iap --iap-tunnel-url-override=wss://tunnel-staging.cloudproxy.app/v4'

function screen {
  if [[ $# == 0 ]]
  then
    scrn DEFAULT_SESSION
  else
    scrn  $@
  fi
}
