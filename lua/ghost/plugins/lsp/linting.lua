-- Configures nvim-lint diagnostics.

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")
    local group = vim.api.nvim_create_augroup("ghost_lint", { clear = true })

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      python = { "ruff" },
      typescript = { "eslint_d" },
      typescriptreact = { "eslint_d" },
    }

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = group,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
