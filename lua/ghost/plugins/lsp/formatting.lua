-- Configures conform.nvim formatting.

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({
          async = true,
          lsp_format = "fallback",
        })
      end,
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      json = { "prettier" },
      lua = { "stylua" },
      markdown = { "prettier" },
      python = { "ruff_format" },
      rust = { "rustfmt" },
      toml = { "taplo" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      yaml = { "prettier" },
    },
    format_on_save = {
      timeout_ms = 2000,
      lsp_format = "fallback",
    },
  },
}
