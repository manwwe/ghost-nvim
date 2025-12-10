-- Configures gopls (Go Language Server) for Go LSP features.

vim.lsp.config("gopls", {
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
})
