-- Configures folke/persistence.nvim: auto-saves and restores Neovim sessions.

return {
  "folke/persistence.nvim",
  event = "BufReadPre", -- Load early to handle session logic.
  config = function()
    require("persistence").setup({
      -- Directory to save session files.
      dir = vim.fn.stdpath("state") .. "/sessions/", -- Uses ~/.local/state/nvim/sessions/
      -- Aspects of the session to save.
      options = { "buffers", "curdir", "tabpages", "winsize" },
      -- `autosave = true` and `autoload = true` are defaults.
    })

    -- Keymaps for persistence.nvim.
    local keymap = vim.keymap.set
    keymap("n", "<leader>ps", function()
      require("persistence").load()
    end, { desc = "Restore session for current directory" })
    keymap("n", "<leader>pS", function()
      require("persistence").select()
    end, { desc = "Select a session to load" })
    keymap("n", "<leader>pl", function()
      require("persistence").load({ last = true })
    end, { desc = "Load last session" })
    keymap("n", "<leader>pd", function()
      require("persistence").stop()
    end, { desc = "Don't save current session" })
  end,
}
