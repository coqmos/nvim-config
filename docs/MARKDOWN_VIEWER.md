# Reading Markdown Files in Neovim

Guide for viewing and navigating markdown documentation within Neovim.

## Built-in Markdown Support

Neovim has basic markdown support out of the box:

### Viewing Markdown Files
```bash
# Navigate to any .md file
nvim docs/KEYBINDINGS.md
nvim docs/PLUGINS.md
nvim README.md
```

Markdown files will be syntax-highlighted with:
- **Bold** text in emphasis color
- `Code` in code color
- Headers with increased size
- Lists with bullet points

### Navigation in Markdown

| Keys | Action |
|------|--------|
| `[[` | Jump to previous heading |
| `]]` | Jump to next heading |
| `gf` | Follow link (if path exists) |
| `<C-o>` | Jump back |
| `<C-i>` | Jump forward |

## Recommended Markdown Plugins

### Option 1: Markdown Preview (Recommended)

Install a live preview plugin to see formatted output in a browser:

#### vim-markdown-preview
In `lua/plugins/markdown.lua`:
```lua
return {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
        vim.fn["mkdp#util#install"]()
    end,
    config = function()
        vim.keymap.set("n", "<leader>mp", vim.cmd.MarkdownPreview)
    end,
}
```

Then open Markdown and press `<leader>mp` to see live preview in browser.

### Option 2: Markdown Outline

View document structure while editing:

In `lua/plugins/markdown-outline.lua`:
```lua
return {
    "stevearc/aerial.nvim",
    ft = "markdown",
    config = function()
        require("aerial").setup()
        vim.keymap.set("n", "<leader>mo", vim.cmd.AerialToggle)
    end,
}
```

Press `<leader>mo` to toggle outline sidebar.

### Option 3: Better Markdown Syntax

Enhanced highlighting with `vim-markdown`:

In `lua/plugins/vim-markdown.lua`:
```lua
return {
    "preservim/vim-markdown",
    ft = "markdown",
}
```

Provides:
- Better syntax highlighting
- Folding by header level
- Table of contents generation

## Reading Documentation Files

### Quick Navigation

From your config directory (`~/.config/nvim/`):

```bash
# Open README
nvim README.md

# Open documentation
nvim docs/KEYBINDINGS.md
nvim docs/PLUGINS.md
nvim docs/ARCHITECTURE.md
nvim docs/SETUP.md
nvim docs/TROUBLESHOOTING.md
nvim docs/CHEATSHEET.md
```

### Creating a Documentation Index

Create `docs/INDEX.md`:

```markdown
# Neovim Config Documentation

## Quick Start
- [README](../README.md) — Overview and installation
- [CHEATSHEET.md](./CHEATSHEET.md) — Quick keybinding reference
- [SETUP.md](./SETUP.md) — Detailed setup instructions

## Reference
- [KEYBINDINGS.md](./KEYBINDINGS.md) — Complete keybinding guide
- [PLUGINS.md](./PLUGINS.md) — Plugin descriptions and configs
- [ARCHITECTURE.md](./ARCHITECTURE.md) — Project structure

## Troubleshooting
- [TROUBLESHOOTING.md](./TROUBLESHOOTING.md) — Common issues and fixes

## Markdown Viewer
- [MARKDOWN_VIEWER.md](./MARKDOWN_VIEWER.md) — How to view docs in Neovim
```

Then open with:
```bash
nvim docs/INDEX.md
```

Click links with `gf` to jump between docs.

## Tips for Reading Markdown in Neovim

### Reduce Visual Clutter
```vim
:set conceallevel=2
```
This hides markdown syntax (`#`, `*`, etc.) and shows formatted output.

### Enable Word Wrap
```vim
:set wrap
:set linebreak
```
Text will wrap at word boundaries instead of being cut off.

### Increase Reading Comfort
```vim
:set scrolloff=5        " Keep text centered
:set sidescrolloff=5
vim.opt.cursorline = true  " Highlight current line
```

### Set Up in Config
Add to `lua/eric/init.lua`:
```lua
-- Markdown-specific settings
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.conceallevel = 2
        vim.opt_local.spell = true  -- Enable spell check
    end,
})
```

## Searching Documentation

### Search Across Files
```vim
:Telescope live_grep
```
Type your search term to find it across all documentation.

Example:
```
:Telescope live_grep
> keybinding        " Finds all mentions of "keybinding"
```

### Search Current File
```vim
/pattern            " Search in current file
n                   " Next match
N                   " Previous match
```

### Search with Grep
```vim
:Telescope grep_string
```
Interactive grep with cursor word or user input.

## Creating Links Between Docs

### Link Syntax
```markdown
[Link Text](./path/to/file.md)
[Back to KEYBINDINGS](./KEYBINDINGS.md)
[See PLUGINS documentation](./PLUGINS.md)
```

### Jump to Links
When cursor is on a link:
```vim
gf          " Follow the link (open file)
<C-o>       " Jump back
<C-i>       " Jump forward in history
```

## Converting Docs to HTML

If you want to share documentation as HTML:

### Using Pandoc
```bash
# Convert single file
pandoc docs/KEYBINDINGS.md -o docs/KEYBINDINGS.html

# Convert all markdown files
for file in docs/*.md; do
    pandoc "$file" -o "${file%.md}.html"
done
```

### Generate Site
```bash
mkdir -p public/docs

# Copy README
pandoc README.md -o public/index.html

# Copy documentation
for file in docs/*.md; do
    name=$(basename "$file")
    pandoc "$file" -o "public/docs/${name%.md}.html"
done
```

Then host the `public/` folder as a static website.

## Recommended Workflow

### 1. Keep Docs Index Open
Use a terminal split or new tab:
```vim
:tabnew docs/INDEX.md
```

### 2. Quick Reference
Open cheatsheet in background tab:
```vim
:tabnew docs/CHEATSHEET.md
:tabprevious              " Go back to main work
```

### 3. Context-Aware Navigation
When reading KEYBINDINGS.md:
- `gf` on a plugin name to jump to PLUGINS.md
- `gf` on a filepath to open that file
- Jump back with `<C-o>`

### 4. Search and Explore
```vim
:Telescope live_grep
```
Find any concept across all documentation.

## Markdown Completion

For faster markdown writing, you can add snippets:

In `lua/plugins/snippets.lua` (if you add the friendly-snippets dependency):

```lua
return {
    "rafamadriz/friendly-snippets",
    ft = "markdown",
}
```

Then type markdown shortcuts:
- Type `# ` for level-1 header
- Type `- ` for bullet list
- Type `` ` `` for inline code
- Type ` ``` ` for code block

## Updating Documentation

When updating the config:

1. **Update the code** in `lua/`
2. **Update keybindings** in KEYBINDINGS.md
3. **Update plugins** in PLUGINS.md if adding/removing plugins
4. **Update setup** in SETUP.md if dependencies change
5. **Commit** with clear messages

Example:
```bash
git add lua/plugins/my-plugin.lua
git add docs/KEYBINDINGS.md
git commit -m "feat: Add my-plugin with new keybindings"
```

## See Also

- [Neovim Markdown documentation](https://neovim.io/doc/user/syntax.html#markdown)
- [Pandoc documentation](https://pandoc.org/MANUAL.html)
- [vim-markdown documentation](https://github.com/preservim/vim-markdown)

---

**Next**: Check out [KEYBINDINGS.md](./KEYBINDINGS.md) or [CHEATSHEET.md](./CHEATSHEET.md) for quick reference.
