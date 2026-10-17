return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    "mason-org/mason.nvim",
    "neovim/nvim-lspconfig",
  },
  opts_extend = { "ensure_installed" },
  opts = {
    ensure_installed = {},
  },
}
