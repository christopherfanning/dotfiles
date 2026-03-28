# GitHub Copilot in Neovim

> Inline AI completions + chat, via LazyVim's official Copilot extras.

## Extras enabled (`lazyvim.json`)

```json
"lazyvim.plugins.extras.ai.copilot"       // inline completions
"lazyvim.plugins.extras.ai.copilot-chat"  // chat interface
"lazyvim.plugins.extras.ai.claudecode"    // Claude Code (agentic)
```

## How they complement each other

| Tool | Style | Best for |
|------|-------|---------|
| **Copilot** | Inline ghost-text suggestions | Autocomplete while typing |
| **Copilot Chat** | Chat panel (`<leader>aa`) | Explain, refactor, generate |
| **Claude Code** | Agentic (edits files) | Complex multi-file tasks |

## First-time setup

Open nvim after installing — lazy.nvim will auto-install the plugins. Then:

```
:Copilot auth
```

Follow the device auth flow in your browser. You only need to do this once.

## Key bindings (LazyVim defaults)

| Key | Action |
|-----|--------|
| `Tab` | Accept Copilot suggestion |
| `<leader>aa` | Open Copilot Chat |
| `<leader>ac` | Chat with context |
