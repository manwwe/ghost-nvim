-- Loads Hybrid on a dark background.

return {
    "w0ng/vim-hybrid",
    lazy = true,
    init = function()
        vim.opt.background = "dark"
    end,
}
