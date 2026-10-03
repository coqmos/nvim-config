# Troubleshooting Guide

Common issues and their solutions.

## Installation & Startup

### Issue: "command not found: nvim"
**Cause**: Neovim is not installed or not in PATH

**Solution**:
1. Verify installation: `nvim --version`
2. If not found, install Neovim: See [SETUP.md](./SETUP.md)
3. On Windows, add Neovim to PATH environment variable

### Issue: Lazy.nvim Won't Download
**Cause**: Git not installed or no internet connection

**Solution**:
1. Verify Git: `git --version`
2. Check internet connection
3. Try manual sync: `:Lazy sync`

### Issue: Plugins Failing to Install
**Cause**: Plugin repository issue or bad dependency

**Solution**:
```vim
:Lazy sync              " Force resynchronization
:Lazy update            " Update all plugins
:Lazy clean             " Remove unused plugins
```

### Issue: Plugin Loads But Has No Functions
**Cause**: Plugin spec syntax error

**Solution**:
1. Check Lua syntax: Run nvim with verbose
   ```vim
   :messages
   ```
2. Review plugin file in `lua/plugins/`
3. Verify plugin name matches repository

---

## Performance Issues

### Issue: Slow Startup
**Cause**: Plugins loading unnecessarily or plugin misconfiguration

**Solution**:
```vim
:StartupTime
```
Shows which plugins are slow. Review their configs and add lazy-load conditions.

Example optimization:
```lua
-- Instead of loading all the time
return { "plugin/name", config = function() ... end }

-- Load only on specific events
return {
    "plugin/name",
    event = "VeryLazy",      -- Defer loading
    config = function() ... end
}
```

### Issue: Laggy Typing
**Cause**: Heavy plugin or language server overload

**Solution**:
1. Check which LSP is active: `:LspInfo`
2. Try disabling LSP temporarily: `:LspStop`
3. Check Mason server logs: `:Mason` → view server logs

### Issue: High CPU Usage
**Cause**: Treesitter parsing or LSP indexing

**Solution**:
1. Disable Treesitter for large files
2. Limit LSP to essential languages
3. Profile the running process

---

## LSP & Language Servers

### Issue: LSP Not Connecting
**Cause**: Language server not installed or misconfigured

**Solution**:
```vim
:LspInfo                        " See active servers
:Mason                          " Install missing servers
:e /path/to/supported/file      " Open file matching server filetype
```

### Issue: Python LSP Not Working
**Cause**: Pyright not installed or not in PATH

**Solution**:
```bash
# Install Pyright
pip install pyright

# Verify installation
which pyright       # macOS/Linux
where pyright       # Windows

# Check in Neovim
:LspInfo
```

### Issue: Autocompletion Not Working
**Cause**: LSP not connected or cmp not configured

**Solution**:
1. Verify LSP running: `:LspInfo`
2. Check cmp is loaded: `:Lazy` → search "cmp"
3. Test with: Type code and press `<C-x><C-o>`

### Issue: Markdown Preview Not Opening in Browser
**Cause**: Browser not found, not configured, or Node.js dependencies not installed

**Solution**:
1. **Ensure Firefox is installed**:
   ```bash
   which firefox
   # If not found, install:
   sudo apt install firefox
   ```

