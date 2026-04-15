-- Configures LSP servers, diagnostics, and keymaps.

return {
  { import = "ghost.plugins.lsp.completion" },
  { import = "ghost.plugins.lsp.formatting" },
  { import = "ghost.plugins.lsp.linting" },

  {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    opts = function()
      return {
        ui = {
          border = require("ghost.utils.ui").border.default,
        },
      }
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = function()
      return {
        ensure_installed = require("ghost.config.lang_tools").lsp_servers,
        automatic_enable = false,
      }
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "mason-org/mason.nvim",
    },
    opts = function()
      return {
        ensure_installed = require("ghost.config.lang_tools").mason_tools,
        auto_update = false,
        run_on_start = true,
        start_delay = 3000,
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      local keymap = require "ghost.utils.keymap"
      local lang_tools = require "ghost.config.lang_tools"
      local ui = require "ghost.utils.ui"
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      for _, server in ipairs(lang_tools.enabled_lsp_servers or lang_tools.lsp_servers) do
        vim.lsp.enable(server)
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP keymaps",
        callback = function(event)
          keymap.buf_map(event.buf, "n", "gd", vim.lsp.buf.definition, "Go to definition")
          keymap.buf_map(event.buf, "n", "gD", vim.lsp.buf.declaration, "Go to declaration")
          keymap.buf_map(event.buf, "n", "gri", vim.lsp.buf.implementation, "Go to implementation")
          keymap.buf_map(event.buf, "n", "grt", vim.lsp.buf.type_definition, "Go to type definition")
          keymap.buf_map(event.buf, "n", "<leader>dd", vim.diagnostic.open_float, "Show diagnostics")
        end,
      })

      vim.diagnostic.config({
        virtual_text = false,
        signs = {
          text = ui.diagnostic_signs,
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = ui.border.default,
          source = true,
        },
      })
    end,
  },
}
