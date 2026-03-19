-- Configures core Neovim options.

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 3

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.clipboard = "unnamedplus"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = true

vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.fillchars = { eob = " ", vert = "│" }
vim.opt.showmode = false

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
