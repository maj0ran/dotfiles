# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/mci/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="mortalscumbag"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

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
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
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
# source ~/powerlevel10k/powerlevel10k.zsh-theme

export PASSWORD_STORE_DIR=/home/mci/.password-store
export TERM=xterm-256color

alias ls="ls --color"
alias ll="ls -l"
alias vi=nvim
alias vim=nvim
alias -s c=vi
alias -s h=vi
alias -s cpp=vi
alias -s hpp=vi
alias suspend="slock systemctl suspend -i"
alias grep="grep --color"
alias img="kitty +kitten icat"


if [ -d "$HOME/.local/bin" ] ; then
          PATH="$HOME/.local/bin:$PATH"
fi

#############################
#### Pengutronix related ####
#############################

function t() { vim ~/ptx/todo/$1/TODO.$1 }
function s() { vim ~/ptx/timeschedule.mci/$(date +%Y)/kw$(date +%V) }

alias lc=labgrid-client
alias lcp="labgrid-client -p"

function p() {
	cmd="ptxdist "

	case "$1" in
		c) cmd=${cmd}"clean" 		;;
		e) cmd=${cmd}"extract" 		;;
		p) cmd=${cmd}"prepare" 		;;
		co) cmd=${cmd}"compile" 	;;
		i) cmd=${cmd}"install" 		;;
		ti) cmd=${cmd}"targetinstall" 	;;
		d) cmd=${cmd}"drop" 		;;
		*) cmd=${cmd}"$1" 		;;
	esac

	cmd="${cmd} ""${@:2}"
	eval $cmd

}

function prc() {
	cmd="ptxdist drop $1.compile ; ptxdist targetinstall $1"
	eval $cmd
}

alias d2="ssh dude02"

function p-local() {
	ptxdist_path=${HOME}'/devel/src/ptxdist/bin'
	case "$1" in
		on) PATH=$ptxdist_path:$PATH ;;
		off) PATH=${PATH#"$ptxdist_path:"} ;;
	esac
}

function tasktime() {
	ptx_timeschedule_cache
	ptx_calendar_cache
	ptx_tasklist -r review -g $1
}
