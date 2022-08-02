# This file downloaded from https://raw.githubusercontent.com/ArcherGodson/env/master/.zshrc
# You can use `curl -L https://raw.githubusercontent.com/ArcherGodson/env/master/.zshrc > /etc/zsh/zshrc`
# Also can use `wget -O - https://raw.githubusercontent.com/ArcherGodson/env/master/.zshrc > /etc/zsh/zshrc`
HISTFILE=~/.histfile
HISTSIZE=8000
SAVEHIST=8000
bindkey -e
zstyle :compinstall filename '~/.zshrc'
zstyle ':completion:*' rehash true

autoload -Uz compinit
compinit -i

autoload -U promptinit
promptinit
PROMPT=$' %{\e[1;34m%}%~ %{\e[1;31m%}%#%{\e[0m%} '
RPROMPT=$'%{\e[1;30;47m%} %* %{\e[0m%}'

precmd()
{
    [[ -t 1 ]] || return
    case $TERM in
	*xterm*|rxvt|(dt|k|E)term*) print -Pn "\e]2;[%~] :: %n@%m\a"
	;;
    esac
}
preexec() {
    [[ -t 1 ]] || return
    case $TERM in
	*xterm*|rxvt|(dt|k|E)term*) print -Pn "\e]2;<$1> :: %n@%m\a"
	;;
    esac
}

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

zmodload zsh/complist
setopt menucomplete
zstyle ':completion:*' menu yes select

bindkey '^[[1;5A' history-beginning-search-backward
bindkey '^[[1;5B' history-beginning-search-forward
bindkey -s '^x^f' '\eqdf -h\n'
bindkey -s '^x^d' '\eqmkdir `date +%Y-%m-%d`\n'

export TERM=xterm-256color

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias ccze='ccze -m ansi'
alias google='~/tools/google.sh'
alias id_system='echo "System identification"; (
COL1=20
COL2=40
HL="\033[1m"
NORM="\033[0m"
nets="${HL}Networks:${NORM}\n";
nets=$nets$(printf "%$(( ${COL1}+${COL2} ))s\n" $(ip a sh | grep -vE "127\.|::1/128" | grep inet | sed "s/^.*inet[^ ]*[ ]//;s/[ ].*$//"))
echo "$nets"&;
printf "${HL}%-${COL1}s${NORM}%${COL2}s\n" "HOSTNAME:" "$(hostname -f)"&;
printf "${HL}%-${COL1}s${NORM}%${COL2}s\n" "External IP:" "$(curl -s ifconfig.me)";
)'

case $TERM in
linux)
bindkey "^[[2~" yank
bindkey "^[[3~" delete-char
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[e" expand-cmd-path ## C-e for expanding path of typed command
bindkey "^[[A" up-line-or-search ## up arrow for back-history-search
bindkey "^[[B" down-line-or-search ## down arrow for fwd-history-search
bindkey " " magic-space ## do history expansion on space
;;
*xterm*)
bindkey "^[[3~" delete-char
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
;;
rxvt|(dt|k|E)term)
bindkey "^[[2~" yank
bindkey "^[[3~" delete-char
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history
bindkey "^[[7~" beginning-of-line
bindkey "^[[8~" end-of-line
bindkey "^[e" expand-cmd-path ## C-e for expanding path of typed command
bindkey "^[[A" up-line-or-search ## up arrow for back-history-search
bindkey "^[[B" down-line-or-search ## down arrow for fwd-history-search
bindkey " " magic-space ## do history expansion on space
;;
esac
