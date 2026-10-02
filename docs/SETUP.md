# Setup Guide

Step-by-step instructions for setting up this Neovim configuration on different operating systems.

## Prerequisites

### All Platforms
- **Neovim 0.8+** — [Installation guide](https://github.com/neovim/neovim/wiki/Installing-Neovim)
- **Git** — Required by lazy.nvim for plugin management
- **Python 3** — For Python LSP support (optional but recommended)

### macOS
- Xcode Command Line Tools: `xcode-select --install`

### Linux
- GCC or Clang compiler (usually pre-installed)
- Build essentials: `sudo apt install build-essential` (Ubuntu/Debian)

### Windows
- Windows Terminal (recommended) or Git Bash
- MinGW or Visual Studio C++ build tools (for some plugins)

---

## Installation Steps

### 1. Install Neovim

#### macOS
```bash
# Using Homebrew (recommended)
brew install neovim

# Or download latest release
# https://github.com/neovim/neovim/releases
```

#### Linux (Ubuntu/Debian)
```bash
# Add PPA
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install neovim
```

#### Linux (Fedora)
```bash
sudo dnf install neovim python3-neovim
```

#### Windows
```powershell
# Using Chocolatey
choco install neovim

# Or using Scoop
scoop install neovim
```

### 2. Verify Installation
```bash
nvim --version
# Should show version 0.8 or higher
```

### 3. Clone Configuration
```bash
# Remove existing config if present
rm -rf ~/.config/nvim

# Clone this repository
git clone https://github.com/yourusername/nvim-config ~/.config/nvim

# Navigate to config directory
cd ~/.config/nvim
```

### 4. Start Neovim
```bash
nvim
```

On first startup, lazy.nvim will:
1. Download itself
2. Download all plugins
3. Install language servers (via Mason)
4. Build Treesitter parsers

This may take 2-5 minutes depending on internet speed.

---

## Optional: Language Server Setup

### Python (Pyright)

#### Option A: pip (Recommended)
```bash
pip install pyright
```

#### Option B: npm
```bash
npm install -g pyright
```

#### Option C: Automatic via Mason
When Neovim starts, Mason will attempt to auto-install. If it fails:
1. Open Neovim
2. Run `:Mason`
3. Find `pyright` and press `i` to install

### Lua Language Server (Automatic)
Mason automatically installs and configures `lua_ls`.

### Adding Other Languages

Edit `lua/plugins/mason.lua` and add server names to the `M.servers` table:

```lua
M.servers = {
    "lua_ls",
    "pyright",
    "ts_ls",      -- TypeScript/JavaScript
    "gopls",      -- Go
    "rust_analyzer",  -- Rust
}
```

Save and restart Neovim. Mason will install new servers automatically.

---

## Platform-Specific Notes

### macOS

#### Terminal Issue
The default Terminal.app may display colors incorrectly. Use alternatives:

- **iTerm2** (recommended): https://www.iterm2.com/
- **Alacritty**: https://github.com/alacritty/alacritty
- **Kitty**: https://sw.kovidgoyal.net/kitty/
- **WezTerm**: https://wezfurlong.org/wezterm/

#### Homebrew Installation
```bash
# Install Neovim
brew install neovim

# Install Python LSP support
pip3 install pyright

# Install Node.js (needed for some plugins)
brew install node
```

### Linux

#### Ubuntu/Debian
```bash
# Add Neovim PPA
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install neovim git python3-pip

# Install Python LSP
pip3 install pyright
```

#### Fedora/RHEL
```bash
# Install Neovim
sudo dnf install neovim git python3-pip

# Install Python LSP
pip3 install pyright
```

#### Arch Linux
```bash
# Install Neovim
sudo pacman -S neovim git python-pip

# Install Python LSP
pip install pyright
```

### Windows

#### Prerequisites
1. Install [Windows Terminal](https://apps.microsoft.com/store/detail/windows-terminal/9N0DX20HK701)
2. Install [Git for Windows](https://git-scm.com/download/win)
3. Install [Neovim](https://github.com/neovim/neovim/releases)

#### Setup Steps
```powershell
# PowerShell (as Administrator)

# Navigate to config directory
New-Item -ItemType Directory -Force -Path $env:APPDATA\nvim

# Clone repository
git clone https://github.com/yourusername/nvim-config $env:APPDATA\nvim

# Install Python LSP (if using Python)
pip install pyright
```

#### Environment Variables
If Neovim isn't in PATH:
1. Open "Edit environment variables for your account"
2. Add Neovim installation directory to PATH
3. Restart PowerShell

---

## Verification Checklist

After installation, verify everything works:

### 1. Check Neovim Version
```vim
:version
```
Should show **v0.8.0** or higher.

### 2. Check Plugins Loaded
```vim
:Lazy
```
Should list all plugins with "loaded" status.

### 3. Test Keybindings
- Press `<leader>pf` to open file finder
- Press `<leader>u` to toggle undo tree
- Press `<leader>gs` to open Git status
- Press `<C-p>` to find Git files

### 4. Check LSP Setup
```vim
:LspInfo
```
Should show active language servers.

### 5. Verify Python LSP
Create a Python file and check autocompletion:
```bash
echo 'import sys' > test.py
nvim test.py
```

In Neovim, type `sys.` and press `<C-x><C-o>` for autocompletion.

---

## Troubleshooting Installation

### Issue: Plugins Not Installing
```vim
:Lazy sync
```
Forces manual plugin synchronization.

### Issue: Mason Not Installing Servers
```vim
:Mason
```
Open Mason UI and manually install language servers.

### Issue: Python LSP Not Working
1. Verify Pyright installation:
   ```bash
   which pyright    # macOS/Linux
   where pyright    # Windows
   ```

2. If not found, reinstall:
   ```bash
   pip install --upgrade pyright
   ```

3. In Neovim, run `:LspInfo` to verify connection

### Issue: Color Scheme Not Displaying
**macOS**: Switch to iTerm2, Alacritty, or Kitty terminal
**Linux**: Verify terminal supports 24-bit color:
```bash
echo $TERM    # Should output something like "xterm-256color"
```

### Issue: Keybindings Not Working
Check for conflicts:
```vim
:verbose map <leader>x
```
This shows if another plugin is using the keybinding.

### Issue: Slow Startup
Run startup profiler:
```vim
:StartupTime
```
Shows which plugins are slow.

---

## Post-Installation Configuration

### 1. Customize Keybindings
Edit `~/.config/nvim/lua/eric/init.lua`:
```lua
-- Add your custom keybindings here
vim.keymap.set("n", "<leader>x", function()
    -- Your action
end)
```

### 2. Adjust Vim Options
In the same file, configure Neovim behavior:
```lua
vim.opt.number = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
```

### 3. Add Additional Plugins
Create new file in `~/.config/nvim/lua/plugins/my-plugin.lua`:
```lua
return {
    "author/plugin-name",
    config = function()
        require("plugin-name").setup({})
    end,
}
```

### 4. Configure Language Servers
Edit `~/.config/nvim/lua/plugins/mason.lua`:
```lua
M.servers = {
    "lua_ls",
    "pyright",
    -- Add your languages here
}
```

---

## Uninstallation

To remove this configuration:

```bash
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim     # Removes downloaded plugins
rm -rf ~/.cache/nvim            # Removes cached data
```

---

## Getting Help

### Read Documentation
- **Keybindings**: See [KEYBINDINGS.md](./KEYBINDINGS.md)
- **Plugins**: See [PLUGINS.md](./PLUGINS.md)
- **Issues**: See [TROUBLESHOOTING.md](./TROUBLESHOOTING.md)

### Check Neovim Help
```vim
:help nvim
:help vim.keymap
:help lsp
```

### View Plugin Documentation
```vim
:help plugin-name
```

### See Configuration Details
```vim
:LspInfo        " Language server info
:Mason          " Language server installer
:Lazy           " Plugin manager status
```
