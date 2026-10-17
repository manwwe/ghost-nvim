return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  keys = {
    { "<leader>cf", function() require("conform").format({ async = true }) end, mode = { "n", "x" }, desc = "Format" },
  },
  opts = {
    default_format_opts = {
      timeout_ms = 3000,
      lsp_format = "fallback",
    },
    formatters_by_ft = {},
  },
}
