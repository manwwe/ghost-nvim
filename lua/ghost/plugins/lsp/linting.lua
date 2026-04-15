-- Configures nvim-lint diagnostics.

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")
    local group = vim.api.nvim_create_augroup("ghost_lint", { clear = true })

    lint.linters_by_ft = require("ghost.config.lang_tools").linters_by_ft

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = group,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
