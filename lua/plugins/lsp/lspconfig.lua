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
      local ok, file_ops = pcall(require, "lsp-file-operations")
      if ok then
        capabilities = vim.tbl_deep_extend("force", capabilities, file_ops.default_capabilities())
      end

      -- Setup Mason and Mason-LSPconfig
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = constants.lsp_servers,
        automatic_installation = false,
      })

      -- Base options applied to every server
      local default_opts = {
        capabilities = capabilities,
        on_attach = keymaps.on_attach,
      }

      -- Server-specific overrides
      local server_opts = {
        lua_ls = require("plugins.lsp.servers.lua"),
        pyright = require("plugins.lsp.servers.pyright"),
        ruff = require("plugins.lsp.servers.ruff"),
        yamlls = require("plugins.lsp.servers.yamlls"),
        helm_ls = require("plugins.lsp.servers.helm_ls"),
        bashls = require("plugins.lsp.servers.bash"),
        gopls = require("plugins.lsp.servers.gopls"),
        rust_analyzer = require("plugins.lsp.servers.rust"),
      }

      -- Apply defaults to every LSP config (new API)
      vim.lsp.config("*", default_opts)

      -- Apply server-specific configurations
      for server_name, opts in pairs(server_opts) do
        vim.lsp.config(server_name, vim.tbl_deep_extend("force", {}, default_opts, opts or {}))
      end

      -- Setup Mason and Mason-LSPconfig
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = constants.lsp_servers,
        automatic_installation = false,
      })

      -- Enable all configured servers
      vim.lsp.enable(constants.lsp_servers)
    end,
  },
}
