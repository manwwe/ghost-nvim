-- Custom Neovim commands.

-- Command `:ReloadConfig` to reload user configuration.
-- Sources $MYVIMRC and prints a confirmation.
vim.api.nvim_create_user_command(
  'ReloadConfig',
  function()
    vim.cmd 'source $MYVIMRC' -- Source user config.
    print 'Config reloaded!' -- Confirmation message.
  end,
  {} -- No extra command attributes.
)
