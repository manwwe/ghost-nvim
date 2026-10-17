return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        options = {
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "󰙅 File Explorer",
                    text_align = "center",
                    separator = false,
                    highlight = "Directory",
                },
                {
                    filetype = "copilot-chat",
                    text = " Copilot Chat",
                    text_align = "center",
                    separator = false,
                    highlight = "Directory",
                },
            },
        },
    },
}
