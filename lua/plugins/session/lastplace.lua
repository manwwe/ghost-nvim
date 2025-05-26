-- Configures farmergreg/vim-lastplace: restores cursor position on reopening files.

return {
  'farmergreg/vim-lastplace',
  opts = {}, -- Configured via global Vim variables below.
  config = function()
    -- Global settings for vim-lastplace.
    -- Ignore specific buffer types (quickfix, nofile, help).
    vim.g.lastplace_ignore_buftype = 'quickfix,nofile,help'
    -- Ignore specific filetypes (gitcommit, gitrebase, etc.).
    vim.g.lastplace_ignore_filetype = 'gitcommit,gitrebase,svn,hgcommit'
    -- Auto-open folds if cursor was inside a fold.
    vim.g.lastplace_open_folds = 1
  end,
}
