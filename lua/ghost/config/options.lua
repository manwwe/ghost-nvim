-- Configures core Neovim options.

vim.g.mapleader = " "       -- Space leader
vim.g.maplocalleader = "\\" -- Backslash local leader
vim.g.ai_cmp = true         -- AI completion flag for supporting plugins


vim.opt.mouse = "a" -- Enable mouse support
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.numberwidth = 3 -- Minimum number column width
vim.opt.ignorecase = true -- Case-insensitive search
vim.opt.smartcase = true -- Uppercase enables case sensitivity
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.swapfile = false -- Disable swap files
vim.opt.backup = false -- Disable backups
vim.opt.writebackup = false -- Disable temporary backups
vim.opt.undofile = true -- Persistent undo history
vim.opt.confirm = true -- Prompt before discarding changes
vim.opt.cursorline = true -- Highlight cursor line
vim.opt.termguicolors = true -- Enable true colors
vim.opt.signcolumn = "yes" -- Always show sign column
vim.opt.wrap = false -- Disable line wrapping
vim.opt.scrolloff = 8 -- Keep eight context lines
vim.opt.sidescrolloff = 8 -- Horizontal context
vim.opt.pumheight = 10 -- Limit completion menu height
vim.opt.fillchars = { -- UI fill characters
    foldopen = "", -- Open fold marker
    foldclose = "", -- Closed fold marker
    fold = " ", -- Fold line filler
    foldsep = " ", -- Fold column separator
    diff = "╱", -- Diff filler
    eob = " ", -- Hide end-of-buffer tildes
}
vim.opt.showmode = false -- Mode is shown in lualine
vim.opt.laststatus = 2 -- Show statusline
vim.opt.ruler = false -- Hide cursor position
vim.opt.splitright = true -- Split to the right
vim.opt.splitbelow = true -- Split below
vim.opt.splitkeep = "screen" -- Keep text steady when splitting
vim.opt.tabstop = 2 -- Two-space tab width
vim.opt.shiftwidth = 2 -- Two-space indentation
vim.opt.shiftround = true -- Round indentation to a full level
vim.opt.expandtab = true -- Use spaces for tabs
vim.opt.smartindent = true -- Smart auto-indent
vim.opt.virtualedit = "block" -- Select beyond line endings in block mode
vim.opt.showtabline = 0 -- Hide the tab bar
