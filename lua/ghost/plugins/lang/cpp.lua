return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = { ensure_installed = { "clangd" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          cmd = { "clangd", "--query-driver=/opt/homebrew/bin/g++-16,/opt/homebrew/bin/gcc-16" },
          on_init = function(client)
            client.server_capabilities.inlayHintProvider = false -- Disable clangd inlay hints
          end,
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { parsers = { "c", "cpp", "printf" } },
  },
  {
    "stevearc/conform.nvim",
    opts = { formatters_by_ft = { cpp = { "clang-format" } } },
  },
}
