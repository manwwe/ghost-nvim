-- Lualine 'mode' component configuration.
-- Displays current Neovim mode (Normal, Insert, etc.).

local mode = {
  'mode', -- Use Lualine's built-in 'mode' component.
  fmt = function(str) -- Format mode string.
    -- Prepends Nerd Font icon and shows first letter of mode (e.g., " N").
    return ' ' .. str
  end,
  draw_empty = true, -- Allocate space even if mode string is empty (for layout consistency).
  color = { gui = 'bold' }, -- Make mode text bold (color from theme).
}

return mode
