eval "$(oh-my-posh init bash --config C:/Users/Muhammed/AppData/Local/Programs/oh-my-posh/themes/microverse-power.omp.json)"
# eval "$(oh-my-posh init bash --config C:/Users/Muhammed/AppData/Local/Programs/oh-my-posh/themes/nordtron.omp.json)"
export PYTHONIOENCODING="utf-8"
eval "$(thefuck --alias)"

# Aliases
alias falcon='cd D:/PROJECTS/falcon/'
alias cst='clear;git status'
alias dl="cd ~/Downloads"
alias p="cd ~/projects"
alias g="git"

alias matrix=MATRIX
MATRIX()
{
	echo -e "\e[1;40m" ; clear ; while :; do echo $LINES $COLUMNS $(( $RANDOM % $COLUMNS)) $(( $RANDOM % 72 )) ;sleep 0.05; done|awk '{ letters="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%^&*()"; c=$4; letter=substr(letters,c,1);a[$3]=0;for (x in a) {o=a[x];a[x]=a[x]+1; printf "\033[%s;%sH\033[2;32m%s",o,x,letter; printf "\033[%s;%sH\033[1;37m%s\033[0;0H",a[x],x,letter;if (a[x] >= $1) { a[x]=0; } }}'
}

# Default to human readable figures
alias df='df -h'
alias du='du -h'
#
# Misc :)
alias less='less -r'                          # raw control characters
alias whence='type -a'                        # where, of a sort
alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour
#
# Some shortcuts for different directory listings
alias ls='ls -hF --color=tty'                 # classify files in colour
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias ll='ls -l'                              # long list
alias la='ls -A'                              # all but . and ..
alias l='ls -CF'                              #

source C:/Users/Muhammed/AppData/Roaming/dystroy/broot/config/launcher/bash/br

source C:/Users/Muhammed/.dotfiles/bash/workspace_aliases.sh

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
