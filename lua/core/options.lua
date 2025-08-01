-- Neovim option settings.

-- Line numbers
vim.wo.number = true -- Show line numbers.
vim.o.relativenumber = true -- Show relative line numbers.
vim.o.numberwidth = 3 -- Width of the number column.
--vim.o.showtabline = 2

-- Search
vim.opt.ignorecase = true -- Ignore case in search patterns.
vim.opt.smartcase = true -- Override ignorecase if search pattern contains uppercase letters.

-- Clipboard
vim.o.clipboard = "unnamedplus" -- Use system clipboard.

-- File handling & backups
vim.o.swapfile = false -- Disable swap files.
vim.o.backup = false -- Disable backup files.
vim.o.writebackup = false -- Disable backup before overwriting.
vim.o.undofile = true -- Enable persistent undo.

-- Runtime path
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles") -- Avoid Vim's user plugin directory conflicts.

-- Special characters appearance
vim.opt.fillchars = {
  eob = " ",
  vert = "│",
}

vim.o.cursorline = true

vim.opt.splitright = true

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("alpha_tabline", { clear = true }),
  pattern = "alpha",
  callback = function()
    vim.opt.showtabline = 0
    vim.api.nvim_create_autocmd("BufUnload", {
      buffer = 0, -- Current buffer
      group = "alpha_tabline",
      command = "set showtabline=2",
    })
  end,
})
