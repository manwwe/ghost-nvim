-- Configures nvim-cmp completion sources and mappings.

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    require("luasnip.loaders.from_vscode").lazy_load()

    local function set_popup_highlights()
      vim.api.nvim_set_hl(0, "GhostCmpNormal", { fg = "#d3c6aa", bg = "#344047" })
      vim.api.nvim_set_hl(0, "GhostCmpBorder", { fg = "#859289", bg = "#344047" })
      vim.api.nvim_set_hl(0, "GhostCmpSelection", { fg = "#232a2e", bg = "#a7c080", bold = true })
    end

    set_popup_highlights()
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("GhostCmpHighlights", { clear = true }),
      callback = set_popup_highlights,
    })

    local popup_highlights =
      "Normal:GhostCmpNormal,FloatBorder:GhostCmpBorder,CursorLine:GhostCmpSelection,Search:None"

    cmp.setup({
      window = {
        completion = {
          border = "rounded",
          winhighlight = popup_highlights,
          winblend = 0,
          max_height = 10,
        },
        documentation = {
          border = "rounded",
          winhighlight = popup_highlights,
          winblend = 0,
          max_width = 60,
          max_height = 15,
        },
      },
      formatting = {
        fields = { "abbr", "kind" },
        format = function(_, item)
          if vim.fn.strchars(item.abbr) > 40 then
            item.abbr = vim.fn.strcharpart(item.abbr, 0, 39) .. "…"
          end
          return item
        end,
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-j>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-k>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-f>"] = cmp.mapping(function(fallback)
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-b>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<Tab>"] = cmp.mapping.confirm({ select = false }),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          fallback()
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
      }, {
        { name = "buffer" },
      }),
    })

    -- cmp-nvim-lsp normally registers clients only on InsertEnter. A server
    -- can attach later while the user is already typing.
    local function refresh_lsp_sources()
      require("cmp_nvim_lsp")._on_insert_enter()
    end

    refresh_lsp_sources()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("GhostCmpLspAttach", { clear = true }),
      callback = function(event)
        vim.schedule(function()
          if not vim.api.nvim_buf_is_valid(event.buf) then
            return
          end
          vim.api.nvim_buf_call(event.buf, refresh_lsp_sources)
          if event.buf == vim.api.nvim_get_current_buf() and vim.api.nvim_get_mode().mode == "i" then
            cmp.complete()
          end
        end)
      end,
    })
  end,
}
