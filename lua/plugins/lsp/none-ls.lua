-- Configures nvimtools/none-ls.nvim for integrating formatters and linters into Neovim's LSP client.

return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",                   -- Extra built-in sources for none-ls.
    { "williamboman/mason.nvim", version = "1.11.0" }, -- Tool manager.
    "jay-babu/mason-null-ls.nvim",                     -- Integrates Mason with none-ls.
    "gbprod/none-ls-shellcheck.nvim",                  -- Shellcheck integration.
  },
  config = function()
    -- Load configuration modules
    local constants = require("plugins.lsp.none-ls-config.constants")
    local sources = require("plugins.lsp.none-ls-config.sources")

    -- Setup Mason
    require("mason").setup()

    -- Setup mason-null-ls to manage tools
    require("mason-null-ls").setup({
      ensure_installed = constants.tools,
      automatic_installation = true,
    })

    -- Setup none-ls with sources (formatting handled by lspconfig module)
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = sources.get_sources(),
    })
  end,
}

