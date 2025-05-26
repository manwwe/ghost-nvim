-- Configures Nord theme (shaunsingh/nord.nvim implementation).
-- Nord is an arctic, north-bluish color palette.

return {
  'shaunsingh/nord.nvim',
  lazy = true, -- Load lazily (not applied on startup by default).
  config = function()
    -- Nord.nvim uses global Vim variables for configuration.
    -- These must be set *before* applying the colorscheme.
    vim.g.nord_contrast = true               -- Enable higher contrast.
    vim.g.nord_borders = false               -- Disable borders for floating windows.
    vim.g.nord_disable_background = false    -- Use Nord's background color (not transparent).
    vim.g.nord_italic = false                -- Disable italics for comments, etc.
    vim.g.nord_uniform_diff_background = true -- More uniform diff backgrounds.
    vim.g.nord_bold = false                  -- Disable bold text.

    -- To apply Nord: require("nord").set() or vim.cmd [[colorscheme nord]]
    -- This theme is configured but not set as default here.
  end,
}
