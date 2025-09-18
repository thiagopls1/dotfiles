# Aliases
alias l='ls -lah'
alias lsa='ls -lah'
alias la='ls -lAh'
alias ll='ls -lh'
alias icat="kitten icat"
alias dvrc=$HOME/scripts/convert_davinci.sh

# Paste fix

pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}

zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# ZSH Plugins & Theme
#ZSH=/usr/share/oh-my-zsh/
ZSH=~"/.oh-my-zsh"
ZSH_THEME="spaceship"
plugins=(git git-auto-fetch)

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
	node
	python
	venv
	dotnet
	rust
	lua
	ruby
	python
  exec_time     # Execution time
  line_sep      # Line break
  # vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

SPACESHIP_USER_SHOW=always
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "

source $ZSH/oh-my-zsh.sh

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust \
    zdharma/fast-syntax-highlighting \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-completions

### End of Zinit's installer chunk

# PATHS

# Bun
BUN_DIR="$HOME/.bun"
if [ -d $BUN_DIR ]; then
	export PATH="$PATH:$BUN_DIR/bin"
fi

# Spicetify
if [ -d "$HOME/.spicetify" ]; then
	export PATH=$PATH:$HOME/.spicetify
fi

# Rust
if [ -d "$HOME/.cargo" ]; then
	export PATH=$PATH:$HOME/.cargo/bin
fi

# Nim
if [ -d "$HOME/.nimble" ]; then
	export PATH=$PATH:$HOME/.nimble/bin
fi

# Dotnet
if [ -d "$HOME/.dotnet" ]; then
	export PATH=$PATH:$HOME/.dotnet/tools
fi

# Android
ANDROID_HOME=$HOME/Android/Sdk
if [ -d $ANDROID_HOME ]; then
	export PATH=$PATH:$ANDROID_HOME/platform-tools
	export PATH=$PATH:$ANDROID_HOME/emulator
fi

# Brew
if [ -d "/home/linuxbrew/.linuxbrew" ]; then
	export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin/brew"
fi

# NVM
export NVM_DIR="$HOME/.nvm"
if [ -d $NVM_DIR ]; then
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

# After config execution
fastfetch
