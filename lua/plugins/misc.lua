-- Miscellaneous plugins with minimal configuration.

return {
  { -- Seamless navigation between Neovim splits and Tmux panes.
    'christoomey/vim-tmux-navigator',
  },
  { -- Auto-detects indentation settings (tabstop, shiftwidth, expandtab).
    'tpope/vim-sleuth',
  },
  { -- Powerful Git wrapper for Neovim (:Git blame, :Git commit, etc.).
    'tpope/vim-fugitive',
  },
  { -- GitHub integration for vim-fugitive (:GBrowse).
    'tpope/vim-rhubarb',
  },
  { -- Improved Insert mode escaping (e.g., 'jk' to Normal mode).
    'max397574/better-escape.nvim',
    config = function() require('better_escape').setup() end, -- Uses defaults ("jk").
  },
  { -- Auto-inserts closing pairs (parenthses, brackets, quotes).
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true, -- Auto-setup with default options.
    opts = {}, -- Defaults are generally good.
  },
  { -- Highlights TODO, FIXME, NOTE, etc., in comments.
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false }, -- Disable signs in signcolumn for TODOs.
  },
  { -- Advanced multi-cursor editing.
    'mg979/vim-visual-multi',
  },
  { -- Highlights color codes (e.g., #RRGGBB, rgb()) with their actual colors.
    'norcalli/nvim-colorizer.lua',
    config = function() require('colorizer').setup() end, -- Uses defaults.
  },
  { -- Lualine component for GitHub Copilot status.
    'AndreM222/copilot-lualine',
  },
  { -- Lualine component for LSP progress.
    'arkav/lualine-lsp-progress',
  },
  { -- LSP breadcrumb navigation display (file > class > function).
    'SmiteshP/nvim-navic',
    lazy = true, -- Loaded by LSP on_attach.
    requires = 'neovim/nvim-lspconfig', -- Logical dependency.
  },
  { -- Minimal, standalone Lua modules for Neovim.
    'echasnovski/mini.nvim',
    version = '*', -- Track latest stable/main. Configure individual modules if needed.
  },
}
