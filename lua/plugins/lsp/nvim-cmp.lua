-- Configuration for hrsh7th/nvim-cmp, an autocomplete plugin for Neovim.
-- Provides integration with multiple completion sources (LSP, snippets, buffer, etc.).

return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter', -- Loads the plugin when entering Insert mode.
    dependencies = {
      'zbirenbaum/copilot-cmp', -- Integration with GitHub Copilot.
      'hrsh7th/cmp-nvim-lsp', -- Completion source for LSP.
      'hrsh7th/cmp-buffer', -- Source for words from the current buffer.
      'hrsh7th/cmp-path', -- Source for file system paths.
      'L3MON4D3/LuaSnip', -- Snippet engine.
      'saadparwaiz1/cmp_luasnip', -- Adapter to use LuaSnip as a source.
      'onsails/lspkind-nvim', -- Icons for completion types.
    },
    config = function()
      -- Constants and configurations
      local highlight_colors = {
        CmpItemKindCopilot = '#6CC644', -- Copilot completion color
        CmpItemKindCodeium = '#00BFFF', -- Codeium completion color
      }

      local completion_sources = {
        { name = 'copilot', group_index = 1, priority = 1000 },
        { name = 'codeium', group_index = 1, priority = 1000 },
        { name = 'nvim_lsp', group_index = 2, priority = 900 },
        { name = 'luasnip', group_index = 2, priority = 750 },
        { name = 'buffer', group_index = 3, priority = 500 },
        { name = 'path', group_index = 3, priority = 250 },
      }

      local source_menu_labels = {
        copilot = '[Copilot]',
        codeium = '[Codeium]',
        nvim_lsp = '[LSP]',
        luasnip = '[Snip]',
        buffer = '[Buf]',
        path = '[Path]',
      }

      -- Setup highlight colors
      for group, color in pairs(highlight_colors) do
        vim.api.nvim_set_hl(0, group, { fg = color })
      end

      -- Setup Copilot CMP integration if available
      if pcall(require, 'copilot_cmp') then
        require('copilot_cmp').setup {
          method = 'getCompletions',
          event = { 'InsertEnter', 'LspAttach' },
          fix_pairs = true,
        }
      end

      -- Load required modules
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      local lspkind = require 'lspkind'

      -- Helper function to check if there are words before cursor
      -- Modified to be less restrictive for AI completions
      local function has_words_before()
        local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
      end

      -- Setup nvim-cmp
      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        -- Key mappings for completion
        mapping = cmp.mapping.preset.insert {
          ['<C-b>'] = cmp.mapping.scroll_docs(-4), -- Scroll documentation up
          ['<C-f>'] = cmp.mapping.scroll_docs(4), -- Scroll documentation down
          ['<C-Space>'] = cmp.mapping.complete(), -- Trigger completion
          ['<C-y>'] = cmp.mapping.confirm { select = true }, -- Accept completion

          -- Tab: select next item if completion visible and words before cursor
          ['<Tab>'] = vim.schedule_wrap(function(fallback)
            if cmp.visible() and has_words_before() then
              cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
            else
              fallback()
            end
          end, { 'i', 's' }),

          -- Shift-Tab: select previous item if completion visible
          ['<S-Tab>'] = vim.schedule_wrap(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
            else
              fallback()
            end
          end, { 'i', 's' }),
        },

        -- Completion sources configuration
        sources = cmp.config.sources(completion_sources),

        -- Formatting configuration with icons and labels
        formatting = {
          format = lspkind.cmp_format {
            mode = 'symbol_text',
            maxwidth = 50,
            ellipsis_char = '...',
            symbol_map = {
              Copilot = '',
              Codeium = '',
            },
            before = function(entry, vim_item)
              vim_item.menu = source_menu_labels[entry.source.name]
              return vim_item
            end,
          },
        },

        -- Sorting configuration with AI prioritization
        sorting = {
          priority_weight = 2,
          comparators = {
            -- AI completions first
            require('copilot_cmp.comparators').prioritize, -- Prioritize Copilot suggestions

            -- Standard comparators
            cmp.config.compare.offset, -- Prefer completions closer to cursor
            cmp.config.compare.exact, -- Exact matches first
            cmp.config.compare.score, -- Higher scored items first
            cmp.config.compare.recently_used, -- Recently used items
            cmp.config.compare.locality, -- Local items first
            cmp.config.compare.kind, -- Sort by completion kind
            cmp.config.compare.sort_text, -- Sort by provided sort text
            cmp.config.compare.length, -- Shorter items first
            cmp.config.compare.order, -- Maintain source order
          },
        },
      }
    end,
  },
}
