-- Configures Exafunction/windsurf.nvim for Codeium (AI code completion).

return {
  {
    'Exafunction/windsurf.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim', -- Utility functions.
      'hrsh7th/nvim-cmp', -- Completion plugin integration.
    },
    config = function()
      require('codeium').setup {
        -- Manual bin_path for Codeium language server binary.
        -- Essential for WSL due to auto-download issues.
        -- Must point to the *directory* containing the binary.
        -- Version '1.8.9' might need updates if Codeium changes its structure.
        bin_path = vim.fn.expand '~/.cache/nvim/codeium/bin/1.8.9',
      }

      -- Keymap for Codeium Chat.
      local keymap = vim.keymap.set
      keymap('n', '<leader>aw', '<cmd>Codeium Chat<CR>', { desc = 'Codeium Chat' })
    end,
  },
}
