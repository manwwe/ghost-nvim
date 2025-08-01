-- This file contains the configuration for various Neovim plugins related to the editor.

return {
  {
    -- Plugin: goto-preview
    -- URL: https://github.com/rmagatti/goto-preview
    "rmagatti/goto-preview",
    event = "BufEnter",
    config = true,
    keys = {
      { "<leader>ld", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", noremap = true, desc = "LSP preview definition" },
      { "<leader>lD", "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>", noremap = true, desc = "LSP preview declaration" },
      { "<leader>li", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", noremap = true, desc = "LSP preview implementation" },
      { "<leader>ly", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", noremap = true, desc = "LSP preview type definition" },
      { "<leader>lr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", noremap = true, desc = "LSP preview references" },
      { "<leader>lP", "<cmd>lua require('goto-preview').close_all_win()<CR>", noremap = true, desc = "Close all LSP preview windows" },
    },
  },
}
