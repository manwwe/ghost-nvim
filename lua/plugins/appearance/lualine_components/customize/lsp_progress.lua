-- Lualine 'lsp_progress' component configuration.
-- Displays ongoing LSP activities (scanning, indexing).

local lsp_spinner = {
  "lsp_progress", -- Use Lualine's built-in 'lsp_progress'.
  display_components = { "spinner" }, -- Show LSP client name and spinner.
  separators = {
    spinner = { pre = "", post = "" }, -- No separators around spinner.
    lsp_client_name = { pre = "[", post = "]" }, -- Bracket LSP client name.
  },
  timer = { -- Timing for display.
    spinner = 150, -- Spinner animation interval (ms).
    progress_enddelay = 2500, -- Keep message visible after task ends (ms).
    lsp_client_name_enddelay = 1000, -- Keep client name visible after task ends (ms).
  },
  spinner_symbols = { "", "", "", "", "", "" }, -- Nerd Font spinner animation frames.
}

return lsp_spinner
