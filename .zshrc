# use vi keybindings
bindkey -v

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

PS1='%m %1d$ '

# User specific aliases and functions
export VIM="/home/ethan/.vim/session"
export PATH=$PATH:$HOME/bin
#export PATH=$PATH:$HOME/arm-2008q3/bin
export HASKELL="/home/ethan/proj/haskell"
export OS="/home/ethan/proj/raspPiOS/os"
export COMPILER="/home/ethan/proj/sparcal"

set -o vi
alias cd-os="cd $OS"
alias cd-compiler="cd $COMPILER"
alias dammit='sudo $(history -p !!)'
alias damnit='sudo $(history -p !!)'
alias edit="vim -c Edit"
alias fuck='sudo $(history -p !!)'
alias git-ls='git diff-tree --no-commit-id --name-only -r'
alias git-clean='git rm -r --cached .'
alias goddammit='sudo $(history -p !!)'
alias goddamnit='sudo $(history -p !!)'
alias kill-apache="ps aux | grep apache | grep -v grep | awk {'print $2'} | xargs -r kill -9"
alias ls-size="ls -s --block-size=G "
alias ls="ls -la --color -s "
alias ssh="ssh -p 22 -o TCPKeepAlive=yes -o ServerAliveInterval=60 "
alias scp="scp -P 22 -v "
alias shit='sudo $(history -p !!)'
alias source-zsh="source ~/.zshrc"

alias disk-space="df -hk"

# vim aliases
alias vim="vim -p "
alias vim-clean="rm -rf .*.swp .*.swo"
alias Proj="vim -c Proj"
alias Edit="vim -c Edit"
alias OS="vim -c OS"
alias Cpp="vim -c Cpp"

function git-diff {
	git diff $1^1 $1
}

function replace {
 	find . -type f | xargs sed --quiet -i "s/$1/$2/gp"
}

function search {
	grep -ri "$1" .
}

function git-view {
	git show $1:$2 | vim -
}

function git-rebase {
	git branch -D rebase-tmp
	git checkout -b rebase-tmp
	git checkout $1
	git reset --hard $2^1
	git checkout rebase-tmp
	git rebase -i $1
}

function git-rebase-continue {
	git checkout $1
	git merge --ff-only rebase-tmp
}


function own {
	sudo chown -R ethan $1
	sudo chmod -R 775 $1
}

function log {
	php $1 >> log.txt
}

function memory-usage {
	for USER in $(ps haux | awk '{print $1}' | sort -u)
	do
	    ps haux | awk -v user=$USER '$1 ~ user { sum += $4} END { print user, sum; }'            
	done

	TOTAL=$(free | awk '/Mem:/ { print $2 }')
	for USER in $(ps haux | awk '{print $1}' | sort -u)
	do
	    ps hux -U $USER | awk -v user=$USER -v total=$TOTAL '{ sum += $6 } END { printf "%s %.2f\n", user, sum / total * 100; }'
	done
}

function deploy-os {
	sudo mount /dev/sdb1 ~/sd
	sudo cp $OS/kernel.img ~/sd/kernel.img
	sudo umount /dev/sdb1
}
