# Quick Reference Cheatsheet

A quick lookup guide for the most common keybindings and commands.

## Essential Keybindings

### Navigation
| Keys | Action |
|------|--------|
| `<leader>pf` | Find files |
| `<C-p>` | Find Git files (faster) |
| `<leader>pv` | Open file explorer |

### Harpoon (File Marks)
| Keys | Action |
|------|--------|
| `<leader>a` | Mark current file |
| `<C-e>` | Show marked files |
| `<C-h>` / `<C-t>` / `<C-n>` / `<C-s>` | Jump to mark 1-4 |

### Code Navigation
| Keys | Action |
|------|--------|
| `<leader>ps` | Search code |
| `<leader>tn` / `<leader>tp` | Next/prev error |
| `<leader>tt` | Toggle error panel |

### Git & Undo
| Keys | Action |
|------|--------|
| `<leader>gs` | Git status |
| `<leader>u` | Undo tree |

### Text Editing
| Keys | Action |
|------|--------|
| `J` (visual) | Move lines down |
| `K` (visual) | Move lines up |

---

## Vim Navigation (Built-in)

| Keys | Action |
|------|--------|
| `h` `j` `k` `l` | Move left/down/up/right |
| `w` `b` | Word forward/back |
| `0` `$` | Line start/end |
| `gg` `G` | File start/end |
| `Ctrl+u` / `Ctrl+d` | Page up/down |
| `%` | Jump to matching bracket |

---

## Insert Mode

| Keys | Action |
|------|--------|
| `i` / `a` | Insert before/after cursor |
| `I` / `A` | Insert at line start/end |
| `o` / `O` | New line below/above |
| `Esc` | Exit insert mode |

---

## Editing Commands

| Keys | Action |
|------|--------|
| `x` | Delete character |
| `dd` | Delete line |
| `d{motion}` | Delete to motion (e.g., `dw` = delete word) |
| `c{motion}` | Change (delete + insert) |
| `y{motion}` | Copy (yank) |
| `p` / `P` | Paste after/before |
| `.` | Repeat last command |

---

## Common Motions

Use with `d`, `c`, `y`, etc.

| Motion | Selects |
|--------|---------|
| `w` | Next word |
| `b` | Previous word |
| `e` | End of word |
| `t{char}` | Up to character |
| `f{char}` | Forward to character |
| `iw` | Inner word |
| `i"` | Inside quotes |
| `i{` | Inside braces |

Example: `d2w` deletes next 2 words

---

## Visual Mode

| Keys | Action |
|------|--------|
| `v` | Start visual (character) |
| `V` | Start visual (line) |
| `Ctrl+v` | Start visual (block) |
| `o` | Toggle selection end |

---

## Search & Replace

| Keys | Action |
|------|--------|
| `/pattern` | Find pattern |
| `n` / `N` | Next/previous match |
| `:%s/old/new/g` | Replace all in file |
| `:%s/old/new/gc` | Replace with confirm |

---

## Ex Commands

Run with `:command`

| Command | Action |
|---------|--------|
| `:w` | Save |
| `:q` | Quit |
| `:wq` | Save & quit |
| `:!` | Run shell command |
| `:set number` | Show line numbers |
| `:set nonu` | Hide line numbers |
| `:Lazy` | Plugin manager |
| `:LspInfo` | Language server info |
| `:Mason` | Language server installer |
| `:messages` | View recent messages |
| `:StartupTime` | Profile startup |

---

## Telescope Commands

When Telescope is open:

| Keys | Action |
|------|--------|
| `<C-j>` / `<C-k>` | Move up/down |
| `<CR>` | Open selection |
| `<C-x>` | Open in split |
| `<C-v>` | Open in vsplit |
| `<C-t>` | Open in tab |
| `<C-c>` / `<Esc>` | Close |

---

## Marked Files (Harpoon) Workflow

```
1. Open main.py → <leader>a      (mark it)
2. Open config.py → <leader>a    (mark it)
3. Open utils.py → <leader>a     (mark it)
4. Open docs.py → <leader>a      (mark it)

Now anytime:
- <C-h> → main.py
- <C-t> → config.py
- <C-n> → utils.py
- <C-s> → docs.py
```

---

## File Finding Workflow

```
1. <leader>pf              Find any file in project
2. Type filename           Filter results
3. <CR>                    Open the file
4. <C-x>                   Or open in split
```

Or use `<C-p>` for only Git-tracked files (faster).

---

## Error Navigation Workflow

```
1. <leader>tn             Jump to next error
2. <leader>tp             Jump to previous error
3. <leader>tt             Toggle error panel for overview
4. Fix the error
5. Save file
6. LSP auto-checks
```

---

## Quick Tips

### Moving between windows
```vim
Ctrl+w h/j/k/l    " Move to window left/down/up/right
Ctrl+w w          " Cycle through windows
Ctrl+w =          " Equal window sizes
```

### Macros (Record & Replay)
```vim
qa                 " Record into register 'a'
(make changes)
q                  " Stop recording
@a                 " Replay register 'a'
5@a                " Repeat 5 times
```

### Folding (Hide Code Sections)
```vim
za                 " Toggle fold
zM                 " Fold all
zR                 " Unfold all
```

### Marks (Go To Specific Line)
```vim
m{letter}          " Set mark (e.g., ma)
'{letter}          " Jump to mark (e.g., 'a)
''                 " Jump back to previous position
```

---

## Customizing Keybindings

Edit `~/.config/nvim/lua/eric/init.lua`:

```lua
-- Add a new keybinding
vim.keymap.set("n", "<leader>x", function()
    vim.notify("Hello!")
end)

-- Or map to a command
vim.keymap.set("n", "<leader>y", vim.cmd.YCommand)
```

Restart Neovim for changes to take effect.

---

## Getting Help

- **Read docs**: See [KEYBINDINGS.md](./KEYBINDINGS.md) for full reference
- **Plugin docs**: `:help plugin-name`
- **Neovim docs**: `:help nvim`
- **View messages**: `:messages`

---

## Common Workflows

### Editing a Function
```vim
1. <leader>ps              Search for function name
2. <CR>                    Jump to it
3. c{motion}               Change text
4. <leader>tn              Check for errors
5. <leader>u               View undo history if needed
```

### Switching Between Files
```vim
1. <leader>a               (in each important file)
2. <C-e>                   View all marked files
3. <C-h>/<C-t>/etc.        Jump between them
```

### Searching and Replacing
```vim
1. <leader>ps              Search for text
2. <CR>                    Jump to match
3. :%s/old/new/g           Replace all
4. <leader>tn              Check for broken references
```

### Managing Errors
```vim
1. <leader>tt              Open error panel
2. <leader>tn              Jump to each error
3. Fix the error
4. Auto-saved diagnostics refresh
```

---

## Need More Details?

See the full documentation:
- [KEYBINDINGS.md](./KEYBINDINGS.md) — Complete binding reference
- [PLUGINS.md](./PLUGINS.md) — Plugin documentation
- [ARCHITECTURE.md](./ARCHITECTURE.md) — How configs are organized
- [SETUP.md](./SETUP.md) — Installation guide
- [TROUBLESHOOTING.md](./TROUBLESHOOTING.md) — Common issues
