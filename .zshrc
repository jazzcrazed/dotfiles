# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Homebrew on Mac
eval "$(/opt/homebrew/bin/brew shellenv)"

# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

###############################################################################
# NVM & RVM                                                                   |
# ----------------------------------------------------------------------------/

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

###############################################################################
# ZINIT PLUGIN MANAGER                                                        |
# ----------------------------------------------------------------------------/
#
# Set the directory we want to store zinit and plugins.
ZINIT_HOME="{${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

###############################################################################
# ZINIT PLUGINS                                                               |
# ----------------------------------------------------------------------------/
#
zinit ice depth=1; zinit light romkatv/powerlevel10k # Powerlevel10K
zinit light zsh-users/zsh-syntax-highlighting        # Syntax Highlighting
zinit light zsh-users/zsh-completions                # Auto-Complete
zinit light zsh-users/zsh-autosuggestions            # Auto Suggestions
zinit light Aloxaf/fzf-tab                           # Fuzzy-finding tab

# OMZ snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

###############################################################################
# INITIALIZATIONS                                                             |
# ----------------------------------------------------------------------------/
#
# Powerlevel10K
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
#
# Completions
autoload -U compinit && compinit
zinit cdreplay -q
#
# Keybindings
bindkey -e # Emacs
bindkey "^p" history-search-backward
bindkey "^n" history-search-forward
#
# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"  # case insensitive
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}" # ls command color highlighting
zstyle ":completion:*" menu no                          # disable default completion menu
zstyle ":fzf-tab:complete:cd:*" fzf-preview "ls --color $realpath"
zstyle ":fzf-tab:complete__zoxide_z:*" fzf-preview "ls --color $realpath"

###############################################################################
# ALIASES                                                                     |
# ----------------------------------------------------------------------------/
#
alias ls="ls --color"
alias vim="nvim"
alias vi="nvim"
alias c="clear"
#
# Wezterm aliases
alias sph="wezterm cli split-pane --horizontal"
alias spv="wezterm cli split-pane --vertical"

apd () {
  wezterm cli activate-pane-direction $1
}

###############################################################################
# SHELL INTEGRATION                                                           |
# ----------------------------------------------------------------------------/
#
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
