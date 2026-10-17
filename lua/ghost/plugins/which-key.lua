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
            { "<leader>f", group = "find" },
            { "<leader>g", group = "git" },
            { "<leader>q", group = "quit" },
            { "<leader>s", group = "splits" },
            { "<leader>u", group = "ui" },
            { "<leader>x", group = "lists" },
        },
    },
}
