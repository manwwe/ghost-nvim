return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
        presets = { command_palette = true },
        views = {
            cmdline_popup = {
                position = { row = 2, col = "50%" },
            },
        },
    },
}
