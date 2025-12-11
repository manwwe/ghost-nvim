-- LSP configuration using nvim-lspconfig and mason.nvim.

local deps = require("plugins.lsp.lsp-config.deps")

return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre", -- Load LSP early when a buffer is read.
    dependencies = {
      deps.mason, -- LSP server manager.
      { "williamboman/mason-lspconfig.nvim", version = "1.32.0" }, -- Mason integration with lspconfig.
    },
    config = function()
      -- Load configuration modules
      local constants = require("plugins.lsp.lsp-config.constants")
      local diagnostics = require("plugins.lsp.lsp-config.diagnostics")
      local highlights = require("plugins.lsp.lsp-config.highlights")
      local keymaps = require("plugins.lsp.lsp-config.keymaps")
      local formatting = require("plugins.lsp.lsp-config.formatting")
      local server_registry = require("plugins.lsp.lsp-config.server_registry")

      -- Setup diagnostic/highlight/formatting UI
      diagnostics.setup()
      highlights.setup()
      formatting.setup()

      -- Capabilities builder keeps overrides in one place
      local function build_capabilities()
        local caps = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
        local ok, file_ops = pcall(require, "lsp-file-operations")
        if ok then
          caps = vim.tbl_deep_extend("force", caps, file_ops.default_capabilities())
        end
        return caps
      end

      local capabilities = build_capabilities()
      local default_opts = {
        capabilities = capabilities,
        on_attach = keymaps.on_attach,
      }

      -- Apply defaults to every LSP config (new API)
      vim.lsp.config("*", default_opts)

      -- Apply server-specific configurations
      for _, name in ipairs(server_registry.names()) do
        local opts = server_registry.get(name)
        if opts then
          vim.lsp.config(name, vim.tbl_deep_extend("force", {}, default_opts, opts))
        end
      end

      -- Setup Mason and Mason-LSPconfig
      deps.setup_mason()
      require("mason-lspconfig").setup({
        ensure_installed = constants.lsp_servers,
        automatic_installation = false,
      })

      -- Enable all configured servers
      vim.lsp.enable(constants.lsp_servers)
    end,
  },
}
