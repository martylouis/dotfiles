#!/usr/bin/env zsh

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

# Homebrew ##
# Add Homebrew sbin to $PATH
export PATH="/usr/local/sbin:$PATH"

# Install GNU core utilities (those that come with macOS are outdated)
# $(brew --prefix coreutils)/libexec/gnubin` to `$PATH`
# export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

# z - /usr/local/Cellar/z/
# source /usr/local/etc/profile.d/z.sh
source $(brew --prefix)/etc/profile.d/z.sh

# PHP, composer and mysql
# export PATH="/usr/local/opt/php@7.4/bin:$PATH"
# export PATH="/usr/local/opt/php@7.4/sbin:$PATH"

# export PATH="$PATH:$HOME/.composer/vendor/bin"

# export PATH="${PATH}:/usr/local/opt/mysql@5.7/bin"

## DBngin config
# export PATH="$PATH:/Users/Shared/DBngin/mysql/5.7.23/bin"
# export MYSQL_UNIX_PORT=/tmp/mysql_3306.sock


## Node ##
# n - node version control
export N_PREFIX="$HOME/.n"
export PATH="$N_PREFIX/bin:$PATH"

## NVM ##
# export NVM_DIR=~/.nvm
# source $(brew --prefix nvm)/nvm.sh

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

## Add local gems to $PATH
# export PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"

# zsh-autosuggestions config
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"
# ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50

## 1Password SSH config ##
# Set the `SSH_AUTH_SOCK` environment variable
# https://developer.1password.com/docs/ssh/get-started
export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

# Set the `VOLTA_HOME` environment variable
export VOLTA_HOME=$HOME/.volta
# Add Volta’s bin directory to the path
export PATH=$VOLTA_HOME/bin:$PATH

# Add custom bin path
export PATH="$HOME/Code/bin:$PATH"