# Agent Rules & Guidelines

This document defines rules for AI agents (Claude) working on this Neovim config repository.

## Core Principles

### 1. Never Commit to Main Branch
- **Rule**: All work must be done on feature branches
- **Pattern**: `feature/name`, `docs/name`, `fix/name`, `refactor/name`
- **How**: Always checkout a new branch before making changes
  ```bash
  git checkout -b feature/my-feature
  # or
  git checkout -b docs/add-keybinding-docs
  ```
- **Exception**: Only merge to main via pull request review (when available)
- **Why**: Keeps main stable and reviewable

### 2. Document All Changes
- **Rule**: Every code change must have corresponding documentation update
- **Where**: Update relevant `.md` files in `docs/` folder
- **Examples**:
  - Added keybinding? → Update `docs/KEYBINDINGS.md`
  - New plugin? → Update `docs/PLUGINS.md` and `docs/ARCHITECTURE.md`
  - Breaking change? → Update `README.md` and `docs/SETUP.md`
  - Fixed a bug? → Update `docs/TROUBLESHOOTING.md` if relevant
  - Improved architecture? → Update `docs/ARCHITECTURE.md`

### 3. Use Conventional Commits
- **Format**: `type(scope): description`
- **Types**:
  - `feat:` New feature
  - `fix:` Bug fix
  - `docs:` Documentation only
  - `style:` Code style (formatting, semicolons, etc.)
  - `refactor:` Code refactoring
  - `perf:` Performance improvement
  - `test:` Test-related changes
  - `chore:` Build, dependencies, tooling

- **Examples**:
  ```
  feat(lsp): Add keybindings for go-to-definition
  fix(telescope): Handle empty search results
  docs(setup): Add Windows installation instructions
  refactor(plugins): Extract common config patterns
  ```

- **Scope**: Optional but recommended (which plugin/feature)
- **Description**: Imperative, lowercase, no period at end
- **Body**: Explain WHY, not WHAT (the code shows what)

### 4. Structure

#### Git Commits
```
feat(plugin-name): Brief description

Longer explanation of the change and why it was made.
This helps reviewers understand the intent.

- Bullet points for multiple changes
- Can reference issues or decisions
```

#### Documentation
- Keep docs in `docs/` folder
- One topic per file
- Include examples and use cases
- Link related docs together
- Update related files when making changes

#### Code
- One plugin per file in `lua/plugins/`
- Clear configuration in each plugin
- Add comments only for non-obvious WHY
- Follow existing patterns in the codebase

### 5. When Adding Features

**Before** coding:
1. Create feature branch
2. Update relevant documentation PLAN
3. Note expected changes in commit message

**During** coding:
1. Make code changes
2. Update documentation
3. Test changes locally

**After** coding:
1. Verify git logs are clear
2. Check all docs are updated
3. Run `git status` to see final state
4. Create pull request (if review available)

### 6. When Making Documentation-Only Changes

- Use `docs:` prefix in commits
- Update multiple `.md` files if needed
- One commit per logical doc change (or bundle related changes)

Examples:
```bash
git commit -m "docs: Add keybinding reference for new plugin"
git commit -m "docs: Improve setup guide for macOS"
git commit -m "docs: Add troubleshooting section for LSP issues"
```

### 7. Commit Message Checklist

Before committing, verify:
- [ ] Branch is NOT main
- [ ] Conventional commit format used
- [ ] All related docs are updated
- [ ] Description explains WHY, not just WHAT
- [ ] No secrets or sensitive info committed
- [ ] All changes are intentional (run `git diff` to verify)

### 8. Code Review Checklist

When reviewing own work:
- [ ] Does the code match the commit message?
- [ ] Are all docs updated?
- [ ] Are there typos in comments or docs?
- [ ] Is the change minimal (not over-engineered)?
- [ ] Does it follow existing patterns?
- [ ] Is there any dead code to remove?

## Example Workflow

```bash
# 1. Start new work on feature branch
git checkout -b feat/add-formatting

# 2. Make code changes
# Edit lua/plugins/formatting.lua

# 3. Update docs
# Edit docs/PLUGINS.md to describe new plugin
# Edit docs/KEYBINDINGS.md to add formatting shortcuts

# 4. Review before committing
git diff          # Check all changes
git status        # Verify only intended files changed

# 5. Commit with clear message
git commit -m "feat(formatting): Add auto-formatting with conform.nvim

- Auto-format on save for Lua, Python, JavaScript
- Configure formatters in lua/plugins/formatting.lua
- Add <leader>f to manually format current buffer
- See docs/PLUGINS.md for configuration options"

# 6. Verify commit
git log -1        # Check the commit
```

