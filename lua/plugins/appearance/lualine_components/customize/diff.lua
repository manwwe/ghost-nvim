-- Lualine 'diff' component configuration.
-- Shows Git changes (added, modified, removed lines).

local diff = {
  "diff", -- Use Lualine's built-in 'diff' component.
  colored = true, -- Color the symbols.
  symbols = { -- Nerd Font icons for changes.
    added = " ", -- Added lines.
    modified = " ", -- Modified lines.
    removed = " ", -- Removed lines.
  },
}

return diff
