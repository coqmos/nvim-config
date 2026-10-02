# Keybindings Reference

A comprehensive guide to all keybindings in this Neovim configuration.

**Leader Key**: `<Space>` (spacebar)  
**Local Leader**: `<Backslash>` (`\`)

## Global Navigation

| Keybinding | Mode | Action |
|-----------|------|--------|
| `<leader>pv` | Normal | Open file explorer (`:Ex`) |
| `<leader>u` | Normal | Toggle undo tree |

## Harpoon - Quick File Navigation

Harpoon allows you to mark and quickly jump to important files.

| Keybinding | Mode | Action |
|-----------|------|--------|
| `<leader>a` | Normal | Add current file to Harpoon list |
| `<C-e>` | Normal | Toggle Harpoon quick menu |
| `<C-h>` | Normal | Jump to Harpoon file 1 |
| `<C-t>` | Normal | Jump to Harpoon file 2 |
| `<C-n>` | Normal | Jump to Harpoon file 3 |
| `<C-s>` | Normal | Jump to Harpoon file 4 |
| `<C-S-P>` | Normal | Jump to previous Harpoon buffer |
| `<C-S-N>` | Normal | Jump to next Harpoon buffer |

## Telescope - Fuzzy Finding

Telescope provides fuzzy finding for files, text search, and more.

| Keybinding | Mode | Action |
|-----------|------|--------|
| `<leader>pf` | Normal | Find files in project |
| `<C-p>` | Normal | Find files in Git repository |
| `<leader>ps` | Normal | Grep search in project (interactive) |
| `<leader>vh` | Normal | Help tags search |

## Trouble - Diagnostics

Trouble displays LSP diagnostics and errors in an organized view.

| Keybinding | Mode | Action |
|-----------|------|--------|
| `<leader>tt` | Normal | Toggle Trouble diagnostics panel |
| `<leader>tn` | Normal | Jump to next diagnostic |
| `<leader>tp` | Normal | Jump to previous diagnostic |

## Fugitive - Git Integration

Fugitive provides Git commands integration.

| Keybinding | Mode | Action |
|-----------|------|--------|
| `<leader>gs` | Normal | Open Fugitive Git status (`:Git`) |

## Text Manipulation

| Keybinding | Mode | Action |
|-----------|------|--------|
| `J` | Visual | Move selected text down one line |
| `K` | Visual | Move selected text up one line |

## Tips & Tricks

### Working with Harpoon
1. **Mark files**: Press `<leader>a` in the files you frequently edit
2. **Quick jump**: Use `<C-h>`, `<C-t>`, `<C-n>`, `<C-s>` to jump between marked files
3. **View marked files**: Press `<C-e>` to see your marked files in a menu

### Using Telescope
- **Find files**: `<leader>pf` opens a search prompt
  - Type to filter, use `<C-j>/<C-k>` to navigate, `<CR>` to open
- **Git files**: `<C-p>` limits search to Git-tracked files (faster)
- **Grep search**: `<leader>ps` searches file contents
  - Enter your search term and browse results

### Troubleshooting Keybindings
- Check if a keybinding is already taken: `:verbose map <keybinding>`
- List all keybindings: `:map` (normal mode), `:vmap` (visual mode), `:imap` (insert mode)
- Disable a keybinding: Comment out the `vim.keymap.set()` line in the config

## Customizing Keybindings

Edit `lua/eric/init.lua` to add or modify keybindings:

```lua
-- Example: Add a new keybinding
vim.keymap.set("n", "<leader>x", function()
    -- Your action here
end)
```

Modes:
- `"n"` — Normal mode
- `"i"` — Insert mode
- `"v"` — Visual mode
- `"x"` — Visual block mode
- `"c"` — Command mode

Restart Neovim for changes to take effect.
