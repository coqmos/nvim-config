# Configuration Architecture

## Overview

This Neovim configuration follows a modular structure with:
- **Lazy.nvim** for plugin management with lazy-loading
- **Separate plugin files** for organization and maintainability
- **Namespace-based config** for personal settings

## Directory Structure

```
~/.config/nvim/
├── init.lua                    # Neovim entry point
├── lazy-lock.json             # Plugin versions (git-tracked)
├── README.md                  # Main documentation
├── docs/                      # Documentation
│   ├── KEYBINDINGS.md        # Keybinding reference
│   ├── PLUGINS.md            # Plugin documentation
│   ├── ARCHITECTURE.md       # This file
│   ├── SETUP.md              # Setup instructions
│   └── TROUBLESHOOTING.md    # Common issues
└── lua/
    ├── config/
    │   └── lazy.lua          # Lazy.nvim bootstrap & setup
    ├── plugins/              # Individual plugin configs (one file per plugin)
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
        └── init.lua          # Personal keybindings & settings
```

## Initialization Flow

### 1. Entry Point: `init.lua`

```lua
require("config.lazy")    -- Bootstrap lazy.nvim
require("eric")           -- Load personal settings
```

The init.lua is minimal and only loads the lazy.nvim setup and personal config.

### 2. Lazy Configuration: `lua/config/lazy.lua`

