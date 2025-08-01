-- Configures lewis6991/gitsigns.nvim: Git change markers in signcolumn & hunk utilities.

return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" }, -- Load early for quick sign display.
  dependencies = { "nvim-lua/plenary.nvim" }, -- Utility functions.
  opts = {
    signs = { -- Signs for unstaged changes.
      add = { text = " +" },
      change = { text = " ~" },
      delete = { text = " _" },
      topdelete = { text = " ‾" },
      changedelete = { text = " ~" },
    },
    signs_staged = { -- Signs for staged changes.
      add = { text = " +" },
      change = { text = " ~" },
      delete = { text = " _" },
      topdelete = { text = " ‾" },
      changedelete = { text = " ~" },
    },
    signs_staged_enable = true, -- Enable distinct signs for staged changes.
    signcolumn = true, -- Always show signcolumn.
    -- numhl = true, -- Disable numhl.
    -- linehl = true, -- Disable linehl.
    -- word_diff = true, -- Enable word diff.
    current_line_blame_formatter = "<author>, <author_time:%R> - <summary>", -- Blame format.
    on_attach = function(bufnr) -- Runs when gitsigns attaches to a buffer.
      local gs = package.loaded.gitsigns
      local keymap = function(mode, lhs, rhs, desc) -- Helper for buffer-local keymaps.
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, noremap = true, silent = true })
      end

      -- Navigation
      keymap("n", "]g", gs.next_hunk, "Next Hunk")
      keymap("n", "[g", gs.prev_hunk, "Prev Hunk")

      -- Actions
      keymap("n", "<leader>gs", gs.stage_hunk, "Stage Hunk")
      keymap("n", "<leader>gr", gs.reset_hunk, "Reset Hunk")
      keymap("n", "<leader>gS", gs.stage_buffer, "Stage Buffer")
      keymap("n", "<leader>gR", gs.reset_buffer, "Reset Buffer")
      keymap("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")

      -- Preview & Diff
      keymap("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
      keymap("n", "<leader>gd", gs.diffthis, "Diff This (vs Index)")
      keymap("n", "<leader>gD", function()
        gs.diffthis("~")
      end, "Diff With HEAD")
      keymap("n", "<leader>gb", function()
        gs.blame_line({ full = true })
      end, "Blame Line (full)")
    end,
  },
}
