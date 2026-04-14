#!/usr/bin/env bash
# Local AI setup — pulls Ollama models for use with codecompanion.nvim
#
# Architecture:
#   - qwen2.5-coder:7b    → agent adapter (fast, local, ~4.7GB RAM)
#   - qwen2.5-coder:14b   → chat adapter fallback / quality tasks (~8.7GB RAM)
#   - nomic-embed-text    → embeddings for RAG / semantic search (~300MB)
#
# System: AMD Ryzen AI 9 HX 370, 27GB RAM, Radeon 890M (iGPU)
# Running in CPU mode for stability. For AMD GPU acceleration:
#   yay -S ollama-rocm   (replace the ollama package, same CLI)
#
# Usage:
#   bash bin/setup-local-ai.sh

set -e

if ! command -v ollama &>/dev/null; then
  echo "✗ ollama not found — run bin/arch-install.sh first"
  exit 1
fi

# Ensure the ollama service is running
if ! systemctl is-active --quiet ollama 2>/dev/null; then
  echo "==> Starting ollama service..."
  sudo systemctl start ollama
  sleep 2
fi

echo "==> Pulling Ollama models..."
echo ""

# ── Agent adapter (fast local inference) ─────────────────────────────────
echo "  [1/3] qwen2.5-coder:7b  (agent tasks — ~4.7GB)..."
ollama pull qwen2.5-coder:7b

# ── Chat adapter fallback (higher quality local) ─────────────────────────
echo "  [2/3] qwen2.5-coder:14b  (quality chat — ~8.7GB)..."
ollama pull qwen2.5-coder:14b

# ── Embeddings for RAG ────────────────────────────────────────────────────
echo "  [3/3] nomic-embed-text  (embeddings/RAG — ~300MB)..."
ollama pull nomic-embed-text

echo ""
echo "✓ Models ready. Verify with: ollama list"
echo ""
echo "Models in use:"
echo "  codecompanion agent adapter  → qwen2.5-coder:7b   (local, <leader>ao)"
echo "  codecompanion chat quality   → qwen2.5-coder:14b  (local fallback)"
echo "  embeddings / RAG             → nomic-embed-text"
echo ""
echo "Cloud adapters (no setup needed — uses existing credentials):"
echo "  codecompanion chat/inline    → copilot → claude-sonnet"
