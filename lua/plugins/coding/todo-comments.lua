return {
  -- Highlights TODO, FIXME, NOTE, etc., in comments.
  "folke/todo-comments.nvim",
  event = "VimEnter",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = { signs = false }, -- Disable signs in signcolumn for TODOs.
}
