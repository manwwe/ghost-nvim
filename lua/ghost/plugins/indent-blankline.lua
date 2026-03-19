-- Configures indent guides and scope highlights.

return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    indent = {
      char = "▏",
      tab_char = "▏",
      smart_indent_cap = true,
    },
    scope = {
      enabled = true,
      show_start = false,
      show_end = false,
      show_exact_scope = true,
      highlight = { "RainbowViolet" },
    },
    whitespace = {
      remove_blankline_trail = true,
    },
    exclude = {
      filetypes = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
      buftypes = { "terminal", "nofile", "quickfix", "prompt" },
    },
  },
  config = function(_, opts)
    local hooks = require "ibl.hooks"

    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
    end)

    require("ibl").setup(opts)

    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end,
}
