return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { parsers = { "bash" } },
  },
  {
    "stevearc/conform.nvim",
    opts = { formatters_by_ft = { sh = { "shfmt" } } },
  },
}
