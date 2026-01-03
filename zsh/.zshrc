# ZINIT_SETUP {{{
  # Set the directory we want to store zinit and plugins
  ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

  # Create Zinit directory if it doesn't exist
  [ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
  # Download Zinit in case it's not already installed
  [ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

  # Source/Load zinit
  source "${ZINIT_HOME}/zinit.zsh"
#}}}

# ZSH_PLUGINS {{{
  zinit light zsh-users/zsh-syntax-highlighting
  zinit light zsh-users/zsh-completions
  zinit light zsh-users/zsh-autosuggestions
  zinit light Aloxaf/fzf-tab
#}}}

# OMZ_SNIPPETS {{{
  # Plugin snippets from Oh-My-Zsh
  zinit snippet OMZP::gitignore
  zinit snippet OMZP::uv
#}}}

# COMPLETION_INIT {{{
  autoload -Uz compinit && compinit

  zinit cdreplay -q
#}}}

# KEYBINDINGS {{{
  bindkey -e # Use Emacs keybindings
  bindkey '^p' history-search-backward # prefix matched search
  bindkey '^n' history-search-forward
#}}}

# HISTORY {{{
  HISTSIZE=10000                      # Maximum number of commands to keep in memory
  HISTFILE=~/.zsh_history             # File path where history is saved
  SAVEHIST=$HISTSIZE                  # Maximum number of commands to save to file
  HISTDUP=erase                       # Remove duplicate entries from history list

  setopt appendhistory                # Append to history file instead of overwriting
  setopt sharehistory                 # Share history between all active zsh sessions
  setopt hist_ignore_space            # Don't save commands starting with a space (useful for secrets)
  setopt hist_ignore_all_dups         # Remove older duplicate entries when adding new ones
  setopt hist_save_no_dups            # Don't write duplicate entries to history file
  setopt hist_ignore_dups             # Don't record duplicate consecutive commands
  setopt hist_find_no_dups            # Skip duplicates when searching history with arrow keys
#}}}

# COMPLETION_STYLING {{{
  zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # Case insensitive completion
  zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # Use LS_COLORS for completion colors
  zstyle ':completion:*' menu no # Disable default completion menu
  zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath' # Enable fzf preview window in fzf-tab
  zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
#}}}

# ALIASES {{{
  alias ls='ls --color'

  alias zshconfig="nvim ~/.zshrc"
  alias tmuxconfig="cd ~/.config/tmux && nvim tmux.conf"
  alias vimconfig="vim ~/.config/vim/vimrc"
  alias nvimconfig="cd ~/.config/nvim && nvim ."
#}}}

# SHELL_INTEGRATIONS {{{
  eval "$(fzf --zsh)"
  eval "$(zoxide init --cmd cd zsh)" # zoxide powered cd
#}}}

# EDITOR {{{
  # Preferred editor for local and remote sessions
  if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
  else
    export EDITOR='nvim'
  fi
#}}}

# TOOL_CONFIGURATIONS {{{
  # GPG signing in git commits
  export GPG_TTY=$TTY

  # Fuck command alias
  eval $(thefuck --alias)

  # ngrok completion
  if command -v ngrok &>/dev/null; then
    eval "$(ngrok completion)"
  fi
#}}}

# LANGUAGE_MANAGERS {{{
  ## Ruby {{{
    eval "$(rbenv init - zsh)"
  #}}}

  ## Javascript/Node.js {{{
    # nvm
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

    # pnpm
    export PNPM_HOME="$HOME/Library/pnpm"
    case ":$PATH:" in
      *":$PNPM_HOME:"*) ;;
      *) export PATH="$PNPM_HOME:$PATH" ;;
    esac

    # bun completions
    [ -s "/Users/saifazmi/.bun/_bun" ] && source "/Users/saifazmi/.bun/_bun"

    ## bun
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"
  #}}}

  ## Java {{{
    ## PATH and JAVA_HOME setup
    export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
    export JAVA_HOME="/opt/homebrew/opt/openjdk"
  #}}}
#}}}

# PROMPT {{{
  if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
    eval "$(oh-my-posh init zsh --config ${XDG_CONFIG_HOME:-$HOME/.config}/ohmyposh/config.toml)"
  fi
#}}}
