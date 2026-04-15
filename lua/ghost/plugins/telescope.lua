-- Configures Telescope pickers and keymaps.

local function builtin_picker(name, opts)
  return function()
    require("telescope.builtin")[name](opts)
  end
end

local function current_buffer_fuzzy_find()
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
    winblend = 10,
    previewer = false,
  })
end

local function live_grep_open_files()
  require("telescope.builtin").live_grep {
    grep_open_files = true,
    prompt_title = "Live Grep in Open Files",
  }
end

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  cmd = "Telescope",
  keys = {
    { "<leader>fh", builtin_picker "help_tags", desc = "[F]ind [H]elp" },
    { "<leader>fk", builtin_picker "keymaps", desc = "[F]ind [K]eymaps" },
    { "<leader>ff", builtin_picker "find_files", desc = "[F]ind [F]iles" },
    { "<leader>fs", builtin_picker "builtin", desc = "[F]ind [S]elect Telescope picker" },
    { "<leader>fw", builtin_picker "grep_string", desc = "[F]ind current [W]ord" },
    { "<leader>fg", builtin_picker "live_grep", desc = "[F]ind by [G]rep" },
    { "<leader>fd", builtin_picker "diagnostics", desc = "[F]ind [D]iagnostics" },
    { "<leader>fr", builtin_picker "resume", desc = "[F]ind [R]esume last picker" },
    { "<leader>f.", builtin_picker "oldfiles", desc = "[F]ind Recent Files" },
    { "<leader><leader>", builtin_picker "buffers", desc = "[ ] Find existing buffers" },
    { "<leader>/", current_buffer_fuzzy_find, desc = "[/] Fuzzily search in current buffer" },
    { "<leader>f/", live_grep_open_files, desc = "[F]ind [/] in Open Files" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable "make" == 1
      end,
    },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
  },
  config = function()
    require("telescope").setup {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
        },
        mappings = {
          i = {
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-l>"] = require("telescope.actions").select_default,
          },
        },
      },
      pickers = {
        find_files = { file_ignore_patterns = { "node_modules", ".git", ".venv" }, hidden = true },
        live_grep = {
          file_ignore_patterns = { "node_modules", ".git", ".venv" },
          additional_args = function(_)
            return { "--hidden" }
          end,
        },
      },
      extensions = {
        ["ui-select"] = { require("telescope.themes").get_dropdown() },
      },
    }

    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")
  end,
}
