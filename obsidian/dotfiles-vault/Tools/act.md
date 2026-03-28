# act — Run GitHub Actions Locally

> Test and debug your `.github/workflows/*.yml` files locally before pushing.

## Why act

- Catch CI failures before wasting pipeline minutes
- Fast feedback loop — no commit-push-wait cycle
- Uses Docker to run the same runner images as GitHub Actions
- Supports secrets, env vars, and event payloads

## Prerequisites

Docker must be running.

## Usage

```bash
act                          # run the default (push) event
act push                     # explicit push event
act pull_request             # simulate a PR trigger
act -j build                 # run only the 'build' job
act -n                       # dry run — shows what would run
act --secret-file .secrets   # pass secrets from a file
act -W .github/workflows/ci.yml   # specific workflow file
```

## First run

On first run, act will prompt to choose a runner image size:
- **Micro** — minimal, fast, good for simple scripts
- **Medium** — includes common tools (recommended for most workflows)
- **Large** — full GitHub runner image (~18GB)

## Secrets file

```bash
# .secrets (add to .gitignore!)
MY_TOKEN=ghp_...
DEPLOY_KEY=...
```

```bash
act --secret-file .secrets
```
