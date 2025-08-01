-- Configures windwp/nvim-ts-autotag: auto-renames/closes HTML/XML tags using Treesitter.

return {
  {
    'windwp/nvim-ts-autotag',
    dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- Needs Treesitter for parsing.
    config = function()
      require('nvim-ts-autotag').setup({
        -- Defaults are generally fine (auto-rename, auto-close for HTML, XML, JSX, etc.).
      })
    end,
  },
}
