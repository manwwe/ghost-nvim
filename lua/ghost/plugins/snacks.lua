return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
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
        snacks.toggle.indent():map("<leader>ug")
        snacks.toggle.diagnostics():map("<leader>ud")
        snacks.toggle.inlay_hints():map("<leader>uh")
    end,
}
