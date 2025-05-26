-- Configures ntpeters/vim-better-whitespace: highlights and manages trailing whitespace.

return {
  'ntpeters/vim-better-whitespace',
  opts = {}, -- Configuration handled by global Vim variables below.
  config = function()
    -- Enable plugin on startup.
    vim.g.better_whitespace_enabled = 1

    -- Automatically strip trailing whitespace on save.
    vim.g.strip_whitespace_on_save = 1

    -- Disable confirmation before stripping whitespace (silent stripping).
    vim.g.strip_whitespace_confirm = 0

    -- Also provides :StripWhitespace command for manual use.
  end,
}
