# Improvement Plan

A strategic document outlining potential enhancements and optimizations for this Neovim configuration.

## Current State Assessment

### Strengths ✅
- **Well-organized structure** — Modular plugin files, clear separation of concerns
- **Core functionality** — LSP, code navigation, Git integration, undo history
- **Good foundation** — Lazy.nvim for efficient plugin management
- **Documentation** — Comprehensive docs for users and maintainers
- **Supported languages** — Python, Lua, JavaScript, TypeScript, PHP

### Gaps & Opportunities 📋

---

## Quick Wins (1-2 hours)

### 1. Add Missing Language Servers
**Current**: Only Lua and Python LSPs configured  
**Improvement**: Add more languages based on actual usage

```lua
-- In lua/plugins/mason.lua, expand M.servers:
M.servers = {
    "lua_ls",
    "pyright",
    "ts_ls",              -- TypeScript/JavaScript
    "gopls",              -- Go (if needed)
    "rust_analyzer",      -- Rust (if needed)
    "vimls",              -- Vim script (if editing .vim files)
}
```

**Benefit**: Better IDE support for more languages  
**Effort**: ~15 minutes

---

### 2. Configure LSP Keybindings
**Current**: LSP installed but no built-in keybindings for actions  
**Improvement**: Add keybindings for common LSP actions

```lua
-- In lua/eric/init.lua
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
        vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr })
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
    end,
})
```

**Benefit**: Navigate code faster with go-to-definition, see references, rename, code actions  
**Effort**: ~20 minutes

---

### 3. Add Auto-formatting
**Current**: No formatter configured  
**Improvement**: Add null-ls or conform.nvim for auto-formatting

```lua
-- lua/plugins/formatting.lua
return {
    "stevearc/conform.nvim",
    event = "BufWrite",
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "black" },
                javascript = { "prettier" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            },
        })
    end,
}
```

**Benefit**: Automatic code formatting on save  
**Effort**: ~30 minutes (including setting up formatters)

---

### 4. Enable Treesitter Motions
**Current**: Treesitter installed but no text objects configured  
**Improvement**: Add treesitter-textobjects for code navigation

```lua
-- lua/plugins/treesitter.lua - add to setup:
require("nvim-treesitter.configs").setup({
    -- ... existing config ...
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
        },
    },
})
```

**Benefit**: `vaf` to select function, `vic` to select class, etc.  
**Effort**: ~15 minutes

---

### 5. Add Comment Plugin
**Current**: No easy comment toggling  
**Improvement**: Add comment.nvim for `<leader>/` to toggle comments

```lua
-- lua/plugins/comment.lua
return {
    "numToStr/Comment.nvim",
    config = function()
        require("Comment").setup()
    end,
}
```

**Benefit**: Press `<leader>/` to comment/uncomment lines  
**Effort**: ~10 minutes

---

## Medium Improvements (2-4 hours)

### 6. Add Snippets Support
**Current**: LuaSnip installed but no custom snippets  
**Improvement**: Create custom snippet library

```lua
-- Create lua/snippets/ folder with snippet files
-- lua/snippets/python.json
{
    "function": {
        "prefix": "fn",
        "body": ["def ${1:name}():"], 
        "description": "Function definition"
    }
}
```

**Benefit**: Faster code writing with smart templates  
**Effort**: ~1 hour

---

### 7. Add Terminal Integration
**Current**: No integrated terminal  
**Improvement**: Add toggleterm.nvim for quick terminal access

```lua
-- lua/plugins/terminal.lua
return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            direction = "float",
        })
        vim.keymap.set("n", "<leader>gg", ":ToggleTerm<CR>")
    end,
}
```

**Benefit**: Quick access to terminal without leaving Neovim  
**Effort**: ~30 minutes

---

### 8. Add Debugging Support
**Current**: No debugging tools  
**Improvement**: Add DAP (Debug Adapter Protocol) for step-through debugging

```lua
-- lua/plugins/dap.lua
return {
    "mfussenegger/nvim-dap",
    dependencies = { "rcarriga/nvim-dap-ui" },
    config = function()
        local dap = require("dap")
        -- Configure debuggers per language
    end,
}
```

**Benefit**: Set breakpoints, step through code, inspect variables  
**Effort**: ~2 hours

---

### 9. Add Buffer/Tab Management
**Current**: Basic Neovim buffer handling only  
**Improvement**: Add bufferline.nvim for visual buffer tabs

```lua
-- lua/plugins/bufferline.lua
return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        require("bufferline").setup()
        vim.keymap.set("n", "H", ":BufferLineCyclePrev<CR>")
        vim.keymap.set("n", "L", ":BufferLineCycleNext<CR>")
    end,
}
```

**Benefit**: Visual buffer tabs at the top, easy switching with H/L  
**Effort**: ~20 minutes

---

### 10. Add File Tree Explorer
**Current**: Basic `:Ex` (netrw)  
**Improvement**: Add nvim-tree for better file navigation

```lua
-- lua/plugins/nvim-tree.lua
return {
    "nvim-tree/nvim-tree.lua",
    config = function()
        require("nvim-tree").setup()
        vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
    end,
}
```

**Benefit**: Visual file tree, preview, create/delete files easily  
**Effort**: ~30 minutes

---

## Larger Projects (4+ hours)

### 11. Theming System
**Current**: Single colorscheme (Rose Pine)  
**Improvement**: Support multiple themes with easy switching

