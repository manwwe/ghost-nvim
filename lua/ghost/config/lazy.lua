-- Configures lazy.nvim and plugin loading.

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
    {
        { import = 'ghost.plugins' },
        { import = "ghost.plugins.lsp" },

    },
    {
        change_detection = {
            notify = false,
        },
        install = {
            colorschema = { "" },
        },
        performance = {
            rtp = {
                disabled_plugins = {
                    "gzip",
                    "matchit",
                    "matchparen",
                    "netrwPlugin",
                    "tarPlugin",
                    "tohtml",
                    "tutor",
                    "zipPlugin",
                },
            },
        },
        ui = {
            border = "rounded",
            wrap = true,
        },
    }
)
