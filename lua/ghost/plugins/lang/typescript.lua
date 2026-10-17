return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = { ensure_installed = { "ts_ls" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ts_ls = {},
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { parsers = { "javascript", "jsdoc", "tsx", "typescript" } },
  },
}
