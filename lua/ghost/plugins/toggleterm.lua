-- Configures toggleterm terminals and runners.

return {
  "akinsho/toggleterm.nvim",
  config = function()
    local toggleterm = require "toggleterm"
    local Terminal = require("toggleterm.terminal").Terminal

    toggleterm.setup {
      shade_terminals = true,
      insert_mappings = true,
      start_in_insert = true,
      persist_mode = true,
      auto_scroll = true,
      direction = "horizontal",
      size = 17,
      open_mapping = [[<C-/>]],
      autochdir = true,
      winbar = {
        enabled = true,
        name_formatter = function(term)
          return " terminal | id: " .. term.id .. " | cmd: " .. (term.cmd or "shell")
        end,
      },
      float_opts = { border = "single", title_pos = "left" },
    }

    local file_runners = {}
    local cmd_map = {
      python = "python3",
      lua = "lua",
      sh = "bash",
    }

    local function run_current_file()
      local ft = vim.bo.filetype
      local interp = cmd_map[ft]
      if not interp then
        vim.notify("Unsupported filetype for execution: " .. ft, vim.log.levels.WARN)
        return
      end

      local file = vim.fn.expand "%:p"
      local term = file_runners[ft]

      if not term then
        term = Terminal:new {
          cmd = interp .. " " .. file,
          hidden = true,
          direction = "float",
          close_on_exit = false,
          auto_scroll = true,
          name = "file_runner_" .. ft,
        }
        file_runners[ft] = term
      else
        term.cmd = interp .. " " .. file
      end
      term:toggle()
    end

    local keymap = vim.keymap.set
    keymap("n", "<leader>tr", run_current_file, { noremap = true, silent = true, desc = "Run current file" })
    keymap("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { noremap = true, silent = true, desc = "Open floating terminal" })
    keymap("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<CR>", { noremap = true, silent = true, desc = "Open Vertical terminal" })
  end,
}
