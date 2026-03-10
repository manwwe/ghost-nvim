-- formatting.lua
-- Code formatting via conform.nvim.
-- Format manually with <leader>cf.

return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      json = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      rust = { "rustfmt" },
      python = { "ruff_format" },
    },
    formatters = {
      prettier = {
        prepend_args = { "--single-quote", "--tab-width", "2" },
      },
      rustfmt = {
        prepend_args = { "--edition", "2021" },
      },
    },
  },
  config = function(_, opts)
    local conform = require("conform")
    conform.setup(opts)

    vim.keymap.set({ "n", "v" }, "<leader>cf", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format buffer" })
  end,
}
