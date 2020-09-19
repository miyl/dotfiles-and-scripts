# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/i/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#

# {{{ MIYALYS:

# Sourcing early so changes here, such as binds, aren't ovewritten by shellcommonrc
# Note: vi mode (inside shellcommonrc) needs to be set BEFORE all the viins binds below, otherwise they're overwritten
source $DOTFILES_DIR/shellcommonrc

source /usr/share/fzf/completion.zsh      # actually enables the FZF_COMPLETION_TRIGGER, whatever it's set to above
source /usr/share/fzf/key-bindings.zsh  # adds keybindings on CTRL-T, CTRL-R and ALT-C. 
 
# An attempt at making ls group dirs before files. Actually I'd prefer that for default dir/file completion!
#zstyle ':completion:*:*:-command-:*:directories' group-name drs
#zstyle ':completion:*:*:-command-:*:files' group-name fls

#zstyle ':completion:*:ls:*' group-order drs fls
 
# Binds
bindkey '[A'           cdParentKey
bindkey '[D'           cdUndoKey
# 2019 new keybinds as the above don't work in termite, though they may in urxvt and thus should perhaps remain
bindkey '^[[1;3D'      cdUndoKey
bindkey '^[[1;3A'      cdParentKey


# This doesn't seem to coexist well with autorun? When swithcing with autojump: 
# chpwd_recent_dirs:34: parse error near `('
#autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
#add-zsh-hook chpwd chpwd_recent_dirs

# More easily go back and forward a word than C-B and C-F - with C-Left and C-Right:
# I think this works regardless unless CTRL is interpreted differently in the terminal, so maybe this was a fix for urxvt?
#bindkey "^[Od" backward-word
#bindkey "^[Oc" forward-word

# Now instead ALT-M cycles between words on the current line - but that line goes one back for each ALT . before it. So ALT . ALT m will retrieve the second last argument in the last command, fx.
autoload -Uz copy-earlier-word
zle -N copy-earlier-word
bindkey "^[m" copy-earlier-word


# Normally you can't backspace over/delete characters not inserted in this run of insert mode, so if you type, go to normal mode and then back to insert, you can't delete those typed characters.
# This changes that, so backspace works like  set backspace=start  in vimrc
#if setopt | grep vi ; then  # Check if vi mode is currently enabled in the terminal
bindkey -M viins '^?' backward-delete-char # vi-backward-delete-char only deletes chars inserted since last entering insert mode. this is annoying. backward-delete-char does not have this behaviour.
bindkey -M viins '^H' backward-delete-char # By default CTRL-H is also bound to vi-backward-delete-char, so might as well fix that too.
bindkey -M viins '^w' backward-delete-word # vi-backward-delete-word only deletes chars/words inserted since last entering insert mode. this is annoying. backward-delete-word does not have this behaviour.

bindkey -M viins '^[.' insert-last-word     # This is default emacs behaviour, but I want it in vi mode too. Found it by running bindkey in the terminal while in emacs mode and looking for the . character bind
##bindkey -M viins "^[^?" backward-kill-word  # Delete word with Alt-backspace like emacs mode. Update: Disabled because CTRL-w works the same and is less finger movement, especially if using Caps lock as ctrl. do that <3
bindkey -M viins "^[i" beginning-of-line    # Instead of Alt-shift a and alt-shift-i to move to the end or the beginning of the line just use Alt-a and alt-i
bindkey -M viins "^[a" end-of-line          # Instead of Alt-shift a and alt-shift-i to move to the end or the beginning of the line just use Alt-a and alt-i
#fi

# cd easily with fzf
# fzf's key-bindings in /usr/share/fzf/key-bindings.zsh binds to ^ec which works for binding to ALT in termite, but not in st. Hence this extra bind for st.
# for some reason binding to alt-c seemingly is not registered by showkey so...
bindkey '^[s' fzf-cd-widget

# Automatic rehashing, so a program appears in path (and can be completed in the shell) immediately after install. Not sure how much of a waste of resources this is, though?
# Could also be a pacman post install hook if such are possible?
# https://wiki.archlinux.org/index.php/Pacman#Hooks
zstyle ':completion:*' rehash true

# {{{ GIT

#ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
#ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
#ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

# Disable git prompt running git status every time I enter a repo to check if I'm synced with it (because it's SLOW):
#http://marc-abramowitz.com/archives/2012/04/10/fix-for-oh-my-zsh-git-svn-prompt-slowness/
function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
}
# }}}
 
# }}}


# {{{ Functions

# Press .. multiple times and it automatically adds / to cd up multiple directories.
rationalise-dot() {
  if [[ $LBUFFER = *.. ]]; then
    LBUFFER+=/..
  else
    LBUFFER+=.
  fi
}
zle -N rationalise-dot
bindkey . rationalise-dot

# Make the help command available in ZSH:
autoload -Uz run-help
autoload -Uz run-help-git
autoload -Uz run-help-svn
autoload -Uz run-help-svk
#unalias run-help # No longer aliased?
alias help=run-help

# Go back in directory history with ALT-Left, and up to the parent dir with ALT-Up
cdUndoKey() {
  popd      > /dev/null
  zle       reset-prompt
  echo
  ls
  echo
}

cdParentKey() {
  pushd .. > /dev/null
  zle      reset-prompt
  echo
  ls
  echo
}

# I think these two make those commands available to bindkey.
zle -N                 cdParentKey
zle -N                 cdUndoKey

# }}}
