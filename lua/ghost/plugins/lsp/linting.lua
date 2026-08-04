-- Configures nvim-lint diagnostics.

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")
    local group = vim.api.nvim_create_augroup("ghost_lint", { clear = true })

    local function can_run_clang_tidy(bufnr)
      local file = vim.api.nvim_buf_get_name(bufnr)

      if file == "" then
        return false
      end

      return vim.fs.find({ "compile_commands.json", "compile_flags.txt" }, {
        upward = true,
        path = vim.fs.dirname(file),
      })[1] ~= nil
    end

    lint.linters_by_ft = require("ghost.config.lang_tools").linters_by_ft

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = group,
      callback = function(event)
        local ft = vim.bo[event.buf].filetype

        if (ft == "c" or ft == "cpp") and not can_run_clang_tidy(event.buf) then
          return
        end

        lint.try_lint()
      end,
    })
  end,
}
