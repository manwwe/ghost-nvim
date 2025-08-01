-- Configures folke/ts-comments.nvim: aims for context-aware commenting using Treesitter.
-- Note: This plugin is minimal; consider alternatives like 'Comment.nvim' for richer features.

return {
  'folke/ts-comments.nvim',
  event = 'VeryLazy', -- Load late.
  opts = {}, -- No extra configuration typically needed.
  -- May be used alongside other commenting tools.
}
