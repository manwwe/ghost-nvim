-- Configures Telescope pickers and keymaps.

return {
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  branch = "0.1.x",
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

    local builtin = require "telescope.builtin"
    local keymap = vim.keymap.set
    keymap("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
    keymap("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
    keymap("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
    keymap("n", "<leader>fs", builtin.builtin, { desc = "[F]ind [S]elect Telescope picker" })
    keymap("n", "<leader>fw", builtin.grep_string, { desc = "[F]ind current [W]ord" })
    keymap("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" })
    keymap("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
    keymap("n", "<leader>fr", builtin.resume, { desc = "[F]ind [R]esume last picker" })
    keymap("n", "<leader>f.", builtin.oldfiles, { desc = "[F]ind Recent Files" })
    keymap("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

    keymap("n", "<leader>/", function()
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = "[/] Fuzzily search in current buffer" })

    keymap("n", "<leader>f/", function()
      builtin.live_grep { grep_open_files = true, prompt_title = "Live Grep in Open Files" }
    end, { desc = "[F]ind [/] in Open Files" })
  end,
}
