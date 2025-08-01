-- Main Neovim configuration file. Loads all other modules.

-- General Neovim options (clipboard, mouse, etc.).
require 'core.options'

-- Custom key mappings.
require 'core.keymaps'

-- System-specific settings (OS-dependent).
require 'core.system'

-- Initialize and configure Lazy.nvim plugin manager.
require 'core.lazy-config'

-- Custom Ex commands.
-- require 'core.commands'
