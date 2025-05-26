-- Lualine component for GitHub Copilot status.
-- Shows icons and colors based on Copilot's state.

local copilot = {
  'copilot', -- Component name (may reference a Copilot plugin's Lualine integration).
  symbols = { -- Icons for states.
    status = {
      icons = { -- Nerd Font icons for Copilot states.
        enabled = ' ',
        sleep = ' ',  -- When auto-trigger is off or sleeping.
        disabled = ' ',
        warning = ' ',
        unknown = ' ',
      },
      hl = { -- Highlight colors for each status.
        enabled = '#0D4715',  -- Dark green.
        sleep = '#AEB7D0',    -- Light grey/blue.
        disabled = '#6272A4', -- Desaturated blue/purple.
        warning = '#FFB86C',  -- Yellow/orange.
        unknown = '#85193C',  -- Dark red.
      },
    },
    spinners = 'dots', -- Spinner style for loading.
    spinner_color = '#6272A4',
  },
  show_colors = true, -- Apply highlight colors.
  show_loading = true, -- Show spinner when Copilot is processing.
}

return copilot
