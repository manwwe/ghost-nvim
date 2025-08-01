-- Configures lazy.nvim plugin manager.
-- Handles installation and setup of all other plugins.

-- Installation path for lazy.nvim.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Clone lazy.nvim if not already installed.
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ -- System command to clone.
    "git",
    "clone",
    "--filter=blob:none", -- Optimized clone.
    "--branch=stable", -- Use stable branch.
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
-- Add lazy.nvim to runtime path (rtp) for Neovim to find it.
vim.opt.rtp:prepend(lazypath)

-- Initialize lazy.nvim with plugin specifications and options.
require("lazy").setup(
  -- List of plugin specifications (imported from 'plugins' directory).
  {
    -- { import = 'plugins' }, -- General
    { import = "plugins.lsp" }, -- LSP
    { import = "plugins.themes" }, -- Themes
    { import = "plugins.ai" }, -- AI
    { import = "plugins.git" }, -- Git
    { import = "plugins.search" }, -- Search
    { import = "plugins.terminal" }, -- Terminal
    { import = "plugins.session" }, -- Session
    { import = "plugins.coding" }, -- Coding
    { import = "plugins.appearance" }, -- Appearance
    { import = "plugins.appearance.lualine_components" },
  },
  -- Global configuration for lazy.nvim.
  {
    change_detection = {
      notify = false, -- Disable notifications for config file changes.
    },
    performance = {
      rtp = {
        -- Disable unused built-in Neovim plugins for faster startup.
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
    ui = { -- UI for the lazy.nvim interface.
      border = "rounded", -- Rounded borders.
      wrap = true, -- Wrap long lines in plugin list.
      title = " Plugins", -- Title with icon (requires Nerd Font).
    },
  }
)
