-- Configures LazyGit integration.

return {
  "kdheepak/lazygit.nvim",
  lazy = true,
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>gg", "<cmd>LazyGit<CR>", desc = "LazyGit" },
  },
  config = function()
    if pcall(require, "telescope") then
      require("telescope").load_extension "lazygit"
    end
  end,
}
