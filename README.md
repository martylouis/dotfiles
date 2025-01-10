# Dotfiles

My personal dotfiles configuration. These files manage my shell environment, plugins, and settings.

## Features

- Zsh configuration with useful plugins:
  - zsh-autosuggestions: Fish-like autosuggestions for command line
  - zsh-autocomplete: Advanced tab completion
- Other helpful shell utilities and settings

## Installation

1. Clone this repository to your home directory:

```bash
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
```

2. Create symlinks to the configuration files:

```bash
ln -s ~/.dotfiles/zsh ~/.zsh
```

3. Source the configuration in your `.zshrc`:

```bash
source ~/.dotfiles/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
```

## Plugin Details

### zsh-autosuggestions

Fish-like autosuggestions for Zsh. As you type commands, you'll see a suggestion for the command based on your history.

- Press → or End to accept the suggestion
- Press → to accept the next word of the suggestion
- Configure colors and settings through ZSH_AUTOSUGGEST variables

### zsh-autocomplete

Advanced tab completion system with the following features:

- Real-time asynchronous completions
- History search integration
- Menu selection mode
- Configurable appearance and behavior

## Customization

You can customize the behavior and appearance of plugins by setting variables in your `.zshrc`. For example:

```bash
# Change the suggestion color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# Configure autocomplete behavior
zstyle ':autocomplete:*' min-input 1
```

## License

This collection of dotfiles is released under the MIT License. Individual plugins and tools maintain their own licenses.

## Contributing

Feel free to submit issues and pull requests for improvements or bug fixes.
