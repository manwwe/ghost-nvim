local source = debug.getinfo(1, "S").source:sub(2)
local root = vim.fn.fnamemodify(vim.uv.fs_realpath(source) or source, ":p:h:h:h:h")

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
    opts = {
        show_line_number = true,
        show_workspace = false,
        snapshot_config = {
            theme = "ghost-gruvbox",
            themes_folders = { root .. "/assets/codesnap" },
            background = "#282828",
            line_number_color = "#928374",
            window = {
                mac_window_bar = false,
                margin = { x = 0, y = 0 },
                shadow = { radius = 0, color = "#00000000" },
                border = { width = 0, color = "#00000000" },
                radius = 0,
            },
            code_config = {
                breadcrumbs = { enable = false },
            },
            watermark = { content = "" },
        },
    },
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
