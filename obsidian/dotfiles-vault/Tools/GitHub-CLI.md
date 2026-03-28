# GitHub CLI (gh)

> Official GitHub CLI — manage PRs, issues, repos, Actions, Gists from the terminal.

## Why gh

- Create and review PRs without leaving the terminal
- `gh pr checkout <number>` — check out any PR branch instantly
- Pairs with the `octo.nvim` LazyVim extra for in-editor GitHub integration
- Auth once: `gh auth login`, then all tools (including `git push`) use it

## Key Commands

```bash
gh pr list                    # list open PRs
gh pr create                  # open PR for current branch
gh pr checkout <number>       # check out a PR locally
gh pr review --approve        # approve a PR
gh issue list                 # list issues
gh issue create               # create an issue
gh repo clone <org/repo>      # clone any repo
gh run list                   # list CI runs
gh run watch                  # watch a CI run in real-time
gh gist create <file>         # create a gist
```

## Auth

```bash
gh auth login    # follow prompts; choose SSH key
```
