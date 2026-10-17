return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
        { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete other buffers" },
        { "<leader>bi", function() Snacks.bufdelete.invisible() end, desc = "Delete invisible buffers" },
        { "<leader>gg", function() Snacks.lazygit() end, desc = "LazyGit" },
        { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git branches" },
        { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git history" },
        { "<leader>fg", function() Snacks.picker.grep() end, desc = "Search project text" },
        { "<leader>fw", function() Snacks.picker.grep_word() end, desc = "Search current word" },
        { "<leader>/", function() Snacks.picker.lines() end, desc = "Search current buffer" },
        { "<leader>f/", function() Snacks.picker.grep_buffers() end, desc = "Search open buffers" },
        { "<leader><leader>", function() Snacks.picker.buffers() end, desc = "Find buffers" },
        { "<leader>fh", function() Snacks.picker.help() end, desc = "Find help" },
        { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Find keymaps" },
        { "<leader>fd", function() Snacks.picker.diagnostics() end, desc = "Find diagnostics" },
        { "<leader>fp", function() Snacks.picker.pickers() end, desc = "Select picker" },
        { "<leader>fR", function() Snacks.picker.resume() end, desc = "Resume last picker" },
        {
            "<leader>ff",
            function() Snacks.picker.files() end,
            desc = "Find files",
        },
        {
            "<leader>fr",
            function() Snacks.picker.recent() end,
            desc = "Recent files",
        },
    },
    opts = {
        lazygit = { enabled = true },
        bigfile = { enabled = true },
        explorer = { enabled = true },
        image = { enabled = true },
        input = { enabled = true },
        notifier = { enabled = true },
        toggle = { enabled = true },
        indent = { enabled = true },
    },
    config = function(_, opts)
        local snacks = require("snacks")
        snacks.setup(opts)
        local pickers = {
            "files", "grep", "grep_word", "lines", "grep_buffers", "buffers",
            "recent", "help", "keymaps", "diagnostics", "pickers", "resume",
        }
        vim.api.nvim_create_user_command("Picker", function(command)
            local name = command.args ~= "" and command.args or "pickers"
            if not vim.tbl_contains(pickers, name) then
                vim.notify("Unknown picker: " .. name, vim.log.levels.ERROR)
                return
            end
            snacks.picker[name]()
        end, {
            nargs = "?",
            desc = "Open a Snacks picker",
            complete = function(prefix)
                return vim.tbl_filter(function(name)
                    return vim.startswith(name, prefix)
                end, pickers)
            end,
        })
        snacks.toggle.option("background", { name = "Dark background", on = "dark", off = "light", global = true }):map("<leader>ub")
        snacks.toggle.option("conceallevel", { name = "Conceal", on = 2, off = 0 }):map("<leader>uc")
        snacks.toggle.line_number():map("<leader>ul")
        snacks.toggle.option("relativenumber", { name = "Relative numbers" }):map("<leader>un")
        snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        snacks.toggle.option("wrap", { name = "Line wrap" }):map("<leader>uw")
        snacks.toggle.treesitter():map("<leader>uT")
        snacks.toggle.indent():map("<leader>ug")
        snacks.toggle.diagnostics():map("<leader>ud")
        snacks.toggle.inlay_hints():map("<leader>uh")
    end,
}
