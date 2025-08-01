-- Configures gopls (Go Language Server) for Go LSP features.

local lspconfig = require("lspconfig")

lspconfig.gopls.setup({
  cmd = { "gopls" }, -- Command to start gopls.
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    },
  },
  flags = {
    debounce_text_changes = 150,
  },
  root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
})

