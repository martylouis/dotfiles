#!/usr/bin/env zsh

# Create a new directory and enter it
function mkd() {
	mkdir -p "$@" && cd "$_";
}

# Determine size of a file or total size of a directory
function fs() {
	if du -b /dev/null > /dev/null 2>&1; then
		local arg=-sbh;
	else
		local arg=-sh;
	fi
	if [[ -n "$@" ]]; then
		du $arg -- "$@";
	else
		du $arg .[^.]* ./*;
	fi;
}

# Run `dig` and display the most useful info
function digga() {
	dig +nocmd "$1" any +multiline +noall +answer;
}

# Show all the names (CNs and SANs) listed in the SSL certificate
# for a given domain
function getcertnames() {
	if [ -z "${1}" ]; then
		echo "ERROR: No domain specified.";
		return 1;
	fi;

	local domain="${1}";
	echo "Testing ${domain}…";
	echo ""; # newline

	local tmp=$(echo -e "GET / HTTP/1.0\nEOT" \
		| openssl s_client -connect "${domain}:443" -servername "${domain}" 2>&1);

	if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]; then
		local certText=$(echo "${tmp}" \
			| openssl x509 -text -certopt "no_aux, no_header, no_issuer, no_pubkey, \
			no_serial, no_sigdump, no_signame, no_validity, no_version");
		echo "Common Name:";
		echo ""; # newline
		echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//" | sed -e "s/\/emailAddress=.*//";
		echo ""; # newline
		echo "Subject Alternative Name(s):";
		echo ""; # newline
		echo "${certText}" | grep -A 1 "Subject Alternative Name:" \
			| sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\n" | tail -n +2;
		return 0;
	else
		echo "ERROR: Certificate not found.";
		return 1;
	fi;
}

