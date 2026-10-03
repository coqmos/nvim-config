# Installed Plugins

Overview of each plugin, what it does, and how to use it.

## Plugin Directory

- [Harpoon](#harpoon) — Quick file navigation
- [Telescope](#telescope) — Fuzzy finding
- [LSP Zero](#lsp-zero) — Language Server Protocol setup
- [Mason](#mason) — Language server installer
- [Treesitter](#treesitter) — Syntax highlighting & parsing
- [Trouble](#trouble) — Diagnostics viewer
- [Fugitive](#fugitive) — Git integration
- [Undotree](#undotree) — Undo history visualization
- [Rose Pine](#rose-pine) — Colorscheme
- [Plenary](#plenary) — Lua utility library

---

## Harpoon

**Repository**: [ThePrimeagen/harpoon](https://github.com/ThePrimeagen/harpoon)  
**Purpose**: Navigate between frequently used files without opening file explorer

### How It Works
- **Add files**: Press `<leader>a` to add the current file to your Harpoon list
- **View list**: Press `<C-e>` to open the Harpoon menu and see all marked files
- **Quick jump**: Use `<C-h>`, `<C-t>`, `<C-n>`, `<C-s>` to jump to files 1-4

### Configuration
Located in `lua/plugins/harpoon.lua`

### Workflow Example
1. Open `main.py` → press `<leader>a` to mark it
2. Open `utils.py` → press `<leader>a` to mark it
3. Now press `<C-h>` anytime to instantly jump to `main.py`
4. Press `<C-t>` to jump to `utils.py`

---

## Telescope

**Repository**: [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)  
**Purpose**: Fuzzy find files, search text, and browse project

### How It Works
- **Find files**: `<leader>pf` — Search all project files
- **Git files**: `<C-p>` — Search Git-tracked files only (faster)
- **Grep search**: `<leader>ps` — Search file contents
- **Help tags**: `<leader>vh` — Search Neovim help documentation

### Usage Tips
- Type to filter results
- Use `<C-j>`/`<C-k>` to navigate up/down
- Press `<Enter>` to open the selected file
- Press `<C-x>` to open in split, `<C-v>` for vertical split
- Press `<C-t>` to open in new tab

### Configuration
Located in `lua/plugins/telescope.lua`

---

## LSP Zero

**Repository**: [VonHeikemen/lsp-zero.nvim](https://github.com/VonHeikemen/lsp-zero.nvim)  
**Purpose**: Simplified Language Server Protocol setup with autocompletion

### Included Dependencies
- **nvim-lspconfig** — Language server configurations
- **nvim-cmp** — Autocompletion engine
- **LuaSnip** — Snippet engine
- **friendly-snippets** — Pre-built snippets

### Supported Languages (Configured)
- Lua
- Python (via Pyright)

### Adding Language Support
Edit `lua/plugins/mason.lua` and add server names to the `M.servers` table:

```lua
M.servers = {
    "lua_ls",
    "pyright",
    "ts_ls",  -- Add TypeScript
    "gopls",  -- Add Go
}
```

After saving, restart Neovim and Mason will install new servers.

### Configuration
Located in:
- `lua/plugins/lsp.lua` — LSP Zero setup
- `lua/plugins/mason.lua` — Language server installer

---

## Mason

**Repository**: [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim)  
**Purpose**: Install and manage language servers, formatters, and linters

### Opening Mason
Use `:Mason` to open the Mason UI in Neovim

### Supported Servers
Currently configured:
- `lua_ls` — Lua language server
- `pyright` — Python language server

### Installation
Servers in the `M.servers` list in `lua/plugins/mason.lua` are automatically installed.

---

## Treesitter

**Repository**: [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)  
**Purpose**: Syntax highlighting, code navigation, and text objects

### Supported Languages
Currently configured:
- JavaScript
- PHP
- TypeScript
- Lua
- Markdown (with Vim regex fallback)

### Features
- **Syntax highlighting**: Language-aware code colors
- **Code indentation**: Context-aware auto-indentation
- **Incremental parsing**: Faster updates as you type

### Adding Language Support
Edit `lua/plugins/treesitter.lua` and add language names to `ensure_installed`:

```lua
ensure_installed = {"javascript", "php", "typescript", "lua", "python"},
```

Restart Neovim and Treesitter will download parsers automatically.

### Configuration
Located in `lua/plugins/treesitter.lua`

---

## Trouble

**Repository**: [folke/trouble.nvim](https://github.com/folke/trouble.nvim)  
**Purpose**: Organize and navigate LSP diagnostics (errors, warnings, info)

### Opening Trouble
- `<leader>tt` — Toggle the Trouble panel
- `<leader>tn` — Jump to next diagnostic
- `<leader>tp` — Jump to previous diagnostic

### How It Works
Trouble displays:
- LSP errors and warnings
- Line numbers where issues occur
- Quick navigation between problems

### Configuration
Located in `lua/plugins/trouble.lua`

---

## Fugitive

**Repository**: [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)  
**Purpose**: Git integration for version control operations

### Opening Fugitive
- `<leader>gs` — Open the Git status window (`:Git`)

### Common Commands
In the Fugitive status window:
- `s` — Stage file/hunk
- `u` — Unstage file/hunk
- `cc` — Create commit
- `pp` — Push to remote
- `pl` — Pull from remote
- `gq` — Close Fugitive window

### Configuration
Located in `lua/plugins/fugitive.lua`

---

## Undotree

**Repository**: [mbbill/undotree](https://github.com/mbbill/undotree)  
**Purpose**: Visualize and navigate undo/redo history as a tree

### Opening Undotree
- `<leader>u` — Toggle the undo tree panel

### How It Works
- Left panel shows undo history as a tree
- Right panel shows file state at each point in history
- Navigate history and click/select to restore any previous state

### Configuration
Located in `lua/plugins/undotree.lua`

---

## Rose Pine

**Repository**: [rose-pine/neovim](https://github.com/rose-pine/neovim)  
**Purpose**: Beautiful, warm colorscheme

### Features
- **Three variants**: Main, Moon, and Dawn
- **Terminal-aware**: Optimized colors for different terminal backgrounds
- **Syntax highlighting**: Clear, distinct colors for code elements

### Switching Variants
Edit `lua/plugins/color-scheme.lua`:

```lua
vim.cmd.colorscheme "rose-pine"        -- Main variant (default)
vim.cmd.colorscheme "rose-pine-moon"   -- Dark variant
vim.cmd.colorscheme "rose-pine-dawn"   -- Light variant
```

### Configuration
Located in `lua/plugins/color-scheme.lua`

---

## Plenary

**Repository**: [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim)  
**Purpose**: Utility library used by other plugins (Telescope, Harpoon)

This plugin provides helpful Lua functions used by multiple other plugins. No direct user configuration needed.

### Configuration
Located in `lua/plugins/file-finders.lua`

---

## Markdown Preview

**Repository**: [iamcco/markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)  
**Purpose**: Live markdown preview in browser as you edit  
**Browser**: Firefox (full path: `/usr/bin/firefox`)

### How It Works
- Open any `.md` file in Neovim
- Press `<leader>mp` to open live preview in Firefox
- Edit the markdown, browser updates in real-time
- Press `<leader>mc` to close the preview

### Features
- **Live updates**: Changes reflect instantly in browser
- **Syntax highlighting**: Code blocks are properly highlighted
- **Table support**: Markdown tables render beautifully
- **Local server**: Preview runs on `http://localhost:8080`

### Requirements
- Firefox must be installed (`sudo apt install firefox`)
- Or configure different browser in `lua/plugins/markdown-preview.lua`

### Configuration
Located in `lua/plugins/markdown-preview.lua`

Uses Firefox directly via: `vim.g.mkdp_browser = '/usr/bin/firefox'`

To use different browser, change the path to your browser executable:
```lua
vim.g.mkdp_browser = '/usr/bin/brave-browser'  -- for Brave
vim.g.mkdp_browser = '/usr/bin/chromium'       -- for Chromium
```

### Tips
- Keep browser window side-by-side with Neovim for best experience
- First preview opens on `http://localhost:8080`
- First preview generation takes 5-10 seconds
- Close preview when done to free up the port

---

## Adding New Plugins

To add a new plugin:

1. Create a file in `lua/plugins/my-plugin.lua`:

```lua
return {
    "github-user/plugin-name",
    config = function()
        -- Plugin configuration
        require("my-plugin").setup({})
    end,
}
```

2. Restart Neovim
3. Lazy.nvim will automatically detect and install the plugin

See [lazy.nvim documentation](https://github.com/folke/lazy.nvim) for advanced options like `dependencies`, `keys`, `ft` (filetypes), etc.
