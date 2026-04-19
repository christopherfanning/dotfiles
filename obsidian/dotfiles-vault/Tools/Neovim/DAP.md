# Neovim — DAP (Debugger)

> Debug Adapter Protocol for JavaScript/TypeScript. Files: `lua/plugins/dap-js.lua`, `lazyvim.json`

## Stack

```
nvim-dap  (client)
  │
nvim-dap-ui           — panels: variables, call stack, watches, REPL
nvim-dap-virtual-text — inline values next to variables in the buffer
  │
nvim-dap-vscode-js    — bridge to Microsoft's js-debug-adapter
  │
js-debug-adapter      — installed via Mason (same engine VS Code uses)
  │
Node.js / Chrome process
```

## Keybinds (`<leader>d`)

| Key | Action |
|-----|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Conditional breakpoint (prompt for condition) |
| `<leader>dc` | Continue / start debugging |
| `<leader>dC` | Run to cursor |
| `<leader>di` | Step into |
| `<leader>do` | Step over |
| `<leader>dO` | Step out |
| `<leader>du` | Toggle DAP UI panels |
| `<leader>dr` | Open REPL |
| `<leader>dw` | Hover — show value of word under cursor |
| `<leader>dl` | Run last debug config again |

## Launch configs (JS/TS)

Four configs are registered — `<leader>dc` prompts to choose:

| Config | What it does |
|--------|-------------|
| **Launch file (node)** | Runs the current file with node |
| **Attach to process** | Shows running node processes to pick from |
| **Debug Jest tests** | Runs Jest with `--runInBand` on the current test file |
| **Attach to Chrome** | Connects to Chrome on port 9222 (needs `--remote-debugging-port=9222`) |

## Typical workflow

### Debug a Node script

```
<leader>db   — set a breakpoint on the line you care about
<leader>dc   — pick "Launch file (node)" → debugger starts
              → execution pauses at breakpoint
<leader>du   — open the UI (variables panel on left, call stack below)
K            — hover any variable to see its value
<leader>dr   — open REPL to eval expressions in the paused scope
<leader>do   — step over to the next line
<leader>dO   — step out of current function
<leader>dc   — continue to next breakpoint or end
```

### Debug running process (e.g. `node --inspect src/server.js`)

```bash
node --inspect src/server.js   # start with inspect flag
```

Then in Neovim: `<leader>dc` → "Attach to process" → pick the PID.

### Debug Chrome/browser app

```bash
google-chrome-stable --remote-debugging-port=9222 http://localhost:3000
```

Then: `<leader>dc` → "Attach to Chrome (port 9222)".

## First-time setup

Mason auto-installs `js-debug-adapter` on next Neovim launch. Check status:

```
:Mason   → search "js-debug"
```

Or trigger manually: `:MasonInstall js-debug-adapter`

## DAP UI layout

When you `<leader>du`, the UI opens with:

| Panel | Contents |
|-------|---------|
| Left sidebar | Local variables, scopes |
| Bottom left | Call stack |
| Bottom middle | Watches (expressions you add) |
| Bottom right | REPL |
| Breakpoints | Listed in sidebar |
