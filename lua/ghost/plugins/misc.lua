-- Miscellaneous plugin specs collected in one place.
-- Contains:
-- - echasnovski/mini.surround
-- - windwp/nvim-autopairs
-- - kdheepak/lazygit.nvim
-- - folke/trouble.nvim
-- - folke/which-key.nvim
-- - mistricky/codesnap.nvim

local function save_snapshot()
  local home = vim.env.HOME or "~"
  local default_path = home .. "/Pictures/codesnap.png"
  local save_path = vim.fn.input("Save snapshot to: ", default_path, "file")

  if save_path == nil or save_path == "" then
    return
  end

  vim.cmd("CodeSnapSave " .. vim.fn.fnameescape(vim.fn.expand(save_path)))
end

return {
  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    opts = {},
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    config = function()
      local autopairs = require "nvim-autopairs"

      autopairs.setup {
        check_ts = true,
      }

      local ok_cmp, cmp = pcall(require, "cmp")
      local ok_cmp_autopairs, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")

      if ok_cmp and ok_cmp_autopairs then
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end
    end,
  },
  {
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
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      win = {
        type = "split",
        position = "left",
        size = 50,
      },
    },
    keys = {
      { "<leader>dt", "<cmd>Trouble diagnostics toggle<CR>", desc = "Toggle diagnostics Trouble" },
      { "<leader>ds", "<cmd>Trouble symbols toggle win.position=left<CR>", desc = "Document symbols Trouble" },
    },
  },
  {
    "folke/which-key.nvim",
    config = function()
      local wk = require "which-key"

      wk.add {
        { "<leader>f", group = "Find & Format" },
        { "<leader>b", group = "Buffers" },
        { "<leader>g", group = "Git & Version Control" },
        { "<leader>q", group = "Quit" },
        { "<leader>s", group = "Splits" },
        { "<leader>t", group = "Terminal Management" },
        { "<leader>u", group = "Utilities & Snapshots", icon = { icon = "󰄄", color = "green" }, mode = { "n", "v" } },
        { "<leader>d", group = "Diagnostic & LSP" },
        { "<leader>e", group = "Explorer Neotree", icon = { icon = "", color = "orange" } },
        { "<leader>c", group = "Copilot AI", icon = { icon = "", color = "blue" }, mode = { "n", "v" } },
        { "<leader>m", group = "Multicursor", icon = { icon = "󰗧", color = "blue" }, mode = { "n", "v" } },
      }
    end,
  },
  {
    "mistricky/codesnap.nvim",
    tag = "v2.0.0",
    cmd = {
      "CodeSnap",
      "CodeSnapSave",
      "CodeSnapASCII",
      "CodeSnapHighlight",
      "CodeSnapHighlightSave",
    },
    keys = {
      { "<leader>uc", "<cmd>CodeSnap<CR>", mode = "x", desc = "Copy code snapshot" },
      { "<leader>uC", "<cmd>CodeSnapASCII<CR>", mode = "x", desc = "Copy ASCII snapshot" },
      { "<leader>us", save_snapshot, mode = "x", desc = "Save code snapshot" },
    },
    opts = {
      show_line_number = true,
      show_workspace = false,
      snapshot_config = {
        code_config = {
          breadcrumbs = {
            enable = true,
          },
        },
        watermark = {
          content = "ghost-nvim",
        },
      },
    },
  },
}
