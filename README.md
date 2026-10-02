# Neovim Configuration

A personal Neovim configuration stored as code with modular plugin setup using lazy.nvim, organized for easy maintenance and extensibility.

## Quick Start

Clone this repository to your Neovim config directory:

```bash
git clone https://github.com/yourusername/nvim-config ~/.config/nvim/
```

Then start Neovim:

```bash
nvim
```

Lazy.nvim will automatically download and install all plugins on first startup.

## Requirements

- **Neovim** (v0.8+): [Install](https://github.com/neovim/neovim/wiki/Installing-Neovim)
- **Git**: Required by lazy.nvim for plugin management
- **Python LSP** (optional): `pyright` for Python support
  ```bash
  pip install pyright
  ```

### Platform Notes

- **macOS**: Use iTerm2 or Alacritty instead of Terminal.app for proper color scheme rendering
- **Linux**: Works out of the box with most terminals
- **Windows**: Requires Windows Terminal or Git Bash

## Documentation

**Quick Start**: Start with [CHEATSHEET.md](./docs/CHEATSHEET.md) for a quick reference!

### Main Guides
- **[CHEATSHEET.md](./docs/CHEATSHEET.md)** — Quick keybinding and command reference
- **[KEYBINDINGS.md](./docs/KEYBINDINGS.md)** — Complete keybinding reference
- **[SETUP.md](./docs/SETUP.md)** — Installation guide for all platforms
- **[PLUGINS.md](./docs/PLUGINS.md)** — All plugins explained with usage examples

### Reference & Help
- **[ARCHITECTURE.md](./docs/ARCHITECTURE.md)** — How the config is organized
- **[TROUBLESHOOTING.md](./docs/TROUBLESHOOTING.md)** — Common issues and fixes
- **[MARKDOWN_VIEWER.md](./docs/MARKDOWN_VIEWER.md)** — How to view docs in Neovim
- **[IMPROVEMENTS.md](./docs/IMPROVEMENTS.md)** — Future enhancement roadmap

## Key Features

- **Plugin Manager**: lazy.nvim for lazy-loading and performance
- **LSP Setup**: lsp-zero with Mason for language server management
- **Code Navigation**: Telescope for fuzzy finding, Harpoon for quick navigation
- **Git Integration**: Fugitive for Git operations
- **Syntax Highlighting**: Treesitter for language-aware highlighting
- **Theme**: Rose Pine colorscheme
- **Diagnostics**: Trouble plugin for organizing LSP diagnostics

## File Structure

```
~/.config/nvim/
├── init.lua                  # Entry point
├── lazy-lock.json           # Plugin lock file
├── README.md                # This file
├── docs/                    # Documentation
│   ├── KEYBINDINGS.md
│   ├── PLUGINS.md
│   ├── ARCHITECTURE.md
│   ├── SETUP.md
│   └── TROUBLESHOOTING.md
└── lua/
    ├── config/
    │   └── lazy.lua         # Lazy.nvim setup
    ├── plugins/             # Plugin configurations
    │   ├── color-scheme.lua
    │   ├── file-finders.lua
    │   ├── fugitive.lua
    │   ├── harpoon.lua
    │   ├── lsp.lua
    │   ├── mason.lua
    │   ├── telescope.lua
    │   ├── treesitter.lua
    │   ├── trouble.lua
    │   └── undotree.lua
    └── eric/
        └── init.lua         # Personal keybindings & settings
```

## Getting Started

1. Clone the repository
2. Install required tools (see [SETUP.md](./docs/SETUP.md))
3. Review [KEYBINDINGS.md](./docs/KEYBINDINGS.md) for keybinding reference
4. Check [PLUGINS.md](./docs/PLUGINS.md) to understand installed plugins
5. Customize `lua/eric/init.lua` with your preferences

## Contributing

This is a personal config, but feel free to fork and customize for your own use.

## License

Personal use - feel free to use as a template for your own Neovim setup.