## Documentation Update Examples

### Adding a New Plugin

1. **Code**: Create `lua/plugins/my-plugin.lua`
2. **Docs**:
   - Add entry in `docs/PLUGINS.md` with section for the plugin
   - Add keybindings in `docs/KEYBINDINGS.md` if applicable
   - Update `docs/ARCHITECTURE.md` if structure changes
   - Update `README.md` if it's a major feature

### Changing a Keybinding

1. **Code**: Update `lua/eric/init.lua` or plugin file
2. **Docs**: Update `docs/KEYBINDINGS.md` and `docs/CHEATSHEET.md`

### Fixing a Bug

1. **Code**: Fix the bug
2. **Docs**: 
   - Add to `docs/TROUBLESHOOTING.md` if it's a known issue
   - Update `docs/PLUGINS.md` if it affects how a plugin works

### Improving Documentation

1. **Docs**: Update relevant `.md` files
2. **Commit**: `docs(topic): Improve clarity and add examples`

## Merge to Main

When ready to merge (requires branch protection):
1. All commits use conventional format
2. All docs are updated
3. Code follows existing patterns
4. No breaking changes without migration path
5. Minimal, focused changes (not mega-commits)

## Documentation System

This repository maintains comprehensive documentation to keep the config usable and maintainable.

### Documentation Files

| File | Purpose |
|------|---------|
| `README.md` | Project overview, quick start, feature summary |
| `docs/CHEATSHEET.md` | Quick reference for most-used keybindings and commands |
| `docs/KEYBINDINGS.md` | Complete reference for all keybindings organized by plugin |
| `docs/PLUGINS.md` | Detailed docs for each plugin: how to use, configure, extend |
| `docs/SETUP.md` | Step-by-step installation for macOS, Linux, Windows |
| `docs/ARCHITECTURE.md` | Project structure, design patterns, how to add plugins |
| `docs/TROUBLESHOOTING.md` | Common issues, causes, and solutions |
| `docs/MARKDOWN_VIEWER.md` | How to view and navigate docs within Neovim |
| `docs/IMPROVEMENTS.md` | Roadmap with 20+ enhancement ideas and priorities |
| `agents.md` | These rules — agent guidelines and conventions |
| `.claude/CLAUDE.md` | Claude-specific workflow and quick reference |

### Documentation First Principle

Documentation is not an afterthought — it's part of the code change.

**Every code change requires documentation updates.** This is not optional.

Example matrix:

```
Code Change                          → Update These Docs
─────────────────────────────────────────────────────────────
Add new plugin                       → PLUGINS.md, ARCHITECTURE.md
Add/change keybinding                → KEYBINDINGS.md, CHEATSHEET.md
Change setup/installation            → SETUP.md, README.md
Fix a bug                            → TROUBLESHOOTING.md (if relevant)
Optimize performance                 → IMPROVEMENTS.md
Refactor code structure              → ARCHITECTURE.md
Add language server                  → PLUGINS.md, SETUP.md
Change default behavior              → KEYBINDINGS.md, ARCHITECTURE.md
```

### Viewing Documentation in Neovim

Users can read all docs directly in Neovim:

```bash
nvim README.md
nvim docs/CHEATSHEET.md
nvim docs/KEYBINDINGS.md
# etc...
```

See `docs/MARKDOWN_VIEWER.md` for how to set up better markdown viewing with plugins.

### Documentation Quality Standards

When writing or updating docs:

✅ **DO:**
- Write clearly for users unfamiliar with the feature
- Include examples and code snippets
- Link to related docs with `[Link](path/to/file.md)`
- Add troubleshooting sections when relevant
- Keep formatting consistent with existing docs
- Add context about WHY something works that way
- Include both beginner and advanced usage

❌ **DON'T:**
- Leave typos or grammar errors
- Write docs that are outdated compared to code
- Include sensitive information (passwords, tokens)
- Create orphaned docs without linking them
- Write overly technical without explaining basics
- Mix multiple unrelated topics in one doc

## References

- [Conventional Commits](https://www.conventionalcommits.org/)
- [Git branching strategy](https://git-scm.com/book/en/v2/Git-Branching-Branching-Workflows)
- [Project Documentation](./docs/)

---

**Last Updated**: October 2, 2026  
**Applies To**: All Claude Code sessions and contributors
**See Also**: [.claude/CLAUDE.md](./.claude/CLAUDE.md) for Claude-specific guidelines
