# Claude Code Guidelines

Instructions for Claude when working on this Neovim configuration repository.

## Mandatory Rules (Read agents.md First)

**See [agents.md](../agents.md) for detailed guidelines.**

These rules are non-negotiable:

1. **Never commit to main branch** — Always use feature branches (`feat/`, `docs/`, `fix/`)
2. **Document all changes** — Update docs for every code change
3. **Use conventional commits** — Format: `type(scope): description`
4. **Explain WHY in commits** — Not just WHAT the code does

## Quick Reference

### Before Making Changes
```bash
# Check current branch
git status

# If on main, create feature branch
git checkout -b feature/my-feature
```

### Making Changes
1. Edit code/docs
2. Run `git diff` to review changes
3. Make sure docs match code changes
4. Commit with conventional format

### Conventional Commit Examples
```
feat(lsp): Add go-to-definition keybinding
fix(telescope): Handle empty file list
docs(setup): Clarify Python LSP installation
refactor(plugins): Extract common patterns
```

### Commit Checklist
- [ ] On feature branch (not main)
- [ ] All related docs updated
- [ ] Using conventional commit format
- [ ] Commit message explains WHY
- [ ] Only intended files changed

## Documentation Requirements

When you modify code, update these docs:

| Change Type | Update These Docs |
|-------------|-------------------|
| New keybinding | `docs/KEYBINDINGS.md`, `docs/CHEATSHEET.md` |
| New plugin | `docs/PLUGINS.md`, `docs/ARCHITECTURE.md` |
| New language server | `docs/SETUP.md`, `docs/PLUGINS.md` |
| Bug fix | `docs/TROUBLESHOOTING.md` (if applicable) |
| Architecture change | `docs/ARCHITECTURE.md` |
| Setup change | `docs/SETUP.md` |

## File Structure

```
nvim-config/
├── agents.md                 # Agent rules (this applies to you!)
├── .claude/
│   └── CLAUDE.md            # This file
├── README.md                # Main overview
├── docs/
│   ├── KEYBINDINGS.md      # All keybindings
│   ├── PLUGINS.md          # Plugin documentation
│   ├── SETUP.md            # Installation guide
│   ├── ARCHITECTURE.md     # Project structure
│   ├── TROUBLESHOOTING.md  # Common issues
│   ├── CHEATSHEET.md       # Quick reference
│   ├── MARKDOWN_VIEWER.md  # Viewing docs
│   └── IMPROVEMENTS.md     # Future roadmap
└── lua/
    ├── config/             # Config setup
    ├── plugins/            # Individual plugin configs
    └── eric/               # Personal settings
```

## Workflow Example

### Scenario: Adding a New Plugin

```bash
# 1. Create feature branch
git checkout -b feat/add-comment-plugin

# 2. Create plugin file
cat > lua/plugins/comment.lua << 'EOF'
return {
    "numToStr/Comment.nvim",
    config = function()
        require("Comment").setup()
    end,
}
EOF

# 3. Update docs/PLUGINS.md
# (Add section describing comment plugin)

# 4. Update docs/KEYBINDINGS.md
# (Add <leader>/ for toggle comment)

# 5. Review changes
git diff

# 6. Commit
git commit -m "feat(comment): Add comment.nvim for easy line commenting

- Provides <leader>/ to toggle comments
- Works in normal and visual mode
- Supports multiple languages via Treesitter
- See docs/PLUGINS.md for configuration options"

# 7. Verify
git log -1
```

## Rules to Follow

### ✅ DO:
- Create feature branches for all work
- Use conventional commit format
- Update documentation when making changes
- Run `git diff` before committing
- Explain the WHY in commit messages
- Keep commits focused and small
- Link related documentation files

### ❌ DON'T:
- Commit directly to main branch
- Make code changes without updating docs
- Use vague commit messages
- Combine unrelated changes in one commit
- Leave commented-out code
- Commit without reviewing with `git diff`
- Create mega-commits with many changes

## Documentation Style

When updating docs:
- Use clear, concise language
- Include examples and code snippets
- Link to related documentation
- Add troubleshooting tips if applicable
- Update modification dates
- Keep markdown formatting consistent

## Getting Help

If you're unsure:
1. Read [agents.md](../agents.md) for detailed rules
2. Check existing commits for patterns: `git log --oneline -20`
3. Review documentation structure in `docs/`
4. Look at similar changes in git history

## When in Doubt

**Always ask the user** rather than:
- Committing to main
- Making large architectural changes without planning
- Deleting code without understanding impact
- Combining multiple unrelated changes

---

**These rules exist to:**
- Keep the main branch stable
- Make code reviews easier
- Maintain clear documentation
- Help future developers understand changes
- Prevent accidental breaking changes

**Remember**: A commit message is a conversation with future developers (including your future self).

See [agents.md](../agents.md) for the complete detailed guidelines.