```vim
" Support multiple colorschemes
" :colorscheme rose-pine
" :colorscheme rose-pine-moon
" :colorscheme gruvbox
" :colorscheme tokyonight
```

**Benefit**: Switch themes based on time of day or preference  
**Effort**: ~1-2 hours

---

### 12. Workspace Configuration
**Current**: Single global configuration  
**Improvement**: Project-specific .nvim config support

```lua
-- Support local .nvim/init.lua per project
-- Auto-load project settings (indent width, formatters, etc.)
```

**Benefit**: Different settings per project (Python tabs=4, Go tabs=8, etc.)  
**Effort**: ~2-3 hours

---

### 13. Custom Command Palette
**Current**: Telescope but no command palette  
**Improvement**: Add telescope-ui-select for command palette

```lua
-- <leader>: opens command palette with available actions
```

**Benefit**: Discover available commands easily  
**Effort**: ~1 hour

---

### 14. Testing Integration
**Current**: No test runner integration  
**Improvement**: Add neotest for running tests inside Neovim

```lua
-- lua/plugins/neotest.lua
return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/neotest-python",
        "nvim-neotest/neotest-jest",
    },
}
```

**Benefit**: Run tests, see results inline  
**Effort**: ~2-3 hours

---

### 15. AI Assistant Integration
**Current**: No AI-assisted coding  
**Improvement**: Integrate ChatGPT or Copilot

```lua
-- lua/plugins/copilot.lua or github-copilot-cli
-- AI-powered code suggestions and completions
```

**Benefit**: Faster coding with AI suggestions  
**Effort**: ~1-2 hours (depends on service setup)

---

## Documentation Improvements

### 16. Video Tutorials
**Current**: Text documentation only  
**Improvement**: Create video walkthroughs

- Installation video
- Keybinding tutorial
- Plugin showcase
- Troubleshooting guide

**Benefit**: Visual learners can understand config faster  
**Effort**: ~3-4 hours

---

### 17. Interactive Tutorial Mode
**Current**: Manual reading of docs  
**Improvement**: Interactive `:Tutor` style guide

**Benefit**: Learn by doing  
**Effort**: ~2-3 hours

---

## Performance Improvements

### 18. Startup Time Optimization
**Current**: Not measured  
**Improvement**: Profile and optimize startup

```vim
:StartupTime
```

- Lazy-load more plugins
- Remove unused plugins
- Optimize LSP loading

**Effort**: ~1-2 hours

---

### 19. Large File Handling
**Current**: May struggle with very large files  
**Improvement**: Add large-file handling

```lua
-- Disable syntax highlighting for files > 1MB
-- Disable Treesitter for large files
```

**Effort**: ~30 minutes

---

## Community & Sharing

### 20. GitHub Discussions
**Current**: No community interaction  
**Improvement**: Enable GitHub Discussions for Q&A

**Benefit**: Users can help each other  
**Effort**: ~15 minutes setup

---

## Priority Matrix

### Must Have (Critical Path)
1. ✅ LSP keybindings (#6)
2. ✅ Auto-formatting (#3)
3. ✅ Comment plugin (#5)

### Should Have (Nice to Have)
- Snippets (#7)
- Terminal integration (#8)
- Buffer management (#9)
- File tree (#10)

### Nice to Have (Polish)
- Theming system (#11)
- Testing integration (#14)
- AI integration (#15)

### Infrastructure
- Startup profiling (#18)
- Video tutorials (#16)

---

## Recommended Implementation Order

### Phase 1: Quick Wins (Weekend)
1. Add LSP keybindings
2. Add comment plugin
3. Add formatting (conform.nvim)
4. Add Treesitter textobjects

### Phase 2: Enhancement (Next Week)
5. Add snippets
6. Add terminal integration
7. Add buffer/tab management
8. Update documentation

### Phase 3: Advanced (Later)
9. Add file tree
10. Add theming system
11. Add testing support
12. Consider AI integration

---

## Checklist for Implementation

When implementing any improvement:

- [ ] Create feature branch: `git checkout -b feature/name`
- [ ] Update relevant plugin file or create new one
- [ ] Test thoroughly in Neovim
- [ ] Update KEYBINDINGS.md with new bindings
- [ ] Update PLUGINS.md if adding/modifying plugins
- [ ] Update ARCHITECTURE.md if structure changes
- [ ] Test with `:StartupTime` for performance impact
- [ ] Commit with clear message: `git commit -m "feat: Add feature-name"`
- [ ] Verify no regressions with existing features
- [ ] Create PR and self-review

---

## Notes

### Dependencies to Monitor
- **lazy.nvim** — Plugin manager (stable)
- **lsp-zero** — LSP setup (v1.x, monitored)
- **Treesitter** — Syntax highlighting (frequently updated)
- **Rose Pine** — Colorscheme (stable)

### Compatibility
- Maintain Neovim 0.8+ compatibility
- Test on macOS, Linux, and Windows
- Keep config portable between machines

### Testing
- Test on fresh Neovim install
- Verify with `:CheckHealth`
- Run `:Lazy` to check plugin status
- Profile with `:StartupTime`

---

## Contributing Ideas

If you have improvement ideas:
1. Open an issue with description
2. Include use case and benefit
3. Estimate effort
4. Link related improvements

---

**Last Updated**: October 2, 2026  
**Maintained by**: Eric Castillo
