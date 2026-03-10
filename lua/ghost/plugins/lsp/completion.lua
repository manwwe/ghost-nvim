-- completion.lua
-- Autocompletion via nvim-cmp with LSP, Copilot, buffer, path and snippets.
-- Requires Neovim >= 0.11

return {
  -- Snippet engine
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets", -- collection of ready-to-use snippets
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  -- Copilot integration
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        -- Disable ghost text and panel to avoid interfering with nvim-cmp
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },

  -- Copilot source for nvim-cmp
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  -- Autocompletion engine
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",        -- LSP source
      "hrsh7th/cmp-buffer",          -- buffer words source
      "hrsh7th/cmp-path",            -- filesystem path source
      "saadparwaiz1/cmp_luasnip",    -- LuaSnip source
      "onsails/lspkind.nvim",        -- icons in completion menu
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        mapping = cmp.mapping.preset.insert({
          -- Navigate completion menu
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),

          -- Scroll documentation
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),

          -- Manually trigger and close completion menu
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),

          -- Confirm with Enter (only confirms explicitly selected items)
          ["<CR>"] = cmp.mapping.confirm({ select = false }),

          -- Confirm with Tab / jump through snippet placeholders
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm({ select = true })
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),

          -- Jump backwards through snippet placeholders
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),

        -- Sources ordered by priority
        sources = cmp.config.sources({
          { name = "copilot",  group_index = 1 },
          { name = "nvim_lsp", group_index = 1 },
          { name = "luasnip",  group_index = 1 },
          { name = "path",     group_index = 2 },
          { name = "buffer",   group_index = 2, keyword_length = 3 },
        }),

        -- Menu icons and formatting
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
            symbol_map = { Copilot = "" },
          }),
        },

        -- Do not autoselect first item
        preselect = cmp.PreselectMode.None,

        experimental = {
          ghost_text = false, -- disabled to avoid conflict with Copilot ghost text
        },
      })

      -- Hide Copilot ghost text when cmp menu is open to avoid overlap
      cmp.event:on("menu_opened", function()
        vim.b.copilot_suggestion_hidden = true
      end)
      cmp.event:on("menu_closed", function()
        vim.b.copilot_suggestion_hidden = false
      end)
    end,
  },
}
