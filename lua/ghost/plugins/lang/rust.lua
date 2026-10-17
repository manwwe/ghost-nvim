return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = { ensure_installed = { "rust_analyzer" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rust_analyzer = {},
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { parsers = { "rust" } },
  },
}
