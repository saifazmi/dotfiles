# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/saif/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="classyTouch"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

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

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# OVERALL CONDITIONALS {{{
  _isxrunning=false
  [[ -n "$DISPLAY" ]] && _isxrunning=true

  _isroot=false
  [[ $UID -eq 0 ]] && _isroot=true
# }}}

# EDITOR {{{
  if which vim &>/dev/null; then
    export EDITOR="vim"
  else
    export EDITOR="nano"
  fi
#}}}

# COLORED MANUAL PAGES {{{
    # @see http://www.tuxarena.com/?p=508
    # For colourful man pages (CLUG-Wiki style)
    if $_isxrunning; then
      export PAGER=less
      export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
      export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
      export LESS_TERMCAP_me=$'\E[0m'           # end mode
      export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
      export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
      export LESS_TERMCAP_ue=$'\E[0m'           # end underline
      export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline
    fi
#}}}

# MODIFIED COMMANDS {{{
  alias df='df -h'
  alias diff='colordiff' # requires colordiff package
  alias du='du -c -h'
  alias free='free -m' # show sizes in MB
  alias subl='subl3'
  alias gcal='gcalcli --monday calw 1'
  alias xclip='xclip -sel clip'
#}}}

# PRIVILEGED ACCESS {{{
  if ! $_isroot; then
    alias sudo='sudo '
    alias scat='sudo cat'
    alias svim='sudo vim'
    alias root='sudo su'
  fi
#}}} 

# CUSTOM FUNCTIONS {{{

  # TOP 10 COMMANDS {{{
    # copyright 2007 - 2010 Christopher Bratusek
    top10() { history | awk '{a[$2]++ } END{for(i in a){print a[i] " " i}}' | sort -rn | head; }
  #}}}

  # UP {{{
    # Goes up many dirs as the number passed as argument, if none goes up by 1 by default
    up() {
      local d=""
      limit=$1
      for ((i=1 ; i <= limit ; i++)); do
        d=$d/..
      done
      d=$(echo $d | sed 's/^\///')
      if [[ -z "$d" ]]; then
        d=..
      fi
      cd $d
    }
  #}}}

  # REMIND ME, ITS IMPORTANT! {{{
    # usage: remindme <time> <text>
    # e.g.: remindme 10m "omg, the pizza"
    # need a different pop-up display other than "zenity"
    remindme() { sleep $1 && zenity --info --text "$2" & }
  #}}}

  # SIMPLE CALCULATOR {{{
    # usage: calc <equation>
    calc() {
      if which bc &>/dev/null; then
        echo "scale=3; $*" | bc -l
      else
        awk "BEGIN { print $* }"
      fi
    }
  #}}}

  # FILE & STRINGS RELATED FUNCTIONS {{{

    ## FIND A FILE WITH A PATTERN IN NAME {{{
      ff() { find . -type f -iname '*'$*'*' -ls ; }
    #}}}
    
    ## FIND A FILE WITH PATTERN $1 IN NAME AND EXECUTE $2 ON IT {{{
      fe() { find . -type f -iname '*'$1'*' -exec "${2:-file}" {} \;  ; }
    #}}}
    
    ## MOVE FILENAMES TO LOWERCASE {{{
      lowercase() {
        for file ; do
          filename=${file##*/}
          case "$filename" in
          */* ) dirname==${file%/*} ;;
            * ) dirname=.;;
          esac
          nf=$(echo $filename | tr A-Z a-z)
          newname="${dirname}/${nf}"
          if [[ "$nf" != "$filename" ]]; then
            mv "$file" "$newname"
            echo "lowercase: $file --> $newname"
          else
            echo "lowercase: $file not changed."
          fi
        done
      }
    #}}}

    ## MOVE FILENAMES TO UPPERCASE {{{
      uppercase() {
        for file ; do
          filename=${file##*/}
          case "$filename" in
          */* ) dirname==${file%/*} ;;
            * ) dirname=.;;
          esac
          nf=$(echo $filename | tr a-z A-Z)
          newname="${dirname}/${nf}"
          if [[ "$nf" != "$filename" ]]; then
            mv "$file" "$newname"
            echo "uppercase: $file --> $newname"
          else
            echo "uppercase: $file not changed."
          fi
        done
      }
    #}}}
    
    ## SWAP 2 FILENAMES AROUND, IF THEY EXIST {{{
      #(from Uzi's bashrc).
      swap() {
        local TMPFILE=tmp.$$

        [[ $# -ne 2 ]] && echo "swap: 2 arguments needed" && return 1
        [[ ! -e $1 ]] && echo "swap: $1 does not exist" && return 1
        [[ ! -e $2 ]] && echo "swap: $2 does not exist" && return 1

        mv "$1" $TMPFILE
        mv "$2" "$1"
        mv $TMPFILE "$2"
      }
    #}}}
    
    ## FIND AND REMOVE EMPTY DIRECTORIES {{{
      fared() {
        read -p "Delete all empty folders recursively [y/N]: " OPT
        [[ $OPT == y ]] && find . -type d -empty -exec rm -fr {} \; &> /dev/null
      }
    #}}}
    
    ## FIND AND REMOVE ALL DOTFILES {{{
      farad() {
        read -p "Delete all dotfiles recursively [y/N]: " OPT
        [[ $OPT == y ]] && find . -name '.*' -type f -exec rm -rf {} \;
      }
    #}}}
  #}}}
  
  # ENTER AND LIST DIRECTORY {{{
    function cd() { builtin cd -- "$@" && { [ "$PS1" = "" ] || ls -hrt --color; }; }
  #}}}
  
  # SYSTEMD SUPPORT {{{
    if which systemctl &>/dev/null; then
      start() {
        sudo systemctl start $1.service
      }
      restart() {
        sudo systemctl restart $1.service
      }
      stop() {
        sudo systemctl stop $1.service
      }
      enable() {
        sudo systemctl enable $1.service
      }
      status() {
        sudo systemctl status $1.service
      }
      disable() {
        sudo systemctl disable $1.service
      }
    fi
  #}}}

  # GITIGNORE GENERATOR {{{
    function gi() { curl -L -s https://www.gitignore.io/api/$@ ; }
  #}}}
#}}}

# NEOFETCH {{{
  neofetch --gtk2 off --gtk3 off --gpu_type integrated --os_arch off --disable packages
#}}}

# Add GPG key to zsh profile
export GPG_TTY=$(tty)
