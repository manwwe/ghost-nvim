return {
    "nvim-mini/mini.diff",
    version = "*",
    lazy = false, -- Attach to files before the overlay shortcut is used
    init = function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            vim.b[buf].minidiff_disable = true
        end
        vim.api.nvim_create_autocmd("BufAdd", {
            group = vim.api.nvim_create_augroup("ghost_minidiff_default", { clear = true }),
            callback = function(event)
                vim.b[event.buf].minidiff_disable = true
            end,
        })
    end,
    keys = {
        {
            "<leader>gd",
            function()
                local diff = require("mini.diff")
                if vim.b.minidiff_disable then
                    vim.b.minidiff_disable = false
                    diff.enable()
                else
                    diff.disable()
                    vim.b.minidiff_disable = true
                end
            end,
            desc = "Toggle buffer diff tracking",
        },
        {
            "<leader>go",
            function()
                local diff = require("mini.diff")
                if not diff.get_buf_data(0) then
                    vim.notify("No diff available for this buffer", vim.log.levels.INFO)
                    return
                end
                diff.toggle_overlay()
            end,
            desc = "Toggle diff overlay",
        },
    },
    opts = {
        view = { style = "sign" },
    },
}
