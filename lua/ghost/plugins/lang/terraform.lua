return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = { ensure_installed = { "terraformls" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        terraformls = {},
      },
    },
  },
}
