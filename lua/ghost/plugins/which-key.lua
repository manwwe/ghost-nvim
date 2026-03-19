-- Configures which-key group labels.

return {
  "folke/which-key.nvim",
  config = function()
    local wk = require "which-key"

    wk.add {
      { "<leader>f", group = "Telescope [F]ind tools" },
      { "<leader>g", group = "Git & Version Control" },
      { "<leader>t", group = "Terminal Management" },
      { "<leader>d", group = "Diagnostic & LSP" },
      { "<leader>e", group = "Explorer Neotree", icon = { icon = "", color = "orange" } },
      { "<leader>c", group = "Copilot AI", icon = { icon = "", color = "blue" }, mode = { "n", "v" } },
      { "<leader>l", group = "Window & Wrap", icon = { icon = "󰖲", color = "blue" }, mode = { "n", "v" } },
      { "<leader>m", group = "Multicursor", icon = { icon = "󰗧", color = "blue" }, mode = { "n", "v" } },
    }
  end,
}
