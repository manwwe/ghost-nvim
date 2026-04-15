-- Configures conform.nvim formatting.

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>fm",
      function()
        require("conform").format {
          async = true,
          lsp_format = "fallback",
        }
      end,
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = require("ghost.config.lang_tools").formatters_by_ft,
    format_on_save = {
      timeout_ms = 2000,
      lsp_format = "fallback",
    },
  },
}
