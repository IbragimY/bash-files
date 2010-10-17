#!/bin/bash

# if $PS1 is empty then we do not running  interactively. Exit
[ -z "$PS1" ] && return

HISTCONTROL=ignoreboth

# shopt -- shell built-in command
#    -s -- set optional shell behavior

# append to history file do not overwrite it
shopt -s histappend

# check windows size after each command and change LINES and COLUMNS if ncessary
shopt -s checkwinsize


function parse_git_branch {
   ref=$(git symbolic-ref HEAD 2> /dev/null) || return
       echo " (git:"${ref#refs/heads/}")"
}

bash_prompt() {
	case "$TERM" in
	   xterm-color)
		local color_prompt=yes
		 ;;
	esac

	# \e -- escape
	# \e[0;XXm or \e[XXm	-- normal
	# \e[1;XXm 		-- bold
	# \e[4;XXm		-- underline

	local CL_RESET='\e[00m' 	# text reset
	local CL_GREEN='\e[0;32m'	# green
	local CL_BLUE='\e[0;35m'	# blue
	local CL_YELLOW='\e[0;33m'	# yellow

	if [ "$color_prompt" = yes ]; then
	   PS1=$CL_BLUE'\u@\h:'$CL_GREEN'\W'$CL_RESET$CL_YELLOW'$(parse_git_branch)'$CL_RESET' \$ '
	fi
}

bash_prompt

alias ls='ls -G'
alias grep='grep --color=auto'

alias ll='ls -l'
alias la='ls -A'
alias lla='ls -Al'
alias l='ls -CF'

alias s='git status'
alias d='git diff'
alias b='git branch'

alias gitstatus='find . -type d -name ".git" |while read i; do print $i; done'
