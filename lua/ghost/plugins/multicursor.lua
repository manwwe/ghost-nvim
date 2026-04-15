-- Configures multicursor keymaps and highlights.

return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  event = "VeryLazy",
  config = function()
    local mc = require "multicursor-nvim"
    local keymap = require "ghost.utils.keymap"

    mc.setup()

    keymap.map({ "n", "x" }, "<leader>mk", function()
      mc.lineAddCursor(-1)
    end, "Add cursor above")
    keymap.map({ "n", "x" }, "<leader>mj", function()
      mc.lineAddCursor(1)
    end, "Add cursor below")
    keymap.map({ "n", "x" }, "<leader>mK", function()
      mc.lineSkipCursor(-1)
    end, "Skip cursor above")
    keymap.map({ "n", "x" }, "<leader>mJ", function()
      mc.lineSkipCursor(1)
    end, "Skip cursor below")
    keymap.map({ "n", "x" }, "<leader>mn", function()
      mc.matchAddCursor(1)
    end, "Add cursor to next match")
    keymap.map({ "n", "x" }, "<leader>ms", function()
      mc.matchSkipCursor(1)
    end, "Skip next match")
    keymap.map({ "n", "x" }, "<leader>mN", function()
      mc.matchAddCursor(-1)
    end, "Add cursor to previous match")
    keymap.map({ "n", "x" }, "<leader>mS", function()
      mc.matchSkipCursor(-1)
    end, "Skip previous match")
    keymap.map({ "n", "x" }, "<leader>mA", mc.matchAllAddCursors, "Add cursors to all matches")
    keymap.map({ "n", "x" }, "<leader>mq", mc.toggleCursor, "Toggle multicursor")
    keymap.map({ "n", "x" }, "<leader>mv", mc.restoreCursors, "Restore multicursor selection")
    keymap.map("n", "<leader>ma", mc.alignCursors, "Align multicursors")

    keymap.map("n", "<C-LeftMouse>", mc.handleMouse, "Add cursor with mouse")
    keymap.map("n", "<C-LeftDrag>", mc.handleMouseDrag, "Drag multicursor selection")
    keymap.map("n", "<C-LeftRelease>", mc.handleMouseRelease, "Finish multicursor drag")

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
