-- Loads Cursor Dark Midnight.

return {
    "ydkulks/cursor-dark.nvim",
    lazy = true,
    opts = {
        style = "dark-midnight",
    },
    config = function(_, opts)
        require("cursor-dark").setup(opts)
    end,
}
