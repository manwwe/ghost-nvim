return {
  {
    "mfussenegger/nvim-lint",
    opts = { linters_by_ft = { sh = { "shellcheck" } } },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { parsers = { "bash" } },
  },
  {
    "stevearc/conform.nvim",
    opts = { formatters_by_ft = { sh = { "shfmt" } } },
  },
}
