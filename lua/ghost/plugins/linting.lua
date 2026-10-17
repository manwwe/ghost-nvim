return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    opts = { linters_by_ft = {} },
    config = function(_, opts)
        local lint = require("lint")
        lint.linters_by_ft = opts.linters_by_ft
        vim.api.nvim_create_autocmd("BufWritePost", {
            group = vim.api.nvim_create_augroup("ghost_lint", { clear = true }),
            callback = function()
                if vim.bo.buftype == "" and vim.bo.modifiable then
                    lint.try_lint()
                end
            end,
        })
    end,
}
