-- LSP configuration using nvim-lspconfig and mason.nvim.

return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre", -- Load LSP early when a buffer is read.
    dependencies = {
      { "williamboman/mason.nvim", version = "1.11.0" }, -- LSP server manager.
      { "williamboman/mason-lspconfig.nvim", version = "1.32.0" }, -- Mason integration with lspconfig.
    },
    config = function()
      -- Load configuration modules
      local constants = require("plugins.lsp.lsp-config.constants")
      local diagnostics = require("plugins.lsp.lsp-config.diagnostics")
      local highlights = require("plugins.lsp.lsp-config.highlights")
      local keymaps = require("plugins.lsp.lsp-config.keymaps")
      local formatting = require("plugins.lsp.lsp-config.formatting")

      -- Setup all LSP configurations
      diagnostics.setup()
      highlights.setup()
      formatting.setup()

      -- Enhance LSP capabilities for nvim-cmp
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

      -- Setup Mason and Mason-LSPconfig
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = constants.lsp_servers,
        automatic_installation = true,
      })

      -- Default handler for LSP servers
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = keymaps.on_attach,
          })
        end,
      })

      -- Load server-specific configurations
      require("plugins.lsp.servers.lua")
      require("plugins.lsp.servers.pyright")
      require("plugins.lsp.servers.ruff")
      require("plugins.lsp.servers.yamlls")
      require("plugins.lsp.servers.helm_ls")
      require("plugins.lsp.servers.bash")
      require("plugins.lsp.servers.gopls")
    end,
  },
}
