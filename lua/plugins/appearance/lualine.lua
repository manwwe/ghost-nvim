-- Configures nvim-lualine/lualine.nvim: customizable statusline.

-- Load custom Lualine components.
local mode = require("plugins.appearance.lualine_components.customize.mode") -- Current mode.
local diff = require("plugins.appearance.lualine_components.customize.diff") -- Git diff info.
local lsp_status = require("plugins.appearance.lualine_components.customize.lsp_status").status -- LSP status.
local lsp_progress = require("plugins.appearance.lualine_components.customize.lsp_progress") -- LSP progress.
local codeium_status = require("plugins.appearance.lualine_components.customize.windsurf") -- Codeium status.
local lsp_client = require("plugins.appearance.lualine_components.customize.lsp_client") -- LSP client.

return {
  {
    "nvim-lualine/lualine.nvim",
    requires = {
      "AndreM222/copilot-lualine",
    },
    opts = {
      options = {
        theme = "onedark",
        globalstatus = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = { "alpha" },
          winbar = { "alpha" },
        },
      },
      sections = {
        lualine_a = { mode },
        lualine_b = {
          { "branch", icon = "" },
          diff,
        },
        lualine_c = {
          { "filetype", icon_only = true, padding = { left = 1, right = 0 } },
          {
            "filename",
            padding = { left = 0, right = 0 },
            symbols = { modified = " ", readonly = " ", unnamed = "" },
          },
        },
        lualine_x = { "diagnostics", lsp_client, lsp_status, lsp_progress },
        lualine_y = {
          { "copilot", padding = { left = 1, right = 0 } },
          codeium_status,
        },
        lualine_z = { { "location", padding = { left = 0, right = 0 } }, "progress" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "neo-tree", "toggleterm" },
    },
  },
}
