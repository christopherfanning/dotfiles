# MCP Servers — Claude Code AI Skills

> MCP (Model Context Protocol) servers extend Claude Code with real-world capabilities — file access, GitHub, Docker, web search, and more.

## Setup

```bash
bin/setup-mcp.sh
```

Pre-set API keys for full coverage:

```bash
export GITHUB_TOKEN=ghp_...
export BRAVE_API_KEY=...    # free at api.search.brave.com
bash bin/setup-mcp.sh
```

Verify: `claude mcp list`

## Installed servers

| Server | Skill added | Needs key? |
|--------|------------|-----------|
| **filesystem** | Read/write files, search dirs, view trees | No |
| **git** | `git log`, diff, status, branch ops | No |
| **github** | PRs, issues, repo search, code search | `GITHUB_TOKEN` |
| **fetch** | HTTP requests — test APIs, fetch docs | No |
| **memory** | Persistent knowledge graph across sessions | No |
| **docker** | Manage containers, images, Compose stacks | No |
| **brave-search** | Real-time web search | `BRAVE_API_KEY` |
| **puppeteer** | Browser automation, screenshots, scraping | No |

## What each skill enables

### filesystem
Ask Claude to read multiple files, search for patterns, create/edit files — without copy-pasting content.

### git + github
"Summarise the last 10 commits", "What PRs are open?", "Show me the diff for PR #42" — all without leaving your editor.

### fetch
"Make a POST to this API with this payload", "Fetch and summarise this documentation page".

### memory
Claude builds a persistent knowledge graph. Tell it facts about your project once — it remembers them in future sessions.
> "Remember that this project uses MariaDB not Postgres"
> "What DB does this project use?" ← answered from memory next session

### docker
"List running containers", "Show logs for the wordpress container", "Pull the latest nginx image".

### brave-search
"Search for the latest Hyprland config options", "What's the syntax for Packer 1.11?" — real-time web results.

### puppeteer
"Screenshot my local WordPress site", "Test if the checkout form submits correctly" — headless browser automation.

## Add a server manually

```bash
claude mcp add <name> -- npx -y @modelcontextprotocol/server-<name>
claude mcp add <name> -e KEY=value -- npx -y @modelcontextprotocol/server-<name>
```

## Project-scoped MCP (`.mcp.json`)

Add an `.mcp.json` to a project root for project-specific servers (e.g. a local database):

```json
{
  "mcpServers": {
    "sqlite": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-sqlite", "./local.db"]
    }
  }
}
```
