# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(4) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi


export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto verbose"

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$$(__git_ps1 " [%s]")fff '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$$(__git_ps1 " [%s]") '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ls='ls -l --color=auto'
alias grep='grep --color'
alias comp='gcc -Wall -pedantic -lm'
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi




PROMPT_COMMAND="source $HOME/.prompt.sh"
function vytvor()
{
  if [ -e "$1" ]
  then
    echo "Soubor $1 jiz existuje."
  else
    touch "$1"
    echo -en "#!/bin/bash\n\n\n" > "$1"
    chmod u+x "$1"
    gvim "$1"
  fi
}
function cecko()
{
  if [ $(echo "$1" | grep "..*\.c$") ]
  then
    soub="$1"
  else
    soub="$1.c"
  fi
  if [ -e "$soub" ]
  then
    echo "Soubor jiz existuje."
  else
    touch "$soub"
    echo -en "#include <stdio.h>\n#include <stdlib.h>\n\nint main ( void )\n{\n  \n  \n  return 0;\n}" > "$soub"
    gedit "$soub"
  fi
}
function spoj ()
{
  if [ ! $# -eq 1 ]
  then
   ssh "stuchvoj@webdev.fit.cvut.cz"
  else
    ssh "stuchvoj@$1.fit.cvut.cz"
  fi
}

function cpp()
{
  if [ $(echo "$1" | grep "..*\.cpp$") ]
  then
    soub="$1"
  else
    soub="$1.cpp"
  fi
  if [ -e "$soub" ]
  then
    echo "Soubor jiz existuje."
  else
    touch "$soub"
    echo -en "#include <iostream>\n\nusing namespace std;\n\nint main ( int argv, char * argc[] )\n{\n  \n  \n  return 0;\n}" > "$soub"
    gedit "$soub"
  fi
}

function cpph()
{
  if [ $(echo "$1" | grep "..*\.h$") ]
  then
    soub="$1"
  else
    soub="$1.h"
  fi
  if [ -e "$soub" ]
  then
    echo "Soubor jiz existuje."
  else
    touch "$soub"
    echo -en "#ifndef $(echo $1)_H\n#define $(echo $1)_H\n#include <iostream>\nusing namespace std;\n\n\n\n#endif /*$(echo $1)_H*/" > "$soub"
    gedit "$soub"
  fi
}

function ccomp
{
  a="g++ -Wall -pedantic -std=c++11 "
  for i in $@
  do
    a="$a $i"
  done
  $a
}
function hhtml()
{
  if [ ! $# -eq 1 ]
  then
    echo "Spatny pocet argumentu (1)."
  elif [ ! -e "$1" ]
  then
    echo "Soubor $1 jiz existuje."
  else
    touch "$1"
    echo -e "<\!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />\n<script src=\"http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js\" type=\"text/javascript\"></script>\n<title>Untittled Document</title>\n</head>\n<body>\n\n</body>\n</html>" > "$1"
    gvim "$1"
  fi
}


function wedos(){
	ftp 79175.w75.wedos.net
}

cd ~
