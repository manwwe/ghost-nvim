require("ghost.core")
require("ghost.plugins")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup({
  spec = {
    { import = "ghost.plugins" },
  },
  defaults = {
    lazy = true,       -- load plugins lazily by default
  },
  install = {
    colorscheme = { "habamax" }, -- fallback colorscheme during install
  },
  checker = {
    enabled = true,    -- auto check for plugin updates
    notify = false,    -- don't notify on every check
  },
  change_detection = {
    notify = false,    -- don't notify on config file changes
  },
  ui = {
    border = "rounded",
  },
})
