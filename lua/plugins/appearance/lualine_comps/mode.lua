-- Lualine 'mode' component configuration.
-- Displays current Neovim mode (Normal, Insert, etc.).

local mode = {
  'mode', -- Use Lualine's built-in 'mode' component.
  fmt = function(str) -- Format mode string.
    -- Prepends Nerd Font icon and shows first letter of mode (e.g., " N").
    return ' ' .. str:sub(1, 1)
  end,
  draw_empty = true, -- Allocate space even if mode string is empty (for layout consistency).
  color = { gui = 'bold' }, -- Make mode text bold (color from theme).
  separator = { left = '', right = '' }, -- No left separator, Powerline-style arrow right.
}

return mode
