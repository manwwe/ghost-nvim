return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  opts = {
    default_format_opts = {
      timeout_ms = 3000,
      lsp_format = "fallback",
    },
    formatters_by_ft = {},
  },
}
