-- Configures kdheepak/lazygit.nvim: Lazygit (terminal UI for Git) integration.

return {
  'kdheepak/lazygit.nvim',
  lazy = true, -- Load lazily.
  cmd = { -- Commands that trigger loading.
    'LazyGit', 'LazyGitConfig', 'LazyGitCurrentFile',
    'LazyGitFilter', 'LazyGitFilterCurrentFile',
  },
  dependencies = { 'nvim-lua/plenary.nvim' }, -- Optional for some features/extensions.
  keys = {
    { '<leader>gg', '<cmd>LazyGit<CR>', desc = 'LazyGit' }, -- Keymap to open Lazygit.
  },
  config = function()
    -- Load Telescope extension for Lazygit, if Telescope is available.
    if pcall(require, 'telescope') then
      require('telescope').load_extension 'lazygit'
    end
    -- Other global settings (e.g., vim.g.lazygit_...) can be set here if needed.
  end,
}
