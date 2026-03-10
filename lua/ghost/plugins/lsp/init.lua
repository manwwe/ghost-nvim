-- lsp/init.lua
-- Entry point for all LSP-related plugins.
-- Requires Neovim >= 0.11

return {
  { import = "ghost.plugins.lsp.formatting" },
  { import = "ghost.plugins.lsp.linting" },
  { import = "ghost.plugins.lsp.completion" },

  -- Mason: installs and manages LSP servers, formatters and linters
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup({
        ui = { border = "rounded" },
      })
    end,
  },

  -- Auto-install tools defined in ensure_installed
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = "VeryLazy", -- load after everything else is ready
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          -- LSP servers
          "lua-language-server",
          "pyright",
          "typescript-language-server",
          "rust-analyzer",
          -- Formatters
          "prettier",
          "ruff",
          -- Linters
          "eslint_d",
        },
        auto_update = false,  -- don't auto update tools
        run_on_start = true,  -- install missing tools on startup
      })
    end,
  },

  -- Native LSP config using Neovim 0.11 API
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",                      -- needed for capabilities
      "williamboman/mason.nvim",                    -- ensure mason loads first
      "WhoIsSethDaniel/mason-tool-installer.nvim",  -- ensure tools are installed first
    },
    config = function()
      -- Extend default capabilities with nvim-cmp support
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Apply capabilities to all LSP servers before enabling them
      vim.lsp.config("*", { capabilities = capabilities })

      -- Enable servers defined in lsp/ root folder
      vim.lsp.enable({ "lua_ls", "pyright", "ts_ls", "rust_analyzer" })

      -- Keymaps applied only when LSP attaches to a buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "Set LSP keymaps on attach",
        callback = function(event)
          local map = vim.keymap.set
          local opts = function(desc)
            return { buffer = event.buf, silent = true, desc = desc }
          end

          -- Navigation
          map("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
          map("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
          map("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
          map("n", "gt", vim.lsp.buf.type_definition, opts("Go to type definition"))

          -- Documentation
          map("n", "K", vim.lsp.buf.hover, opts("Hover documentation"))

          -- Code actions
          map("n", "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
          map("n", "<leader>cr", vim.lsp.buf.rename, opts("Rename symbol"))

          -- Diagnostics
          map("n", "<leader>dd", vim.diagnostic.open_float, opts("Show diagnostic float"))
          map("n", "[d", vim.diagnostic.goto_prev, opts("Previous diagnostic"))
          map("n", "]d", vim.diagnostic.goto_next, opts("Next diagnostic"))
        end,
      })

      -- Diagnostic display config
      vim.diagnostic.config({
        virtual_text = false,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = true,
        },
      })
    end,
  },
}
