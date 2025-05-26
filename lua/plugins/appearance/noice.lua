-- Configures folke/noice.nvim: overhaul Neovim UI (cmdline, messages, popups).

return {
  'folke/noice.nvim',
  event = 'VeryLazy', -- Load late.
  dependencies = {
    'MunifTanjim/nui.nvim', -- UI components for Noice.
    'rcarriga/nvim-notify', -- Notification backend.
  },
  opts = { -- Noice setup options.
    cmdline = { -- Command line replacement.
      enabled = true,
      view = 'cmdline_popup', -- Show cmdline as a popup.
    },
    messages = { -- Message display handling.
      enabled = true,
      view = 'notify', -- Use nvim-notify or internal notifier for messages.
      view_error = 'notify',
      view_warn = 'notify',
    },
    lsp = { -- LSP integration.
      progress = { enabled = false }, -- Disable Noice for LSP progress (handled by lualine/fidget).
      override = { -- Override default LSP handlers with Noice's.
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true, -- Use Noice for nvim-cmp documentation.
      },
    },
    presets = { -- Pre-configured UI behaviors.
      bottom_search = false, -- Search results not at bottom (likely top/popup).
      command_palette = true, -- Enable command palette-like interface.
      long_message_to_split = true, -- Split long messages.
      lsp_doc_border = false, -- No border for LSP hover docs.
    },
  },
  config = function(_, opts)
    require('noice').setup(opts)

    -- Configure nvim-notify (used by Noice).
    require('notify').setup {
      stages = 'slide', -- Notification animation style.
      timeout = 2500, -- Default notification timeout (ms).
      top_down = false, -- Notifications appear from bottom.
    }

    -- Set nvim-notify as the default for vim.notify().
    vim.notify = require 'notify'
  end,
}