# `vs` with no arguments opens the current directory in VS Code, otherwise
# opens the given location
function vs() {
	if [ $# -eq 0 ]; then
		code .;
	else
		code "$@";
	fi;
}

# `vsi` with no arguments opens the current directory in VS Code Insiders, otherwise
# opens the given location
function vsi() {
    if [ $# -eq 0 ]; then
        code-insiders .;
    else
        code-insiders "$@";
    fi;
}

function vsr() {
	code $(git rev-parse --show-toplevel);
}

# `cs` with no arguments opens the current directory in Cursor, otherwise
# opens the given location
function cs() {
	if [ $# -eq 0 ]; then
		cursor .;
	else
		cursor "$@";
	fi;
}

# `o` with no arguments opens the current directory, otherwise opens the given
# location
function o() {
	if [ $# -eq 0 ]; then
		open .;
	else
		open "$@";
	fi;
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
	tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

# Recursively create .gitkeep files
# @http://cavaliercoder.com/blog/recursively-create-gitkeep-files.html
function addgitkeep() {
  find . -type d -empty -not -path "./.git/*" -exec touch {}/.gitkeep \;
}

# List all images on a website
function list_images {
    # Make sure a URL has been provided
    if [ -z "$1" ]; then
        echo "Usage: list_images <URL> [max_pages]"
        return 1
    fi

    # Define a recursive function to visit each page and extract the image URLs
    function scrape_page {
        local url="$1"
        local domain="$(echo "$url" | sed -E 's/https?:\/\/([^\/]+).*/\1/')"
        local page="$(echo "$url" | sed -E 's/https?:\/\/[^\/]+(.*)/\1/' | tr -d '/')"
        local html="$(echo "$page" | tr '/' '_').html"
        local count="$2"
        local max_pages="$3"

        # Download the HTML source code of the page and display a progress indicator
        curl -s "$url" | pv -s $(curl -s "$url" | wc -c) > "$html"

        # Extract all image URLs from the HTML and write them to the CSV file
        grep -o '<img[^>]*src="[^"]*"' "$html" | grep -o '".*"' | sed 's/"//g' | awk '{print $1}' | sed 's/^/"/;s/$/"/' >> images.csv

        # Extract all links from the HTML and recursively scrape each one
        grep -o '<a[^>]*href="[^"]*"' "$html" | grep -o '".*"' | sed 's/"//g' | while read link; do
            if [[ "$link" == /* ]]; then
                scrape_page "https://$domain$link" "$count" "$max_pages"
            elif [[ "$link" == http*"$domain"* ]]; then
                scrape_page "$link" "$count" "$max_pages"
            elif [[ "$link" == http* ]]; then
                :
            else
                scrape_page "https://$domain/$link" "$count" "$max_pages"
            fi

            # Increment the counter and exit the function if the maximum number of pages have been scraped
            count=$(( count + 1 ))
            if [ "$max_pages" -gt 0 ] && [ "$count" -eq "$max_pages" ]; then
                exit
            fi
        done

        # Remove the temporary HTML file
        rm "$html"
    }

    # Create the CSV file and write the header row
    echo "Image URL" > images.csv

    # Scrape the website recursively, starting with the first page
    if [ -z "$2" ]; then
        scrape_page "$1" 0 0
    else
        scrape_page "$1" 0 "$2"
    fi
}

# Cleanup node_modules directories
#
# This function finds all top-level node_modules directories in the current directory
# and asks for confirmation before deleting them. It also calculates the total size
# of all node_modules directories before deletion and the freed space after deletion.
# Usage: cleanup_node_modules
cleanup_node_modules() {
  echo "🔍 Finding top-level node_modules directories..."
  echo "----------------------------------------"

  # Initialize counter
  count=0

  # Find and store directories while showing them
  # -prune prevents recursion into found node_modules directories
  while IFS= read -r dir; do
    if [ ! -z "$dir" ]; then
      ((count++))
      echo "📁 Found ($count): $dir"
      dirs_array[$count]="$dir"
    fi
  done < <(find . -type d -name "node_modules" -not -path "*/node_modules/*")

  if [ $count -eq 0 ]; then
    echo "✨ No node_modules directories found."
    return 0
  fi

  echo "----------------------------------------"
  echo "📦 Found total of $count node_modules directories"

  # Calculate total size before deletion (on macOS and Linux)
  if [ "$(uname)" = "Darwin" ] || [ "$(uname)" = "Linux" ]; then
    total_size=0
    echo "📊 Calculating sizes..."
    echo "----------------------------------------"
    for dir in "${dirs_array[@]}"; do
      size=$(du -sh "$dir" | cut -f1)
      echo "💾 $dir: $size"
    done
    echo "----------------------------------------"
  fi

  # Ask for confirmation
  echo "🗑️  Do you want to remove all these directories? (y/N)"
  read -r response

  if [ "$response" = "y" ] || [ "$response" = "Y" ]; then
    echo "🚮 Removing node_modules directories..."
    for dir in "${dirs_array[@]}"; do
      echo "🗑️  Removing: $dir"
      rm -rf "$dir"
    done
    echo "✅ Cleanup complete!"

    # Calculate freed space (on macOS and Linux)
    if [ "$(uname)" = "Darwin" ] || [ "$(uname)" = "Linux" ]; then
      freed_space=$(du -sh .)
      echo "💾 Current directory size: $freed_space"
    fi
  else
    echo "❌ Operation cancelled"
  fi
}


# Run Raycast Git Commit Message command with the diff of the current branch
function gcs() {
    git diff --staged | pbcopy;
    open raycast://ai-commands/git-short-commit-message
}
function gcsa() {
    git add .;
    git diff --staged | pbcopy;
    open raycast://ai-commands/git-short-commit-message
}

function gcm() {
    git diff --staged | pbcopy;
    open raycast://ai-commands/git-conventional-commit-message
}

function gcma() {
    git add .;
    git diff --staged | pbcopy;
    open raycast://ai-commands/git-conventional-commit-message
}


# Search for a term in all YAML files in the CDH meta repository
function fzf_literals() {
    grep -r "$1" --include='*.yml' ~/Code/bethel/cdh-meta/apps | fzf --reverse
}