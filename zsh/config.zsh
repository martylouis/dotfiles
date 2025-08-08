#!/usr/bin/env zsh

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='code'
fi


# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8';

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';

# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${yellow}";

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X';

# Avoid issues with `gpg` as installed via Homebrew.
# https://stackoverflow.com/a/42265848/96656
export GPG_TTY=$(tty);

# Set local environment variables in ~/.env
if [[ -a $HOME/.env ]]
then
  source $HOME/.env
fi

## Read the .zshenv file if it exists
if [[ -f $HOME/.zshenv ]]; then
  source $HOME/.zshenv
fi

# Homebrew ##
# Add Homebrew sbin to $PATH
export PATH="/usr/local/sbin:$PATH"

# Install GNU core utilities (those that come with macOS are outdated)
# $(brew --prefix coreutils)/libexec/gnubin` to `$PATH`
# export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

# z - /usr/local/Cellar/z/
# source /usr/local/etc/profile.d/z.sh
source $(brew --prefix)/etc/profile.d/z.sh

# Add Composer's global bin to PATH
export PATH="$PATH:$HOME/.composer/vendor/bin"

## DBngin config
export PATH="$PATH:/Users/Shared/DBngin/mysql/8.0.33/bin"
# export MYSQL_UNIX_PORT=/tmp/mysql_3306.sock

## NVM ##
export NVM_DIR="$HOME/.nvm"
source $(brew --prefix nvm)/nvm.sh
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

## 1Password SSH config ##
# Set the `SSH_AUTH_SOCK` environment variable
# https://developer.1password.com/docs/ssh/get-started
export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

# Add custom bin path
export PATH="$HOME/Code/bin:$PATH"

# Cloudinary config (coastal states)
# <API_KEY>:<API_SECRET>@<CLOUD_NAME>
export CLOUDINARY_URL=cloudinary://136438265184379:F5wWzbvZTVXyJRMR8w9HbWx4O_Y@dnr4talib

# Pattern Mac Local Development
# https://git.bethelservice.org/ux/pattern#mac-users---local-development
export NODE_ICU_DATA=/Users/marty/.nvm/versions/node/v20.9.0/bin/full-icu

# Change the suggestion color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# Configure autocomplete behavior
zstyle ':autocomplete:*' min-input 1

# Compilation flags
# export ARCHFLAGS="-arch x86_64"


# pnpm
export PNPM_HOME="/Users/marty/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end


# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "/Users/marty/.bun/_bun" ] && source "/Users/marty/.bun/_bun" # bun completions


# Dotnet 8
# export PATH="/opt/homebrew/opt/dotnet@8/bin:$PATH"

# Fuzzy Finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Custom ZSH lib path
# Update FZF default comment to use git ignore files
export FZF_DEFAULT_COMMAND='git ls-files || find .'
export ZSH_LIB="$ZSH_CUSTOM/lib"


# Herd Config
# Herd injected PHP binary.
export PATH="/Users/marty/Library/Application Support/Herd/bin/":$PATH

# Herd injected PHP 8.2 configuration.
export HERD_PHP_82_INI_SCAN_DIR="/Users/marty/Library/Application Support/Herd/config/php/82/"

# Herd injected PHP 7.4 configuration.
export HERD_PHP_74_INI_SCAN_DIR="/Users/marty/Library/Application Support/Herd/config/php/74/"

# Herd injected PHP 8.4 configuration.
export HERD_PHP_84_INI_SCAN_DIR="/Users/marty/Library/Application Support/Herd/config/php/84/"


# Cursor CLI
export PATH="$HOME/.local/bin:$PATH"

# Added by Windsurf
export PATH="/Users/marty/.codeium/windsurf/bin:$PATH"
