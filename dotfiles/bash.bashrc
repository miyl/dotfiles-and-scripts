#
# /etc/bash.bashrc
#
# More human friendly color names:
# Reset
Color_Off='\e[0m'       # Text Reset

# Regular Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Underline
UBlack='\e[4;30m'       # Black
URed='\e[4;31m'         # Red
UGreen='\e[4;32m'       # Green
UYellow='\e[4;33m'      # Yellow
UBlue='\e[4;34m'        # Blue
UPurple='\e[4;35m'      # Purple
UCyan='\e[4;36m'        # Cyan
UWhite='\e[4;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

# High Intensity
IBlack='\e[0;90m'       # Black
IRed='\e[0;91m'         # Red
IGreen='\e[0;92m'       # Green
IYellow='\e[0;93m'      # Yellow
IBlue='\e[0;94m'        # Blue
IPurple='\e[0;95m'      # Purple
ICyan='\e[0;96m'        # Cyan
IWhite='\e[0;97m'       # White

# Bold High Intensity
BIBlack='\e[1;90m'      # Black
BIRed='\e[1;91m'        # Red
BIGreen='\e[1;92m'      # Green
BIYellow='\e[1;93m'     # Yellow
BIBlue='\e[1;94m'       # Blue
BIPurple='\e[1;95m'     # Purple
BICyan='\e[1;96m'       # Cyan
BIWhite='\e[1;97m'      # White

# High Ijntensity backgrounds
On_IBlack='\e[0;100m'   # Black
On_IRed='\e[0;101m'     # Red
On_IGreen='\e[0;102m'   # Green
On_IYellow='\e[0;103m'  # Yellow
On_IBlue='\e[0;104m'    # Blue
On_IPurple='\e[0;105m'  # Purple
On_ICyan='\e[0;106m'    # Cyan
On_IWhite='\e[0;107m'   # White

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

umask 037

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#PS1='[\u@\h \W]$ '
#PS1='\u@\h \W '
#PS1="\n\[$IYellow\]\u@\h \[$Yellow\]\W \[$White\]"
PS1="\n\[$IYellow\]\u@\h | \W \[$White\]"
PS2='> '
PS3='> '
PS4='+ '

case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'

    ;;
  screen)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
    ;;
esac

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion



# Lys:

# I'd prefer starting X via inittab, but until I get that to work this should:
# id returns the user id of the user. 0 is root.
if [[ -z $DISPLAY && ! -a /tmp/.X11-unix/X0 && $(id -u) != 0 ]]; then
  exec startx
fi

# - Aliases:
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
alias pdf='zathura' # could also be mupdf or epdfview
alias lynx='lynx -cfg=~/.config/lynx.cfg -vikeys'
alias irfanview='wine /media/data/Portable/Irfanview/i_view32.exe'
alias urxvt='urxvtc'
alias mount='mount -o uid=lys'
alias smx='sudo mount -o uid=lys /dev/sdb1 /mnt/x'
alias smxc='sudo mount -o uid=lys /dev/sdb1 /mnt/x && cd /mnt/x'
alias rn='restart network'
alias mosml='rlwrap mosml -P full'
alias v='vim'
alias ka='sudo killall'
alias dhcpcd='sudo dhcpcd'

# - - Django:
alias runserver='python manage.py runserver'
alias syncdb='python manage.py syncdb'

# Make ls's default output coloured and group directories first in listnings:
# Symlinked directories, however, are unfortunately not.
alias ls='ls --color --group-directories-first' 

# Make find case insensitive by default.
#alias find='find -iname'

# Make grep case insensitive by default.
alias grep='grep -i --color=always'

# - Envs: 
# $PATH means first take the current content of PATH then append the following.
export PATH+=:/home/lys/bin
#export dja='cd /media/data/Video/Egne/www/Django/'
export www=/media/data/Video/Egne/www/
export dja=/media/data/Video/Egne/www/django/
export aud=/media/data/Audio/
export vid=/media/data/Video/
export doc=/media/data/Diverse/Dokumenter/
export lnx=/media/data/Diverse/Dokumenter/Computer/Linux/
export xin=/etc/X11/xinit/
export dwm=/home/lys/bin/inst/dwm/dwm/
export min=/media/data/Diverse/Spil/Minecraft/Survival/

# Setting the EDITOR env to vim for Yaourts sake when compiling & editing makempkgs.
export EDITOR=vim

case "$TERM" in
    rxvt-256color)
    TERM=rxvt-unicode
    ;;
esac

# Autocompletion when typing sudo x or man x.
complete -cf sudo
complete -cf man

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

# Autojump:
[[ -s /etc/profile.d/autojump.sh ]] && . /etc/profile.d/autojump.sh
#alias j="autojump"

# Tilføjet pga. KU OSM:
export PATH="$HOME/yams/bin:$PATH"

# Functions

# Create archive
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

function sim()
{
    sudoedit "$*"
}

# extract specific pages from a PDF using ghostscript, which is included by default in many distributions of linux, and probably freebsd and OS X.
function pdfpextr()
{
    # this function uses 3 arguments:
    #     $1 is the first page of the range to extract
    #     $2 is the last page of the range to extract
    #     $3 is the input file
    #     output file will be named "inputfile_pXX-pYY.pdf"
    gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER \
       -dFirstPage=${1} \
       -dLastPage=${2} \
       -sOutputFile=${3%.pdf}_p${1}-p${2}.pdf \
       ${3}
}
