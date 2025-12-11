-- Configures gopls (Go Language Server) for Go LSP features.

local defaults = require("plugins.lsp.servers.defaults")

return defaults.with_defaults({
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
})
