alias ll='ls -al'
alias cdweb='cd /var/www/html'
alias sf='php app/console'

export PATH=/home/docker/git-friendly:$PATH

# History
HISTSIZE=1000000
HISTFILESIZE=1000000
HISTCONTROL=ignoredups:erasedups
shopt -s histappend