2. **Install plugin dependencies** (if build process didn't run):
   ```bash
   # Navigate to plugin directory
   cd ~/.local/share/nvim/lazy/markdown-preview.nvim
   
   # Install Node.js dependencies
   npm install
   ```
   *Note: The plugin's build process should do this automatically, but if you see "Cannot find module 'tslib'" error, run this manually.*

3. **Configure browser path** in `lua/plugins/markdown-preview.lua`:
   ```lua
   vim.g.mkdp_browser = '/usr/bin/firefox'  -- or '/usr/bin/brave-browser'
   ```

4. **Test preview**:
   ```vim
   :e README.md          " Open markdown file
   :MarkdownPreview      " Start preview
   :MarkdownPreviewStop  " Stop preview
   ```

**Note**: First preview generation takes 5-10 seconds. Firefox opens on `http://localhost:8080`

### Issue: Treesitter "module not found" with Neovim 0.12
**Cause**: Treesitter parser compilation needed for Neovim 0.12

**Solution**:
1. Clear cache and rebuild:
   ```bash
   rm -rf ~/.cache/nvim/treesitters
   nvim
   ```

2. Rebuild treesitter parsers:
   ```vim
   :TSUpdate
   :TSInstall lua javascript typescript php
   ```

3. Restart Neovim and open a `.lua` or `.js` file to trigger parser compilation

**Note**: First file open with treesitter may take 10-30 seconds as parsers compile. Subsequent opens are instant.

### Issue: "Server is busy"
**Cause**: Language server still initializing

**Solution**:
- Wait for server to finish initial indexing (30 seconds to 2 minutes)
- Run `:LspInfo` again to see progress
- Restart server: `:LspRestart`

### Issue: Wrong Language Server for File Type
**Cause**: Multiple servers configured or server misconfiguration

**Solution**:
1. Check active servers: `:LspInfo`
2. Edit `lua/plugins/mason.lua` to adjust servers
3. Restart Neovim

---

## Keybindings

### Issue: Keybinding Not Working
**Cause**: Keybinding not defined, conflicts, or wrong mode

**Solution**:
```vim
:verbose map <leader>x          " Check what's mapped
:verbose nmap <leader>x         " Normal mode
:verbose imap <leader>x         " Insert mode
```

### Issue: Keybinding Conflicting
**Cause**: Two plugins or configs using same binding

**Solution**:
1. Find conflict: `:verbose map <leader>x`
2. Disable one plugin (rename file to `.bak`)
3. Or redefine in `lua/eric/init.lua`

### Issue: Leader Key Not Working
**Cause**: Leader key changed or not set

**Solution**:
1. Check leader in `lua/config/lazy.lua`:
   ```lua
   vim.g.mapleader = " "       " Should be space
   ```
2. Restart Neovim
3. Test with `:map <leader>` to see all leader mappings

---

## Plugins

### Issue: Plugin Command Not Found
**Cause**: Plugin not loaded yet (lazy-loading) or not installed

**Solution**:
```vim
:Lazy                           " Check plugin status
:Lazy load plugin-name          " Force load a plugin
:Lazy update                    " Reinstall plugins
```

### Issue: Harpoon Not Saving Files
**Cause**: Harpoon data not persisting

**Solution**:
1. Check harpoon directory exists: `~/.local/share/nvim/`
2. Delete harpoon cache and restart: `rm -rf ~/.local/share/nvim/harpoon*`
3. Re-add files with `<leader>a`

### Issue: Telescope Not Finding Files
**Cause**: Incorrect working directory or file permissions

**Solution**:
1. Verify working directory: `:pwd`
2. Check file permissions: `ls -la`
3. Try from Git repository directory for `<C-p>`
4. Manually specify path: `:Telescope find_files cwd=<path>`

### Issue: Trouble Panel Shows Nothing
**Cause**: No LSP diagnostics active

**Solution**:
1. Ensure LSP is running: `:LspInfo`
2. Create an intentional error in code (e.g., undefined variable)
3. Toggle Trouble: `<leader>tt`

### Issue: Undotree Not Showing History
**Cause**: No undo history yet

**Solution**:
1. Make changes to file
2. Undo some changes
3. Toggle Undotree: `<leader>u`

---

## Display Issues

### Issue: Colors Wrong or Garbled
**Cause**: Terminal doesn't support 24-bit colors

**Solution**:
1. **macOS**: Use iTerm2, Alacritty, or Kitty (not Terminal.app)
2. **Linux**: Set TERM variable:
   ```bash
   export TERM=xterm-256color
   nvim
   ```
3. **Windows**: Use Windows Terminal (not cmd.exe)

### Issue: Theme Not Applying
**Cause**: Color scheme not loaded

**Solution**:
1. Check color scheme configured: `lua/plugins/color-scheme.lua`
2. Verify Rose Pine installed: `:Lazy` → search "rose-pine"
3. Force load colorscheme: `:colorscheme rose-pine`

### Issue: Text Overlapping or Misaligned
**Cause**: Font rendering issue or terminal bug

**Solution**:
1. Try different font (preferably monospace)
2. Restart terminal
3. Update terminal application
4. Try different terminal

### Issue: UI Elements Not Visible
**Cause**: Terminal window too small or display issue

**Solution**:
1. Resize terminal window
2. Restart Neovim
3. Check terminal rendering: `:set term?`

---

## File Operations

### Issue: File Not Saving
**Cause**: Permission denied or read-only file

**Solution**:
1. Check file permissions: `ls -l filename`
2. Make file writable: `chmod 644 filename`
3. Or save with elevated permissions: `:w !sudo tee %`

### Issue: File Explorer Not Opening
**Cause**: `:Ex` command broken or path issue

**Solution**:
1. Try manual command: `:Ex`
2. Or use keybinding: `<leader>pv`
3. Try opening specific directory: `:Ex /path/to/dir`

### Issue: Git Changes Not Showing in Fugitive
**Cause**: Not in Git repository or Git not found

**Solution**:
1. Verify Git installed: `git --version`
2. Check in Git repo: `git status`
3. Restart Neovim from Git directory

---

## Lua Configuration

### Issue: Configuration Error on Startup
**Cause**: Lua syntax error in config

**Solution**:
1. Check error message: `:messages`
2. Look for line numbers in error
3. Check syntax in that file
4. Use Lua linter: `luacheck lua/`

### Issue: Vim Commands Not Working
**Cause**: Using VimScript syntax instead of Lua

**Solution**:
From VimScript to Lua:
```vim
" VimScript
set number
set expandtab

" Lua equivalent
vim.opt.number = true
vim.opt.expandtab = true
```

---

## Debug Mode

### Enable Verbose Logging
```vim
:set verbose=10
:set verbosefile=/tmp/nvim-debug.log
" Do something that fails
:quit
```

Then check log: `tail -f /tmp/nvim-debug.log`

### Check Startup Time
```vim
:StartupTime
```

### View All Loaded Scripts
```vim
:scriptnames
```

### Inspect Plugin Configs
```vim
:Lazy profile
```

---

## Get Help

### In Neovim Help
```vim
:help nvim                  " Main Neovim docs
:help lsp                   " LSP documentation
:help vim.keymap            " Keybinding docs
:help help                  " How to use help
```

### Plugin-Specific Help
```vim
:help lazy                  " Lazy.nvim docs
:help telescope             " Telescope docs
:help lsp-zero              " LSP Zero docs
:help harpoon               " Harpoon docs
```

### Online Resources
- [Neovim Documentation](https://neovim.io/doc/user/)
- [Lazy.nvim GitHub](https://github.com/folke/lazy.nvim)
- [Telescope GitHub](https://github.com/nvim-telescope/telescope.nvim)
- [Reddit r/neovim](https://reddit.com/r/neovim/)

---

## Report Issues

If you find a bug:
1. Try clearing cache: `rm -rf ~/.local/share/nvim/`
2. Update plugins: `:Lazy update`
3. Restart Neovim: `:quit` → `nvim`
4. Check [Troubleshooting.md](./TROUBLESHOOTING.md) again
5. Create GitHub issue with:
   - **Error message** from `:messages`
   - **Neovim version** from `:version`
   - **Reproduction steps** to trigger issue
