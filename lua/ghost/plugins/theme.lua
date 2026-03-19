-- Configures the Catppuccin colorscheme.

return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
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

    vim.cmd.colorscheme "catppuccin"
  end,
}
