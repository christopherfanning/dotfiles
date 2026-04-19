-- JavaScript / TypeScript DAP (debugger) via vscode-js-debug
--
-- Mason installs: js-debug-adapter (Microsoft's vscode-js-debug binary)
-- Adapter:        nvim-dap-vscode-js (bridges nvim-dap → js-debug-adapter)
--
-- Supports: Node.js scripts, Jest tests, Chrome/browser debugging
-- Filetypes: javascript, typescript, javascriptreact, typescriptreact
--
-- Usage:
--   <leader>db   toggle breakpoint
--   <leader>dc   start / continue
--   <leader>du   toggle DAP UI
--   See :h dap for full reference

return {
  -- ── Adapter bridge ───────────────────────────────────────────────────────
  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dap-vscode-js").setup({
        -- Mason installs the adapter here
        debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
        debugger_cmd  = { "js-debug-adapter" },
        adapters      = { "pwa-node", "pwa-chrome", "node-terminal" },
      })

      local js_filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" }

      for _, ft in ipairs(js_filetypes) do
        require("dap").configurations[ft] = {
          -- ── Node.js: run the current file ──────────────────────────────
          {
            type    = "pwa-node",
            request = "launch",
            name    = "Launch file (node)",
            program = "${file}",
            cwd     = "${workspaceFolder}",
            sourceMaps = true,
          },
          -- ── Node.js: attach to a running process ───────────────────────
          -- Start your app with: node --inspect src/index.js
          {
            type      = "pwa-node",
            request   = "attach",
            name      = "Attach to process (node)",
            processId = require("dap.utils").pick_process,
            cwd       = "${workspaceFolder}",
            sourceMaps = true,
          },
          -- ── Jest: debug a test file ────────────────────────────────────
          {
            type    = "pwa-node",
            request = "launch",
            name    = "Debug Jest tests",
            runtimeExecutable = "node",
            runtimeArgs = {
              "./node_modules/.bin/jest",
              "--runInBand",
              "--testPathPattern",
              "${file}",
            },
            cwd     = "${workspaceFolder}",
            console = "integratedTerminal",
            sourceMaps = true,
          },
          -- ── Chrome: attach to a running browser tab ────────────────────
          -- Start Chrome/Chromium with: --remote-debugging-port=9222
          {
            type    = "pwa-chrome",
            request = "attach",
            name    = "Attach to Chrome (port 9222)",
            port    = 9222,
            webRoot = "${workspaceFolder}",
            sourceMaps = true,
          },
        }
      end
    end,
  },

  -- ── Mason: ensure js-debug-adapter is installed ──────────────────────────
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "js-debug-adapter" })
    end,
  },
}
