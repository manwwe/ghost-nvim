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
      require('copilot_cmp').setup {
        method = 'getCompletions',
        event = { 'InsertEnter', 'LspAttach' },
        fix_pairs = true,
      }

      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      local lspkind = require 'lspkind'

      local has_words_before = function()
        local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match '^%s*$' == nil
      end

      vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', { fg = '#6CC644' }) --Copilot completion color
      vim.api.nvim_set_hl(0, 'CmpItemKindCodeium', { fg = '#00BFFF' }) --Codeium completion color

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm { select = true },
          ['<Tab>'] = vim.schedule_wrap(function(fallback)
            if cmp.visible() and has_words_before() then
              cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = vim.schedule_wrap(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = cmp.config.sources {
          { name = 'copilot', group_index = 2 },
          { name = 'codeium', group_index = 2 },
          { name = 'nvim_lsp', group_index = 2 },
          { name = 'luasnip', group_index = 2 },
          { name = 'buffer', group_index = 2 },
          { name = 'path', group_index = 2 },
        },
        formatting = {
          format = lspkind.cmp_format {
            mode = 'symbol_text',
            maxwidth = 50,
            ellipsis_char = '...',
            symbol_map = { Copilot = '', Codeium = '' },
            before = function(entry, vim_item)
              vim_item.menu = ({
                copilot = '[Copilot]',
                codeium = '[Codeium]',
                nvim_lsp = '[LSP]',
                luasnip = '[Snip]',
                buffer = '[Buf]',
                path = '[Path]',
              })[entry.source.name]
              return vim_item
            end,
          },
        },
        sorting = {
          priority_weight = 2,
          comparators = {
            require('copilot_cmp.comparators').prioritize, -- prioritize Copilot suggestions.
            require('cmp.config.compare').prioritize_codeium, -- Prioritize Codeium suggestions.
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
      }
    end,
  },
}
