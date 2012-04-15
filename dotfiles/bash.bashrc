# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
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

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

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
#alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Lys:

# - Aliases:
alias grep="grep --color=always"
alias ll='ls -lh'
alias la='ls -Ah'
alias t='/home/lys/sh/todo/todo.sh -d /home/lys/sh/todo/todo.cfg'
alias tp='/home/lys/sh/todo/todo.sh -d /home/lys/sh/todo/tp_personal.cfg'
alias tb='/home/lys/sh/todo/todo.sh -d /home/lys/sh/todo/tb_bz.cfg'
alias tl='/home/lys/sh/todo/todo.sh -d /home/lys/sh/todo/tl_longterm.cfg'
alias tpc='/home/lys/sh/todo/todo.sh -d /home/lys/sh/todo/tpc_computer.cfg'
alias ..='cd ..'
alias ,,='cd "$OLDPWD"'
alias ...='cd ../..'
alias start='sudo /usr/sbin/rc.d start'
alias stop='sudo /usr/sbin/rc.d stop'
alias restart='sudo /usr/sbin/rc.d restart'
alias pdf='apvlv' # could also be mupdf or epdfview
alias lynx='lynx -cfg=~/.config/lynx.cfg -vikeys'
alias irfanview='wine /media/data/Portable/Irfanview/i_view32.exe'
alias urxvt='urxvtc'

# - - Django:
alias runserver='python2.7 manage.py runserver'
alias syncdb='python2.7 manage.py syncdb'

# Make ls's default output coloured and group directories first in listnings:
# Symlinked directories, however, are unfortunately not.
alias ls='ls --color --group-directories-first' 

# - Envs: 
# $PATH means first take the current content of PATH then append the following.
export PATH=$PATH:/home/lys/bin
#export dja='cd /media/data/Video/Egne/www/Django/'
export dja=/media/data/Video/Egne/www/Django
export aud=/media/data/Audio
export vid=/media/data/Video
export doc=/media/data/Diverse/Dokumenter
export lnx=/media/data/Diverse/Dokumenter/Computer/Linux
export xin=/etc/X11/xinit
export dwm=/home/lys/bin/inst/dwm
export min=/media/data/Diverse/Spil/Minecraft/Survival

# Setting the LANG env to da_DK:
#export LANG='da_DK.UTF-8'
# Setting the EDITOR env to vim for Yaourts sake when compiling & editing makempkgs.
export EDITOR=vim

case "$TERM" in
    rxvt-256color)
    TERM=rxvt-unicode
    ;;
esac

# I'd prefer starting X via inittab, but until I get that to work this should:
if [[ -z $DISPLAY && ! -a /tmp/.X11-unix/X0 && $(id -u) != 0 ]]; then
  exec startx
fi

# {{{ Pacman & Yaourt
	alias pa="pacman"
	alias pac="sudo pacman"
	alias pasy="sudo pacman -Sy"               # Sync & Update
	alias paup="sudo pacman -Syu"              # Sync, Update & Upgrade
	alias padg="sudo pacman -Syuu"             # Sync, Update & Downgrade
	alias palu="pacman -Qu"                    # List upgradeable
	alias pain="sudo pacman -S"                # Install a specific package
	alias pand="sudo pacman -Sdd"              # Install a package but ignore deps
	alias parm="sudo pacman -Rns"              # Remove a specific package
	alias pard="sudo pacman -Rdd"              # Remove a package but ignore deps
	alias pass="pacman -Ss"                    # Search for a package
	alias pasl="pacman -Qs"                    # Search for a package localy
	alias pasi="pacman -Si"                    # Package info
	alias paqi="pacman -Qi"                    # Package local info
	alias pals="pacman -Ql"                    # List files in a package
	alias paui="pacman -Qm"                    # List localy built packages
	alias pafi="pacman -Qo"                    # Which package file belongs to
	alias pacl="sudo pacman -Scc"              # Fully clean the package cache
	alias padl="sudo pacman -Sw"               # Download a package without installing
	alias palo="pacman -Qdt"                   # List package orphans
	alias palog="pacman -Qc"                   # Package changelog
	alias yass="yaourt -Ss"
	alias yain="yaourt -S"
	alias yaup="yaourt -Syua"
# }}}

# share history across all terminals
shopt -s histappend
PROMPT_COMMAND='history -a'

#Functions

#Create archive
compress () {
    if [ -n "$1" ] ; then
FILE=$1
        case $FILE in
        *.tar) shift && tar cf $FILE $* ;;
        *.tar.bz2) shift && tar cjf $FILE $* ;;
        *.tar.gz) shift && tar czf $FILE $* ;;
        *.tgz) shift && tar czf $FILE $* ;;
        *.zip) shift && zip $FILE $* ;;
        *.rar) shift && rar $FILE $* ;;
        esac
else
echo "usage: compress <archive.tar.gz> <archive> <files>"
    fi
}

#Unpack archive
unpack() {
    if [ -f $1 ] ; then
case $1 in
            *.tar.bz2) tar xjf $1 ;;
            *.tbz2) tar xjf $1 ;;
            *.tar.gz) tar xzf $1 ;;
            *.tgz) tar xzf $1 ;;
            *.bz2) bunzip2 $1 ;;
            *.rar) unrar x $1 ;;
            *.gz) gunzip $1 ;;
            *.tar) tar xf $1 ;;
            *.zip) unzip $1 ;;
            *.Z) uncompress $1 ;;
            *.7z) 7z x $1 ;;
            *) echo -e ${YELLOW}"'$1' cannot be unpacked"${RESET} ;;
        esac
else
echo -e ${YELLOW}"'$1' is an invalid file"${RESET}
    fi
}
