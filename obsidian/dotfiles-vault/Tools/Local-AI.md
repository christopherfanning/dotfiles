# Local AI

Local inference stack using **Ollama** as the model server, **codecompanion.nvim** as the nvim AI
orchestrator, and **mcphub.nvim** to bridge MCP tools into the nvim AI workflow.

## Architecture

```
nvim
├── avante.nvim          ← diff/apply UI, copilot backend  (<leader>aa / <leader>at)
├── codecompanion.nvim   ← chat + inline + agents          (<leader>ao / <leader>ai / <leader>ap)
│   ├── chat adapter:    copilot → claude-sonnet  (cloud, quality)
│   ├── inline adapter:  copilot → claude-sonnet  (cloud)
│   └── agent adapter:   ollama → qwen2.5-coder:7b  (local, fast)
└── mcphub.nvim          ← MCP tool hub                    (<leader>au)

system
└── ollama               ← local inference server (localhost:11434)
    ├── qwen2.5-coder:7b   → agent tasks
    ├── qwen2.5-coder:14b  → high-quality local chat
    └── nomic-embed-text   → embeddings / RAG
```

## Hardware (little)

| Component | Spec |
|-----------|------|
| CPU | AMD Ryzen AI 9 HX 370, 12c/24t (Zen 5) |
| GPU | AMD Radeon 890M iGPU (16 CUs, RDNA 3.5) |
| NPU | AMD XDNA 2 (not yet supported by Ollama) |
| RAM | 27 GB |

Running Ollama in **CPU mode** for stability. The Radeon 890M shares system RAM, so there is no
discrete VRAM budget — all models load into system RAM.

## Model Choices

| Model | RAM | Use |
|-------|-----|-----|
| `qwen2.5-coder:7b` | ~4.7 GB | Agent adapter — fast local inference for tool calls |
| `qwen2.5-coder:14b` | ~8.7 GB | Local chat quality — best-in-class at this size |
| `nomic-embed-text` | ~300 MB | Embeddings for semantic search / RAG |

**Why qwen2.5-coder?** Best coding benchmark scores in the sub-20B class. Trained by Alibaba specifically
for code generation, explanation, and debugging. Fast on CPU with Q4 quantization.

**ROCm (AMD GPU acceleration):** Replace `ollama` with `ollama-rocm` (AUR) when the iGPU driver
support matures. Same CLI, same models — just faster. Check `ollama-rocm` AUR comments for current status.

## Setup

```bash
# 1. Install ollama (done by arch-install.sh)
yay -S ollama
sudo systemctl enable --now ollama

# 2. Pull models
bash bin/setup-local-ai.sh

# 3. Verify
ollama list
curl http://localhost:11434/api/tags
```

## Nvim Keybinds

All AI keybinds live under `<leader>a`:

| Key | Action | Plugin |
|-----|--------|--------|
| `<leader>aa` | Ask (inline) | avante |
| `<leader>at` | Toggle sidebar | avante |
| `<leader>ae` | Edit selection | avante |
| `<leader>ao` | Open/toggle chat | codecompanion |
| `<leader>ai` | Inline assist | codecompanion |
| `<leader>ap` | Action palette | codecompanion |
| `<leader>au` | MCP Hub UI | mcphub |

## MCP Integration

`mcphub.nvim` bridges MCP servers (the same ones configured via `setup-mcp.sh` for Claude Code)
into the nvim AI workflow. Tools available in codecompanion chat include filesystem, git, GitHub,
fetch, memory, docker, brave-search, and puppeteer.

Configure additional local-only MCP servers in `lua/plugins/ai.lua` → `mcphub.setup({ ... })`.

## Cloud vs Local Strategy

| Task | Adapter | Why |
|------|---------|-----|
| Complex code review | copilot (claude-sonnet) | Cloud — needs deep reasoning |
| Inline completions | copilot (claude-sonnet) | Cloud — low latency from Copilot infra |
| Agent tool calls | ollama (qwen2.5-coder:7b) | Local — avoid cloud cost per tool loop |
| Quick local queries | ollama (qwen2.5-coder:14b) | Local — offline, private, free |

## Files

| Path | Purpose |
|------|---------|
| `bin/arch-install.sh` | Installs `ollama` via yay |
| `bin/setup-local-ai.sh` | Pulls Ollama models |
| `src/nvim/dot-config/nvim/lua/plugins/ai.lua` | codecompanion + mcphub config |
