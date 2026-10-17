return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
        { "<C-/>", function() Snacks.terminal.toggle(nil, { count = 1 }) end, desc = "Toggle terminal", mode = { "n", "t" } },
        { "<C-_>", function() Snacks.terminal.toggle(nil, { count = 1 }) end, desc = "Toggle terminal", mode = { "n", "t" } },
        { "<leader>tt", function() Snacks.terminal.toggle(nil, { count = 1 }) end, desc = "Toggle terminal" },
        { "<leader>tf", function() Snacks.terminal.toggle(nil, { count = 2, win = { position = "float", border = "rounded", wo = { winhighlight = "FloatBorder:GhostTerminalBorder" } } }) end, desc = "Toggle floating terminal" },
        { "<leader>tl", function() Snacks.terminal.toggle(nil, { count = 3, win = { position = "left" } }) end, desc = "Toggle left terminal" },
        { "<leader>tr", function() require("ghost.config.runner").run() end, desc = "Run current file" },
        { "<leader>tc", function() require("ghost.config.runner").run({ collect_input = true }) end, desc = "Run with collected input" },
        { "<leader>tv", function() Snacks.terminal.toggle(nil, { count = 4, win = { position = "right", width = 80 } }) end, desc = "Open vertical terminal" },
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
        terminal = {},
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
        snacks.toggle({
            name = "Copilot",
            get = function() return vim.g.copilot_enabled == true end,
            set = function(state)
                vim.g.copilot_enabled = state
                vim.cmd(state and "Copilot enable" or "Copilot disable")
                if package.loaded["lualine"] then require("lualine").refresh() end
            end,
        }):map("<leader>ua")
        local function terminal_highlights()
            vim.api.nvim_set_hl(0, "GhostTerminalBorder", { fg = "#88C0D0" })
        end
        terminal_highlights()
        vim.api.nvim_create_autocmd("ColorScheme", {
            group = vim.api.nvim_create_augroup("ghost_terminal_highlights", { clear = true }),
            callback = terminal_highlights,
        })
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
