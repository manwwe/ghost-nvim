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

      -- Servers with custom options extend the defaults
      local server_modules = {
        lua_ls = "plugins.lsp.servers.lua",
        pyright = "plugins.lsp.servers.pyright",
        ruff = "plugins.lsp.servers.ruff",
        yamlls = "plugins.lsp.servers.yamlls",
        helm_ls = "plugins.lsp.servers.helm_ls",
        bashls = "plugins.lsp.servers.bash",
        gopls = "plugins.lsp.servers.gopls",
        rust_analyzer = "plugins.lsp.servers.rust",
      }

      local function configure_server(server_name)
        local module = server_modules[server_name]
        if not module then
          return
        end

        local ok, opts = pcall(require, module)
        if not ok then
          vim.notify(string.format("[lsp] Failed to load %s: %s", module, opts), vim.log.levels.WARN)
          return
        end

        vim.lsp.config(server_name, vim.tbl_deep_extend("force", {}, default_opts, opts or {}))
      end

      -- Apply defaults to every LSP config (new API)
      vim.lsp.config("*", default_opts)

      -- Apply server-specific configurations
      for name in pairs(server_modules) do
        configure_server(name)
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
