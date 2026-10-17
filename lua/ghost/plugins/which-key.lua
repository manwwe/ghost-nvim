return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "helix",
        win = { border = "rounded" },
        icons = { mappings = true, colors = true },
        spec = {
            { "<leader>b", group = "buffers" },
            { "<leader>c", group = "code" },
            { "<leader>f", group = "find / files" },
            { "<leader>g", group = "git" },
            { "<leader>q", group = "quit" },
            { "<leader>t", group = "terminal", icon = " " },
            { "<leader>w", group = "windows" },
            { "<leader>u", group = "ui" },
            { "<leader>x", group = "lists" },
        },
    },
}
