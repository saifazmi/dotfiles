# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

# Create Zinit directory if it doesn't exist
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
# Download Zinit in case it's not already installed
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

##### Zsh plugins #####
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Plugin snippets
zinit snippet OMZP::gitignore
zinit snippet OMZP::uv

autoload -Uz compinit && compinit

zinit cdreplay -q

##### Keybindings #####
bindkey -e # Use Emacs keybindings
bindkey '^p' history-search-backward # prefix matched search
bindkey '^n' history-search-forward

##### History settings #####
HISTSIZE=10000 # Number of commands to remember in the command history
HISTFILE=~/.zsh_history # File to save command history
SAVEHIST=$HISTSIZE
HISTDUP=erase # Remove duplicates from history

setopt appendhistory # Append to histroy file
setopt sharehistory # Share history between sessions
setopt hist_ignore_space # Ignore commands that start with a space, good for sensitive info
setopt hist_ignore_all_dups
setopt hist_save_no_dups # Ignore duplicate commands from being saved in history
setopt hist_ignore_dups
setopt hist_find_no_dups # Do not display duplicates when searching history

##### Completion settings #####
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # Case insensitive completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # Use LS_COLORS for completion colors
zstyle ':completion:*' menu no # Disable default completion menu
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath' # Enable fzf preview window in fzf-tab
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

##### Aliases #####
alias ls='ls --color'

alias zshconfig="nvim ~/.zshrc"
alias tmuxconfig="cd ~/.config/tmux && nvim tmux.conf"
alias vimconfig="vim ~/.config/vim/vimrc"
alias nvimconfig="cd ~/.config/nvim && nvim ."

##### Shell integrations #####
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)" # zoxide powered cd

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

##### Tool configurations #####
# GPG signing in git commits
export GPG_TTY=$TTY

# Fuck command alias
eval $(thefuck --alias)

# ngrok completion
if command -v ngrok &>/dev/null; then
  eval "$(ngrok completion)"
fi

##### Language settings #####

# Ruby
eval "$(rbenv init - zsh)"

# Javascript/Node.js
## nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# place this after nvm initialization!
autoload -U add-zsh-hook

load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
        nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
        nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

## pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

## bun completions
[ -s "/Users/saifazmi/.bun/_bun" ] && source "/Users/saifazmi/.bun/_bun"

## bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Java
## PATH and JAVA_HOME setup
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export JAVA_HOME="/opt/homebrew/opt/openjdk"

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config ${XDG_CONFIG_HOME:-$HOME/.config}/ohmyposh/config.toml)"
fi

