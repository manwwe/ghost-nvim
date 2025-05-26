-- Configures nvim-lualine/lualine.nvim: customizable statusline.

-- Load custom Lualine components.
local mode = require 'plugins.appearance.lualine_comps.mode' -- Current mode.
local diff = require 'plugins.appearance.lualine_comps.diff' -- Git diff info.
local progress_file = require 'plugins.appearance.lualine_comps.progress' -- Scroll progress.
local docker = require 'plugins.appearance.lualine_comps.docker' -- Docker status.
local lsp_status = require('plugins.appearance.lualine_comps.lsp_status').status -- LSP status.
local lsp_progress = require 'plugins.appearance.lualine_comps.lsp_progress' -- LSP progress.
local get_os = require('plugins.appearance.lualine_comps.get_os').status -- OS display.
local copilot_status = require 'plugins.appearance.lualine_comps.copilot' -- Copilot status.
local codeium_status = require 'plugins.appearance.lualine_comps.windsurf' -- Codeium status.

return {
  'nvim-lualine/lualine.nvim',
  config = function()
    require('lualine').setup {
      options = {
        globalstatus = true, -- Single statusline for all windows.
        icons_enabled = true, -- Enable icons (requires Nerd Font).
        theme = 'gruvbox', -- Lualine theme.
        section_separators = { left = '', right = '' }, -- Powerline-style section separators.
        component_separators = { left = '|', right = '|' }, -- Component separators.
        disabled_filetypes = { 'alpha' }, -- Disable Lualine for dashboard.
        always_divide_middle = true, -- Ensure middle sections are visually separated.
        ignore_focus = { 'neo-tree' }, -- Ignore focus changes for Neo-tree.
      },
      sections = { -- Content of active statusline sections.
        lualine_a = { mode }, -- Mode.
        lualine_b = { { 'branch', icon = { '' } }, diff }, -- Git branch & diff.
        lualine_c = { { 'filename', path = 0 }, 'filetype', 'encoding', 'filesize' }, -- File info.
        lualine_x = { 'diagnostics', { 'fileformat', icons_enabled = false } }, -- Diagnostics & file format.
        lualine_y = { 'hostname', get_os, lsp_status, lsp_progress }, -- System & LSP info.
        lualine_z = { copilot_status, codeium_status, docker, { 'location', padding = 0 }, { progress_file, padding = 1 } }, -- AI, Docker, location, progress.
      },
      inactive_sections = { -- Content for inactive statuslines.
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { 'filename', path = 0 } }, -- Filename only for inactive.
        lualine_x = { { 'location', padding = 0 } }, -- Location only for inactive.
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { 'fugitive', 'neo-tree' }, -- Enable extensions for Fugitive and Neo-tree.
    }
  end,
}
