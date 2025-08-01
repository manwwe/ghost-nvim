-- Configures nvim-telescope/telescope.nvim: extendable fuzzy finder.
-- Searches files, buffers, Git items, LSP symbols, help tags, etc.

return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter', -- Load on startup.
  branch = '0.1.x', -- Use stable branch.
  dependencies = {
    'nvim-lua/plenary.nvim', -- Utilities for Telescope.
    { -- Optional C backend for FZF (faster sorting/searching).
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make', -- Compile C extension.
      cond = function() return vim.fn.executable 'make' == 1 end, -- Load if 'make' is available.
    },
    { 'nvim-telescope/telescope-ui-select.nvim' }, -- Use Telescope for UI selection prompts.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font }, -- Icons (if Nerd Font enabled).
  },
  config = function()
    -- Telescope setup: global defaults and picker-specific configs.
    require('telescope').setup {
      defaults = { -- Defaults for all pickers.
        vimgrep_arguments = { -- Command for live_grep/grep_string (uses ripgrep).
          'rg', '--color=never', '--no-heading', '--with-filename',
          '--line-number', '--column', '--smart-case', '--hidden',
        },
        mappings = { -- Mappings within Telescope prompt (Insert mode).
          i = {
            ['<C-k>'] = require('telescope.actions').move_selection_previous, -- Prev result.
            ['<C-j>'] = require('telescope.actions').move_selection_next,     -- Next result.
            ['<C-l>'] = require('telescope.actions').select_default,         -- Open selected.
          },
        },
      },
      pickers = { -- Picker-specific configs.
        find_files = { file_ignore_patterns = { 'node_modules', '.git', '.venv' }, hidden = true },
        live_grep = { file_ignore_patterns = { 'node_modules', '.git', '.venv' },
                      additional_args = function(_) return { '--hidden' } end },
      },
      extensions = { -- Extension configs.
        ['ui-select'] = { require('telescope.themes').get_dropdown() }, -- Use dropdown theme for ui-select.
      },
    }

    -- Load installed extensions (fzf, ui-select).
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    local builtin = require 'telescope.builtin'
    local keymap = vim.keymap.set
    -- Keymaps for Telescope pickers.
    keymap('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
    keymap('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
    keymap('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
    keymap('n', '<leader>fs', builtin.builtin, { desc = '[F]ind [S]elect Telescope picker' })
    keymap('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
    keymap('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
    keymap('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
    keymap('n', '<leader>fr', builtin.resume, { desc = '[F]ind [R]esume last picker' })
    keymap('n', '<leader>f.', builtin.oldfiles, { desc = '[F]ind Recent Files' })
    keymap('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

    -- Custom keymap: fuzzy search in current buffer with dropdown theme.
    keymap('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10, previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- Custom keymap: live grep in open files.
    keymap('n', '<leader>f/', function()
      builtin.live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files' }
    end, { desc = '[F]ind [/] in Open Files' })
  end,
}
