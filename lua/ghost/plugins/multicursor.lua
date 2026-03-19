-- Configures multicursor keymaps and highlights.

return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  event = "VeryLazy",
  config = function()
    local mc = require "multicursor-nvim"
    local set = vim.keymap.set

    mc.setup()

    set({ "n", "x" }, "<leader>mk", function()
      mc.lineAddCursor(-1)
    end, { desc = "Add cursor above" })
    set({ "n", "x" }, "<leader>mj", function()
      mc.lineAddCursor(1)
    end, { desc = "Add cursor below" })
    set({ "n", "x" }, "<leader>mK", function()
      mc.lineSkipCursor(-1)
    end, { desc = "Skip cursor above" })
    set({ "n", "x" }, "<leader>mJ", function()
      mc.lineSkipCursor(1)
    end, { desc = "Skip cursor below" })
    set({ "n", "x" }, "<leader>mn", function()
      mc.matchAddCursor(1)
    end, { desc = "Add cursor to next match" })
    set({ "n", "x" }, "<leader>ms", function()
      mc.matchSkipCursor(1)
    end, { desc = "Skip next match" })
    set({ "n", "x" }, "<leader>mN", function()
      mc.matchAddCursor(-1)
    end, { desc = "Add cursor to previous match" })
    set({ "n", "x" }, "<leader>mS", function()
      mc.matchSkipCursor(-1)
    end, { desc = "Skip previous match" })
    set({ "n", "x" }, "<leader>mA", mc.matchAllAddCursors, { desc = "Add cursors to all matches" })
    set({ "n", "x" }, "<leader>mq", mc.toggleCursor, { desc = "Toggle multicursor" })
    set({ "n", "x" }, "<leader>mv", mc.restoreCursors, { desc = "Restore multicursor selection" })
    set("n", "<leader>ma", mc.alignCursors, { desc = "Align multicursors" })

    set("n", "<C-LeftMouse>", mc.handleMouse, { desc = "Add cursor with mouse" })
    set("n", "<C-LeftDrag>", mc.handleMouseDrag, { desc = "Drag multicursor selection" })
    set("n", "<C-LeftRelease>", mc.handleMouseRelease, { desc = "Finish multicursor drag" })

    mc.addKeymapLayer(function(layerSet)
      layerSet({ "n", "x" }, "<Left>", mc.prevCursor)
      layerSet({ "n", "x" }, "<Right>", mc.nextCursor)
      layerSet({ "n", "x" }, "<leader>md", mc.deleteCursor)
      layerSet("n", "<Esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        else
          mc.clearCursors()
        end
      end)
    end)

    local hl = vim.api.nvim_set_hl
    hl(0, "MultiCursorCursor", { reverse = true })
    hl(0, "MultiCursorVisual", { link = "Visual" })
    hl(0, "MultiCursorSign", { link = "SignColumn" })
    hl(0, "MultiCursorMatchPreview", { link = "Search" })
    hl(0, "MultiCursorDisabledCursor", { reverse = true })
    hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
  end,
}
