-- plugins/init.lua
-- Entry point for all plugins loaded via Lazy.nvim.

return {
  { import = "ghost.plugins.lsp" },
  { import = "ghost.plugins.treesitter" },
}
