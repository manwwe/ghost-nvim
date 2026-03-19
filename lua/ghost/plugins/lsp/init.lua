-- Configures LSP servers, diagnostics, and keymaps.

return {
  { import = "ghost.plugins.lsp.completion" },
  { import = "ghost.plugins.lsp.formatting" },
  { import = "ghost.plugins.lsp.linting" },

  {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "lua_ls",
        "pyright",
        "rust_analyzer",
        "ts_ls",
      },
      automatic_enable = false,
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "mason-org/mason.nvim",
    },
    opts = {
      ensure_installed = {
        "eslint_d",
        "prettier",
        "ruff",
        "stylua",
        "taplo",
      },
      auto_update = false,
      run_on_start = true,
      start_delay = 3000,
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local servers = {
        "lua_ls",
        "pyright",
        "rust_analyzer",
        "ts_ls",
      }

      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      for _, server in ipairs(servers) do
        vim.lsp.enable(server)
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP keymaps",
        callback = function(event)
          local map = vim.keymap.set
          local opts = function(desc)
            return { buffer = event.buf, silent = true, desc = desc }
          end

          map("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
          map("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
          map("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
          map("n", "gt", vim.lsp.buf.type_definition, opts("Go to type definition"))
          map("n", "gr", vim.lsp.buf.references, opts("List references"))
          map("n", "K", vim.lsp.buf.hover, opts("Hover documentation"))
          map("n", "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
          map("n", "<leader>cr", vim.lsp.buf.rename, opts("Rename symbol"))
          map("n", "<leader>dd", vim.diagnostic.open_float, opts("Show diagnostics"))
          map("n", "[d", vim.diagnostic.goto_prev, opts("Previous diagnostic"))
          map("n", "]d", vim.diagnostic.goto_next, opts("Next diagnostic"))
        end,
      })

      local signs = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN] = "",
        [vim.diagnostic.severity.INFO] = "",
        [vim.diagnostic.severity.HINT] = "󰌵",
      }

      vim.diagnostic.config({
        virtual_text = false,
        signs = {
          text = signs,
        },
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
