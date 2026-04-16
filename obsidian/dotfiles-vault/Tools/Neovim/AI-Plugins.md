# Neovim — AI Plugins

> Custom AI plugin config. File: `src/nvim/dot-config/nvim/lua/plugins/ai.lua`

## Overview

Two plugins work together:
- **CodeCompanion** — chat, inline transforms, agentic tasks (the orchestrator)
- **mcphub.nvim** — MCP server manager (exposes tool calls to the chat)

## Keybinds (all under `<leader>a`)

| Key | Action |
|-----|--------|
| `<leader>ao` | Open / toggle AI chat (normal + visual) |
| `<leader>ai` | Inline AI assist — transform selection or generate |
| `<leader>ap` | Action palette — slash commands, prompts |
| `<leader>au` | MCP Hub UI — manage MCP server connections |

## Strategy

| Context | Adapter | Why |
|---------|---------|-----|
| Chat | Copilot (claude-sonnet) | Cloud quality, conversational |
| Inline | Copilot (claude-sonnet) | Best for code edits |
| Agent | Ollama (qwen2.5-coder:7b) | Local, no cloud latency for tool loops |

## MCP integration

`mcphub.nvim` connects to MCP servers and exposes their tools inside the chat. Same MCP servers as Claude Code (configured in `bin/setup-mcp.sh`).

To set up local AI (Ollama):
```bash
bin/setup-local-ai.sh
```

## Copilot vs Avante vs CodeCompanion

| Plugin | Role |
|--------|------|
| `copilot` (LazyVim extra) | Ghost-text inline completions as you type |
| `avante` (LazyVim extra) | Sidebar diff-based AI edits |
| `codecompanion` (custom) | Chat, inline, agentic with MCP tools |

All three can be used simultaneously — they don't conflict.