Handles:
- Bootstrap lazy.nvim (downloads if missing)
- Set leader keys (`<Space>` and `\`)
- Load all plugins from `lua/plugins/` directory
- Configure lazy.nvim options (auto-checker, colorscheme, etc.)

### 3. Plugins: `lua/plugins/*.lua`

Each plugin is a separate file that returns a plugin spec table:

```lua
-- Example plugin structure
return {
    "github-user/plugin-name",
    dependencies = { "other-plugin" },  -- Optional
    event = "VeryLazy",                 -- Optional: lazy-load trigger
    config = function()
        -- Plugin setup and keybindings
    end,
}
```

Lazy.nvim automatically discovers all `.lua` files in the `plugins/` directory.

### 4. Personal Settings: `lua/eric/init.lua`

Contains:
- Personal keybindings
- Vim options and settings
- Anything custom to your workflow

This is separate from plugins for easy customization.

## Plugin Organization Principles

### One File Per Plugin
Each plugin gets its own file for clarity and maintainability:

✅ **Good**: 
```
plugins/
├── telescope.lua
├── harpoon.lua
└── lsp.lua
```

❌ **Avoid**: Combining multiple plugins in one file

### Lazy Spec Format

All plugin files return a table matching lazy.nvim's spec:

```lua
return {
    -- Plugin repository (required)
    "github-user/plugin-name",
    
    -- Plugin dependencies (optional)
    dependencies = { "other-plugin" },
    
    -- When to load this plugin (optional)
    event = "VeryLazy",  -- or "BufRead", "VeryLazy", etc.
    
    -- Filetype-specific loading (optional)
    ft = { "python", "lua" },
    
    -- Configuration function (optional)
    config = function()
        require("plugin-name").setup({})
        -- Keybindings here
    end,
    
    -- Init function (runs before plugin loads) (optional)
    init = function()
        -- Early configuration
    end,
}
```

## Configuration Patterns

### Pattern 1: Setup Only (No Keybindings)
```lua
return {
    "plugin/name",
    config = function()
        require("plugin").setup({ option = true })
    end,
}
```

### Pattern 2: Setup with Keybindings
```lua
return {
    "plugin/name",
    config = function()
        require("plugin").setup({})
        
        vim.keymap.set("n", "<leader>x", function()
            require("plugin").do_something()
        end)
    end,
}
```

### Pattern 3: Setup via M.config()
```lua
local M = {
    "plugin/name",
    dependencies = { "dep1", "dep2" },
}

function M.config()
    -- Setup code here
end

return M
```

## Adding New Plugins

### Step 1: Create Plugin File
Create `lua/plugins/my-plugin.lua`:

```lua
return {
    "author/my-plugin",
    config = function()
        require("my-plugin").setup({
            option1 = true,
            option2 = false,
        })
        
        -- Add keybindings if needed
        vim.keymap.set("n", "<leader>x", function()
            vim.cmd.MyPluginCommand()
        end)
    end,
}
```

### Step 2: Restart Neovim
- Lazy.nvim automatically discovers the file
- Plugin installs on next startup
- Or run `:Lazy` to manually trigger installation

### Step 3: Verify Installation
Run `:Lazy` to see plugin status (should show as "loaded")

## Lazy-Loading Strategies

Optimize startup time by lazy-loading plugins:

```lua
-- Load on first command use
return {
    "plugin/name",
    cmd = "PluginCommand",
}

-- Load on specific filetypes
return {
    "plugin/name",
    ft = { "python", "lua" },
}

-- Load on specific events
return {
    "plugin/name",
    event = "BufRead",  -- Load when opening a file
}

-- Load after other plugins
return {
    "plugin/name",
    dependencies = { "nvim-lua/plenary.nvim" },
}
```

## Vim Options vs. Plugin Settings

### Vim Options (in `lua/eric/init.lua`)
```lua
vim.wo.number = true           -- Window-local option
vim.opt.expandtab = true       -- Global option
vim.g.mapleader = " "          -- Global variable
```

### Plugin Settings (in `lua/plugins/*.lua`)
```lua
require("plugin").setup({
    option1 = true,
    option2 = "value",
})
```

**Rule of Thumb**: 
- Core Neovim behavior → `lua/eric/init.lua`
- Plugin-specific settings → `lua/plugins/*.lua`

## Dependency Management

Lazy.nvim tracks dependencies and loads them before dependent plugins:

```lua
return {
    "plugin-that-depends",
    dependencies = {
        "dependency-plugin",
        "another-dependency",
    },
}
```

Example: Telescope depends on Plenary

```lua
-- lua/plugins/telescope.lua
return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    -- ...
}
```

Lazy.nvim automatically ensures Plenary loads before Telescope.

## Performance Considerations

### Current Setup
- **Lazy-loading enabled** for plugins without explicit load conditions
- **Plugin checker disabled by default** (enable in lazy.lua if desired)
- **Treesitter parsers cached** to avoid reinstalling on each boot

### Optimization Tips

1. **Use lazy-load events** to defer non-critical plugins:
   ```lua
   event = "VeryLazy"  -- Load after UI is ready
   ```

2. **Limit auto-install** on slow connections:
   ```lua
   -- In lazy.lua
   checker = { enabled = false }  -- Skip update checks
   ```

3. **Profile startup** with:
   ```vim
   :StartupTime
   ```

## Customization Guide

### Add a Keybinding
Edit `lua/eric/init.lua`:
```lua
vim.keymap.set("n", "<leader>x", function()
    -- Your action
end)
```

### Add a Plugin Option
Edit the plugin's `config` function in its `.lua` file

### Disable a Plugin
Comment out or delete the plugin file (e.g., rename to `*.bak`)

### Override Plugin Keybindings
Define the new keybinding in `lua/eric/init.lua` after plugins load

## Best Practices

1. **One plugin per file** — Easier to find and modify
2. **Descriptive filenames** — Match the plugin name when possible
3. **Comments for non-obvious configs** — Explain why, not what
4. **Test after changes** — Restart Neovim and verify
5. **Keep lazy-lock.json** — Ensures reproducible setups across machines
6. **Document keybindings** — Update KEYBINDINGS.md when adding bindings
7. **Version constraints** — Lock plugin versions via lazy-lock.json

## Troubleshooting Architecture

### Plugin Not Loading
1. Check file exists in `lua/plugins/`
2. Verify plugin name in return statement
3. Run `:Lazy` to see plugin status
4. Check for syntax errors in Lua

### Keybinding Not Working
1. Verify correct mode (n/i/v/etc.)
2. Check for conflicting keybindings: `:verbose map <binding>`
3. Ensure plugin is loaded: `:Lazy`
4. Restart Neovim for config changes

### Performance Issues
1. Run `:StartupTime` to identify slow plugins
2. Add lazy-load conditions to heavy plugins
3. Check for blocking plugin configs
