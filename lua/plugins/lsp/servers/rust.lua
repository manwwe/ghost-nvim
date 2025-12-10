-- Configures rust-analyzer (Rust LSP) for Rust development.

return {
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
  flags = {
    debounce_text_changes = 150,
  },
}
