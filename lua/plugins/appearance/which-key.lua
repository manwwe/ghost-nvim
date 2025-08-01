-- Configures folke/which-key.nvim: displays key binding hints.
-- Shows possible keys when a prefix (e.g., <leader>) is pressed.

return {
  "folke/which-key.nvim",
  config = function()
    local wk = require("which-key")

    -- Register groups of key mappings for which-key display.
    -- Organizes related keymaps under a common prefix.
    wk.add({
      { "<leader>p", group = "Sesion Management" },
      { "<leader>f", group = "Telescope [F]ind tools" },
      { "<leader>g", group = "Git & Version Control" },
      { "<leader>t", group = "Terminal Management" },
      { "<leader>d", group = "Diagnostic & LSP" },
      { "<leader>e", group = "Explorer Neotree", icon = { icon = "", color = "orange" } }, -- Nerd Font icon.
      { "<leader>a", group = "Avante AI", icon = { icon = "󰚩", color = "blue" }, mode = { "n", "v" } }, -- Nerd Font icon.
      { "<leader>c", group = "Copilot AI", icon = { icon = "", color = "blue" }, mode = { "n", "v" } }, -- Nerd Font icon.
      { "<leader>o", group = "OpenAI - ChatGPT", icon = { icon = "", color = "blue" }, mode = { "n", "v" } }, -- Nerd Font icon.
      { "<leader>l", group = "Goto-Preview", icon = { icon = "󰈹", color = "blue" }, mode = { "n", "v" } }, -- Nerd Font icon.
      { "<leader>m", group = "Markdown Preview", icon = { icon = "󰒻", color = "blue" }, mode = { "n", "v" } }, -- Nerd Font icon.
      -- which-key also auto-registers mappings with a `desc` field set via `vim.keymap.set`.
    })
  end,
}
