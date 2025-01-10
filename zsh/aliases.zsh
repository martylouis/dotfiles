#!/usr/bin/env zsh

# Use trash instead of rm
alias rm='trash'

# Git
alias g="git"

# Git Tower
alias tower='gittower .'
alias gt='gittower .'

# GitHub cli
alias gho="gh repo view --web"
alias ghi="gh issue create"

# Path Shortcuts
alias db="cd ~/Library/CloudStorage/Dropbox"
alias dl="cd '/Users/marty/Library/Mobile Documents/com~apple~CloudDocs/Downloads'"
alias dt="cd ~/Desktop"
alias dot="cd ~/.dotfiles"


# Always enable colored `grep` output
# Note: `GREP_OPTIONS="--color=auto"` is deprecated, hence the alias usage.
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Get all macOS Software Updates
# Update macOS software
alias update-macos='sudo softwareupdate -i -a'

# Update homebrew and its packages
alias update-brew='brew update && brew upgrade && brew cleanup'

# Update global package managers
alias update-packages='npm update -g npm && \
  pnpm install -g pnpm && pnpm update -g pnpm && \
  bun upgrade'

# Update everything
alias update-sys='echo "🔄 Updating system..." && \
  update-macos && \
  echo "🍺 Updating Homebrew..." && \
  update-brew && \
  echo "📦 Updating package managers..." && \
  update-packages && \
  echo "✨ All updates complete!"'

# Google Chrome
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
# alias canary='/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary'

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Show active network interfaces
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# Flush Directory Service cache
alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"

# Clean up LaunchServices to remove duplicates in the “Open With” menu
alias cleanupls="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Canonical hex dump; some systems have this symlinked
command -v hd > /dev/null || alias hd="hexdump -C"

# macOS has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"

# macOS has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"

# Trim new lines and copy to clipboard
alias c="tr -d '\n' | pbcopy"

# Recursively delete `.DS_Store` files
alias cleanupds="find . -type f -name '*.DS_Store' -ls -delete"

# Empty the Trash on all mounted volumes and the main HDD.
# Also, clear Apple’s System Logs to improve shell startup speed.
# Finally, clear download history from quarantine. https://mths.be/bum
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# Show/hide hidden files in Finder
alias showhiddenfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hidehiddenfiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Hide/show all desktop icons (useful when presenting)
alias hidedt="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdt="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"

# Print each PATH entry on a separate line
# alias path='echo -e ${PATH//:/\\n}'
alias path='echo $PATH | tr -s ":" "\n"'

# Yarn
alias y='yarn'
alias ya='yarn add'
alias yd='yarn dev'
alias yb='yarn build'
alias ys='yarn start'
alias yr='yarn remove'
alias yad='yarn add -D'

# NPM
alias npml='npm list --depth=0 2>/dev/null'
alias npmlg='npm list -g --depth=0 2>/dev/null'

alias npmu='npm uninstall'
alias nr='npm run'
alias nrd='npm run dev'
alias nrb='npm run build'
alias nrs='npm start'

# PNPM

alias pni='pnpm i'
alias pnid='pnpm i -D'
alias pnd='pnpm dev'
alias pnb='pnpm build'
alias pns='pnpm start'
alias pnr='pnpm run'
alias pnu='pnpm uninstall'
alias pnx='pnpm dlx'

# Bun
alias bi='bun install'
alias bid='bun install -D'
alias br='bun run'
alias bu='bun update'
alias brm='bun remove'
alias bx='bunx'
alias brd='bun run dev'
alias brb='bun run build'
alias brs='bun run start'

# add-gitignore https://www.npmjs.com/package/add-gitignore
alias gignore='add-gitignore'

# gitmoji-cli https://github.com/carloscuesta/gitmoji-cli
alias gmoji='gitmoji'

# Clipboard-cli
alias cb='clipboard'

# bat > cat » https://github.com/sharkdp/bat
alias cat='bat'

# prettyping > ping » http://denilson.sa.nom.br/prettyping/
alias ping='prettyping --nolegend'

# install custom linting
alias install-eslint='install-peerdeps -d -Y @martylouis/eslint-config'
alias install-stylelint='install-peerdeps -d -Y @martylouis/stylelint-config'

# Netlify cli
alias net='netlify'

# ls, the common ones I use a lot shortened for rapid fire usage
alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias ll='ls -l'      #long list
alias ldot='ls -ld .*'
alias lS='ls -1FSsh'
alias lart='ls -1Fcart'
alias lrt='ls -1Fcrt'

# composer
alias cmp='composer'
alias cmpu='composer update' # update package
alias cmpr='composer require' # install package
alias cmpi='composer install'
alias cmpd='composer dump-autoload'
alias cmpda='composer dump-autoload -o'
alias cmpc='composer clear-cache'
alias cmps='composer self-update'
