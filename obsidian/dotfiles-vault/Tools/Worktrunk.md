# Worktrunk — Git Worktree Manager

> CLI for git worktree management, designed for running parallel AI agents (Claude Code, Codex, etc.) without stepping on each other's changes.

📚 Full docs: [worktrunk.dev](https://worktrunk.dev)

## Why Worktrunk

Git's native worktree feature lets you check out multiple branches simultaneously — each in its own directory. The problem: the UX is terrible. Starting a single worktree requires typing the branch name three times: `git worktree add -b feat ../repo.feat && cd ../repo.feat`.

Worktrunk reduces this to `wt switch -c feat`. That's the whole pitch — worktrees as easy as branches, plus workflow automation on top.

The killer use case in 2026: running 5–10 Claude Code agents in parallel, each working on a different feature in its own isolated worktree.

## Install

```bash
sudo pacman -S worktrunk
wt config shell install   # adds wt() shell wrapper so cd works
```

The shell wrapper (`wt()` function in `.zshrc`) is what allows `wt switch` to actually change your current directory — plain binaries can't do this.

## Core Commands

| Command | What it does |
|---------|-------------|
| `wt switch feat` | Switch to worktree for branch `feat` |
| `wt switch -c feat` | Create branch + worktree, switch to it |
| `wt switch -c -x claude feat` | Create worktree, launch `claude` in it |
| `wt list` | List all worktrees with status |
| `wt list --full` | Add CI status + AI-generated summaries |
| `wt remove` | Remove current worktree + branch |
| `wt merge main` | Squash → rebase → merge → clean up |
| `wt switch pr:123` | Check out a PR's branch in a new worktree |

## Developer Workflow

### Solo feature work

```bash
# Start a feature
wt switch -c feat/user-auth

# Work, commit normally, push
git add -p
git commit -m "Add JWT middleware"
git push -u origin feat/user-auth

# Open PR via gh, then after merge:
wt remove
```

### Parallel AI agents (the main event)

Spin up multiple agents on separate features simultaneously:

```bash
wt switch -c -x 'copilot --resume' feat/auth     -- 'Add user authentication'
wt switch -c -x 'copilot --resume' feat/pagination -- 'Fix the pagination bug'
wt switch -c -x 'copilot --resume' feat/api-tests  -- 'Write tests for the REST API'
```

Each agent gets its own clean working directory. Check on all of them:

```bash
wt list
#   Branch           Status    HEAD±   main↕   Age    Message
# @ feat/auth        +  ↑    +45 -3   ↑3      20m    Add JWT middleware
#   feat/pagination  +        +12 -1   ↑1      1h     Fix offset calculation
#   feat/api-tests      ↑    +89      ↑7      3h     Add REST API test suite
#   main             ^⇡                        2d     Initial commit
```

### Merge finished work

```bash
# Switch to the finished worktree
wt switch feat/auth

# Squash commits, rebase onto main, fast-forward merge, remove worktree — all in one
wt merge main
```

The merge pipeline: `pre-commit` hook → squash commit → `post-commit` → rebase → `pre-merge` → fast-forward to main → `pre-remove` / `post-remove` → switch back to main. All hooks run automatically.

### Review a PR locally

```bash
wt switch pr:123     # checks out PR branch in its own worktree
# review, comment, done
wt remove
```

## Hooks — Automating the Lifecycle

Hooks run shell commands at lifecycle events. Define them in:
- **User config** (`~/.config/worktrunk/config.toml`) — applies to all repos, no approval needed
- **Project config** (`.config/wt.toml` in repo root) — repo-specific, requires one-time approval

### Common hook patterns

**Copy caches on new worktree** (skip cold `npm install` / `cargo build`):
```toml
# .config/wt.toml
[post-start]
copy-node = "[ -d '{{ base_worktree_path }}/node_modules' ] && cp -r '{{ base_worktree_path }}/node_modules' . || true"
copy-cargo = "[ -d '{{ base_worktree_path }}/target' ] && cp -r '{{ base_worktree_path }}/target' . || true"
```

**Auto-install deps on create**:
```toml
[pre-start]
install = "npm ci"
```

**Run tests before merge**:
```toml
[pre-merge]
test = "npm test"
lint = "eslint src"
```

**Start dev server with unique port per worktree** (`hash_port` derives a stable port from the branch name):
```toml
[post-start]
dev = "npm run dev -- --port {{ branch | hash_port }}"
```

**Stop dev server on remove**:
```toml
[post-remove]
stop = "kill $(lsof -ti:{{ branch | hash_port }}) 2>/dev/null || true"
```

### Hooks run order during `wt merge`

`pre-commit` → commit → `post-commit` → rebase → `pre-merge` → merge → `pre-remove` → `post-remove` + `post-merge`

## LLM Commit Messages

Worktrunk can generate commit messages from your diff:

```bash
wt step commit    # stages all changes, generates message, commits
```

Requires `ANTHROPIC_API_KEY` or `OPENAI_API_KEY` in your environment. Enable globally:

```toml
# ~/.config/worktrunk/config.toml
[commit]
llm = true
```

## Worktree Path Template

By default, worktrees are created as siblings of the repo: `../repo.branchname`. Customise in config:

```toml
# Put worktrees in a dedicated ~/worktrees/ directory
worktree_path = "~/worktrees/{{ repo }}/{{ branch | slugify }}"
```

## Tips

- **`wt list`** is your dashboard — run it often to see what all your worktrees are doing
- **`wt switch` with no args** opens the interactive picker (fzf-style) with live diff/log preview
- **`wt merge` over manual rebase** — it handles squash, rebase, merge, and cleanup atomically, and runs all your hooks
- **`--no-verify`** skips all hooks when you need to move fast
- **Use `gh pr create` after `wt step commit`** for the cleanest PR workflow: worktrunk handles the commit, gh handles the PR
- **`.config/wt.toml` belongs in the repo** — commit it so the whole team gets the same hooks
- **User hooks are always trusted**; project hooks need one-time approval per command (security feature)

## Integration with this stack

| Tool | How it fits |
|------|------------|
| Claude Code / Copilot | `wt switch -c -x copilot feat` — agent gets isolated worktree |
| Lazygit | Open inside any worktree for visual git |
| tmux + sessionx | One tmux session per worktree is a natural fit |
| `gh` (GitHub CLI) | `gh pr create` + `wt remove` = clean PR workflow |
| `atuin` | Full history of `wt` commands searchable via Ctrl+R |

## Related

- [[Tools/Lazygit]] — visual git TUI, works great inside a worktree
- [[Tools/GitHub-CLI]] — `gh pr create` is the natural companion to `wt merge`
- [[MCP-Servers]] — Claude Code benefits most from parallel worktrees
