-- AI tooling: codecompanion.nvim (orchestrator) + mcphub.nvim (MCP tools)
--
-- Keybinds (all under <leader>a alongside avante — no conflicts):
--   <leader>ao  open/toggle chat
--   <leader>ai  inline assist (works in visual too)
--   <leader>ap  action palette
--   <leader>au  MCP hub UI
--
-- Strategy:
--   chat/inline  → copilot (claude-sonnet)  — cloud, highest quality
--   agent        → ollama (qwen2.5-coder:7b) — local, fast, no cloud latency
--
-- Run bin/setup-local-ai.sh to pull ollama models before first use.

return {
  -- ── MCP Hub ────────────────────────────────────────────────────────────
  -- Manages MCP servers and exposes their tools/resources to chat plugins.
  {
    "ravitemer/mcphub.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    build = "npm install -g mcp-hub@latest",
    config = function()
      require("mcphub").setup({
        -- Local MCP servers can be added here.
        -- These complement the Claude Code MCP servers in setup-mcp.sh.
        -- Example: filesystem, RAG index, custom tools.
      })
    end,
    keys = {
      { "<leader>au", "<cmd>MCPHub<cr>", desc = "MCP Hub" },
    },
  },

  -- ── CodeCompanion ──────────────────────────────────────────────────────
  -- Primary AI orchestrator: chat, inline transforms, agentic tasks.
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/mcphub.nvim",
    },
    opts = {
      strategies = {
        -- Cloud: copilot for quality chat and inline edits
        chat   = { adapter = "copilot" },
        inline = { adapter = "copilot" },
        -- Local: ollama for agentic/tool tasks — no cloud latency
        agent  = { adapter = "ollama" },
      },
      adapters = {
        copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = { default = "claude-sonnet-4-5" },
            },
          })
        end,
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = { default = "qwen2.5-coder:7b" },
            },
          })
        end,
      },
      -- Expose MCP tools from mcphub into the chat
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = { show_result_in_chat = true },
        },
      },
    },
    keys = {
      { "<leader>ao", "<cmd>CodeCompanionChat Toggle<cr>",  desc = "Open AI chat",      mode = { "n", "v" } },
      { "<leader>ai", "<cmd>CodeCompanion<cr>",             desc = "Inline AI assist",   mode = { "n", "v" } },
      { "<leader>ap", "<cmd>CodeCompanionActions<cr>",      desc = "AI action palette",  mode = { "n", "v" } },
    },
  },
}
