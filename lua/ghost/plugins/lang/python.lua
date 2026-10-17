return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = { ensure_installed = { "pyright", "ruff" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {},
        ruff = {},
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { parsers = { "python" } },
  },
}
