#!/usr/bin/env bash
# MCP Server setup for Claude Code
# Adds the most useful developer MCP servers globally.
# Re-running this script is safe — claude mcp add is idempotent.
#
# Prerequisites:
#   - Claude Code installed (claude CLI in PATH)
#   - Node.js / npx available (via nvm or mise)
#
# Usage:
#   bash bin/setup-mcp.sh
#
# For servers requiring API keys, set env vars first:
#   export GITHUB_TOKEN=ghp_...
#   export BRAVE_API_KEY=...

set -e

if ! command -v claude &>/dev/null; then
  echo "✗ claude CLI not found — install Claude Code first: https://claude.ai/download"
  exit 1
fi

if ! command -v npx &>/dev/null; then
  echo "✗ npx not found — install Node.js (nvm or mise) first"
  exit 1
fi

echo "==> Setting up MCP servers for Claude Code..."
echo ""

# ── Filesystem ────────────────────────────────────────────────────────────
# Read/write files, search directories, list trees.
# Scoped to home directory — adjust paths as needed.
echo "  [1/8] filesystem..."
claude mcp add filesystem -- \
  npx -y @modelcontextprotocol/server-filesystem "$HOME"

# ── Git ───────────────────────────────────────────────────────────────────
# git log, diff, status, branch info — without leaving Claude.
echo "  [2/8] git..."
claude mcp add git -- \
  npx -y @modelcontextprotocol/server-git

# ── GitHub ────────────────────────────────────────────────────────────────
# PRs, issues, repos, search — requires GITHUB_TOKEN.
echo "  [3/8] github..."
if [[ -n "$GITHUB_TOKEN" ]]; then
  claude mcp add github \
    -e GITHUB_TOKEN="$GITHUB_TOKEN" -- \
    npx -y @modelcontextprotocol/server-github
else
  echo "     ⚠ GITHUB_TOKEN not set — skipping github MCP."
  echo "     Set it and re-run, or: claude mcp add github -e GITHUB_TOKEN=<token> -- npx -y @modelcontextprotocol/server-github"
fi

# ── Fetch ─────────────────────────────────────────────────────────────────
# Make HTTP requests — test APIs, fetch docs, scrape pages.
echo "  [4/8] fetch..."
claude mcp add fetch -- \
  npx -y @modelcontextprotocol/server-fetch

# ── Memory ────────────────────────────────────────────────────────────────
# Persistent knowledge graph — Claude remembers facts across sessions.
echo "  [5/8] memory..."
claude mcp add memory -- \
  npx -y @modelcontextprotocol/server-memory

# ── Docker ────────────────────────────────────────────────────────────────
# Manage containers, images, compose stacks from within Claude.
echo "  [6/8] docker..."
claude mcp add docker -- \
  npx -y @modelcontextprotocol/server-docker

# ── Brave Search ──────────────────────────────────────────────────────────
# Real-time web search — requires BRAVE_API_KEY (free tier available).
# Get key: https://api.search.brave.com/
echo "  [7/8] brave-search..."
if [[ -n "$BRAVE_API_KEY" ]]; then
  claude mcp add brave-search \
    -e BRAVE_API_KEY="$BRAVE_API_KEY" -- \
    npx -y @modelcontextprotocol/server-brave-search
else
  echo "     ⚠ BRAVE_API_KEY not set — skipping brave-search MCP."
  echo "     Get a free key at https://api.search.brave.com/, then:"
  echo "     claude mcp add brave-search -e BRAVE_API_KEY=<key> -- npx -y @modelcontextprotocol/server-brave-search"
fi

# ── Puppeteer ─────────────────────────────────────────────────────────────
# Browser automation — scrape, test, screenshot web pages.
# Useful for WordPress development and visual regression testing.
echo "  [8/8] puppeteer..."
claude mcp add puppeteer -- \
  npx -y @modelcontextprotocol/server-puppeteer

echo ""
echo "✓ MCP servers configured."
echo ""
echo "Verify with: claude mcp list"
echo ""
echo "Servers requiring API keys (set token and re-run if skipped):"
echo "  github:       export GITHUB_TOKEN=ghp_..."
echo "  brave-search: export BRAVE_API_KEY=...   (free at api.search.brave.com)"
