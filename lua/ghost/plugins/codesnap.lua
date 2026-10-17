return {
    "mistricky/codesnap.nvim",
    tag = "v2.0.5",
    cmd = { "CodeSnap", "CodeSnapSave" },
    keys = {
        {
            "<leader>cs",
            function()
                -- Leave visual mode to update the selection marks CodeSnap reads.
                vim.cmd.normal({ vim.api.nvim_replace_termcodes("<Esc>", true, false, true), bang = true })
                local dir = vim.fn.expand("~/Pictures/CodeSnap")
                vim.fn.mkdir(dir, "p")
                local path = dir .. "/code-" .. os.date("%Y%m%d-%H%M%S") .. "-" .. vim.uv.hrtime() .. ".png"
                local cpath = package.cpath
                local ok, err = pcall(function() require("codesnap").save(path) end)
                package.cpath = cpath
                if not ok then
                    vim.notify(tostring(err), vim.log.levels.ERROR)
                end
            end,
            mode = "x",
            desc = "Save code snapshot",
        },
    },
    opts = {},
    config = function(_, opts)
        -- CodeSnap adds a literal library path; don't leak it to other plugins.
        local cpath = package.cpath
        local ok, err = pcall(function() require("codesnap").setup(opts) end)
        package.cpath = table.concat(vim.tbl_filter(function(path)
            return not path:find("/codesnap.nvim/", 1, true)
        end, vim.split(cpath, ";")), ";")
        if not ok then error(err) end
    end,
}
