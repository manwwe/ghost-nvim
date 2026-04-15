-- Registers available colorschemes and their individual setup.

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    priority = 1000,
    config = function()
      local ok, catppuccin = pcall(require, "catppuccin")

      if not ok then
        vim.notify("catppuccin is not available", vim.log.levels.ERROR)
        return
      end

      catppuccin.setup {
        flavour = "frappe",
        transparent_background = false,
        show_end_of_buffer = true,
        term_colors = true,
        color_overrides = {
          frappe = {
            base = "#25272d",
          },
        },
        custom_highlights = function(colors)
          return {
            Comment = { fg = colors.overlay0, italic = true },
            Function = { fg = colors.blue, bold = true },
            Keyword = { fg = colors.red, bold = true },
            String = { fg = colors.yellow },
            ["@keyword.function"] = { fg = colors.red, bold = true },
            ["@string.documentation"] = { fg = "#556E53", italic = true },
            WinSeparator = { fg = colors.overlay0, bg = "NONE", bold = false },
            CursorLineNr = { fg = "#ffaf00", bold = false },
            CursorLine = { bg = "NONE" },
          }
        end,
        integrations = {
          cmp = true,
          gitsigns = true,
          telescope = true,
          treesitter = true,
          notify = true,
          which_key = true,
          lsp_trouble = true,
          neotree = true,
          render_markdown = false,
        },
      }
    end,
  },
  {
    "morhetz/gruvbox",
    name = "gruvbox",
    lazy = true,
    priority = 1000,
    config = function()
      vim.g.gruvbox_contrast_dark = "hard"
      vim.g.gruvbox_italic = 1
      vim.g.gruvbox_italicize_comments = 1
      vim.g.gruvbox_italicize_strings = 0
      vim.g.gruvbox_invert_selection = 0
      vim.g.gruvbox_underline = 1
      vim.g.gruvbox_undercurl = 1
      vim.g.gruvbox_bold = 1
      vim.g.gruvbox_transparent_bg = 0
    end,
  },
  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    lazy = true,
    priority = 1000,
    config = function()
      local ok, tokyonight = pcall(require, "tokyonight")

      if not ok then
        vim.notify("tokyonight is not available", vim.log.levels.ERROR)
        return
      end

      tokyonight.setup {
        style = "storm",
        transparent = false,
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = false },
        },
      }
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    lazy = true,
    priority = 1000,
    config = function()
      local ok, kanagawa = pcall(require, "kanagawa")

      if not ok then
        vim.notify("kanagawa is not available", vim.log.levels.ERROR)
        return
      end

      kanagawa.setup {
        compile = false,
        transparent = false,
        theme = "wave",
        background = {
          dark = "wave",
          light = "lotus",
        },
        commentStyle = { italic = true },
        keywordStyle = { italic = false },
      }
    end,
  },
  {
    "vague2k/vague.nvim",
    name = "vague",
    lazy = true,
    priority = 1000,
    config = function()
      local ok, vague = pcall(require, "vague")

      if not ok then
        vim.notify("vague is not available", vim.log.levels.ERROR)
        return
      end

      vague.setup {
        transparent = false,
        bold = true,
        italic = true,
      }
    end,
  },
  {
    "sainnhe/everforest",
    name = "everforest",
    lazy = true,
    priority = 1000,
    config = function()
      vim.g.everforest_background = "hard"
      vim.g.everforest_enable_italic = 1
      vim.g.everforest_disable_italic_comment = 0
      vim.g.everforest_better_performance = 1
      vim.g.everforest_transparent_background = 0
    end,
  },
}
