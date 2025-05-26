-- Configures folke/trouble.nvim: pretty list for diagnostics, LSP items, etc.

return {
  'folke/trouble.nvim',
  cmd = 'Trouble', -- Load on :Trouble command.
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- Icons for list.
  opts = { -- Default options.
    win = { -- Window configuration.
      type = 'split', -- Open as a split.
      position = 'left', -- Position of the split.
      size = 50, -- Size of the window.
    },
    -- Other options like auto_open, icons, mode use defaults.
  },
  keys = { -- Key mappings.
    { '<leader>dt', '<cmd>Trouble diagnostics toggle<CR>', desc = 'Toggle diagnostics Trouble' },
    { '<leader>ds', '<cmd>Trouble symbols toggle win.position=left<CR>', desc = 'Document symbols Trouble' },
  },
}
