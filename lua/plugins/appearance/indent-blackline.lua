-- Configures indent-blankline.nvim: adds indent guides and scope lines.

return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl", -- Main plugin module.
  opts = { -- Default options.
    indent = { -- Indentation line config.
      char = "▏",
      tab_char = "▏",
      smart_indent_cap = true, -- Cap indent lines at text start.
    },
    scope = { -- Scope line config (visualizing code blocks).
      enabled = true,
      show_start = false,
      show_end = false,
      show_exact_scope = true,
      highlight = { "RainbowViolet" }, -- Highlight for scope lines.
    },
    whitespace = {
      remove_blankline_trail = true, -- Remove trailing whitespace on blank lines.
    },
    exclude = { -- Disable for specific filetypes/buftypes.
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
    local hooks = require("ibl.hooks")

    -- Setup custom highlight groups for rainbow indent lines.
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

    -- Hook for scope highlighting, using extmarks (for Treesitter compatibility).
    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end,
}
