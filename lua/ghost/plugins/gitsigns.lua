-- Configures gitsigns for Git signs and hunk actions.

return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    signs = {
      add = { text = " +" },
      change = { text = " ~" },
      delete = { text = " _" },
      topdelete = { text = " ‾" },
      changedelete = { text = " ~" },
    },
    signs_staged = {
      add = { text = " +" },
      change = { text = " ~" },
      delete = { text = " _" },
      topdelete = { text = " ‾" },
      changedelete = { text = " ~" },
    },
    signs_staged_enable = true,
    signcolumn = true,
    current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local keymap = require("ghost.utils.keymap").buf_map

      keymap(bufnr, "n", "]g", gs.next_hunk, "Next Hunk")
      keymap(bufnr, "n", "[g", gs.prev_hunk, "Prev Hunk")

      keymap(bufnr, "n", "<leader>gs", gs.stage_hunk, "Stage Hunk")
      keymap(bufnr, "n", "<leader>gr", gs.reset_hunk, "Reset Hunk")
      keymap(bufnr, "n", "<leader>gS", gs.stage_buffer, "Stage Buffer")
      keymap(bufnr, "n", "<leader>gR", gs.reset_buffer, "Reset Buffer")
      keymap(bufnr, "n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")

      keymap(bufnr, "n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
      keymap(bufnr, "n", "<leader>gd", gs.diffthis, "Diff This (vs Index)")
      keymap(bufnr, "n", "<leader>gD", function()
        gs.diffthis "~"
      end, "Diff With HEAD")
      keymap(bufnr, "n", "<leader>gb", function()
        gs.blame_line { full = true }
      end, "Blame Line (full)")
    end,
  },
}
