# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

#PS1
PS1='\[\033[01;32m\]\u\[\033[1;30m\]@\[\033[1;31m\]\H\[\033[01;34m\] \w\[\033[31m\]$(__git_ps1 " (%s)")\[\033[01;34m\]$\[\033[00m\] '

export EDITOR="vim"

if [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
fi

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

#FUNCTIONS
function send_changes { git log -n $1 --oneline --stat --no-merges | mail -s "$2" contacto@javaguirre.net; }
function git_count { git log --numstat --pretty="%H" --author="$1" | awk 'NF==3 {plus+=$1; minus+=$2} END {printf("+%d, -%d\n", plus, minus)}'; }
#function replace_class_names { for filename in *$1*; do echo mv \"$filename\" \"${filename//$1/$2}\"; done | /bin/bash }

# added by duckpan installer
eval $(perl -I/home/javaguirre/perl5/lib/perl5 -Mlocal::lib)

# for tmux: export 256color
[ -n "$TMUX" ] && export TERM=screen-256color

#LANG=C pulseaudio -vvvv --log-time=1 > ~/pulseverbose.log 2>&1
