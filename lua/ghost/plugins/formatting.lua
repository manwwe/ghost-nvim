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
    formatters_by_ft = {
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      less = { "prettier" },
      json = { "prettier" },
      jsonc = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      ["markdown.mdx"] = { "prettier" },
      vue = { "prettier" },
      graphql = { "prettier" },
      handlebars = { "prettier" },
    },
  },
}
