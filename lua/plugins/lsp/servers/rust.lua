-- Configures rust-analyzer (Rust LSP) for Rust development.

local defaults = require("plugins.lsp.servers.defaults")

return defaults.with_defaults({
  cmd = { "rust-analyzer" }, -- Command to start rust-analyzer.
  filetypes = { "rust" },
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      procMacro = {
        enable = true,
      },
      checkOnSave = {
        command = "clippy", -- Use clippy for linting.
      },
    },
  },
})
