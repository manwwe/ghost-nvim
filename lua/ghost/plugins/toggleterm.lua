-- Configures toggleterm terminals and runners.

local file_runners = {}
local cmd_map = {
  python = "python3",
  lua = "lua",
  sh = "bash",
}

local function runner_command(interpreter, file)
  return interpreter .. " " .. vim.fn.shellescape(file)
end

local function reset_runner(file)
  local term = file_runners[file]

  if not term then
    return
  end

  term:shutdown()
  file_runners[file] = nil
end

local function run_current_file()
  local ft = vim.bo.filetype
  local interp = cmd_map[ft]

  if not interp then
    vim.notify("Unsupported filetype for execution: " .. ft, vim.log.levels.WARN)
    return
  end

  if vim.bo.modified then
    vim.cmd.write()
  end

  local file = vim.fn.expand "%:p"
  local cmd = runner_command(interp, file)
  local display_name = vim.fn.fnamemodify(file, ":t")

  reset_runner(file)

  local term = require("toggleterm.terminal").Terminal:new {
    cmd = cmd,
    hidden = true,
    direction = "float",
    close_on_exit = false,
    auto_scroll = true,
    display_name = display_name,
    name = "file_runner_" .. display_name,
  }

  file_runners[file] = term
  term:open()
end

return {
  "akinsho/toggleterm.nvim",
  cmd = { "ToggleTerm", "TermExec" },
  keys = {
    { "<C-/>", "<cmd>ToggleTerm<CR>", desc = "Toggle terminal", mode = { "n", "t" } },
    { "<C-_>", "<cmd>ToggleTerm<CR>", desc = "Toggle terminal", mode = { "n", "t" } },
    { "<leader>tr", run_current_file, desc = "Run current file" },
    { "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", desc = "Open floating terminal" },
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<CR>", desc = "Open vertical terminal" },
  },
  config = function()
    local ui = require "ghost.utils.ui"

    require("toggleterm").setup {
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
          return " terminal | id: " .. term.id .. " | " .. (term.display_name or term.cmd or "shell")
        end,
      },
      float_opts = { border = ui.border.terminal, title_pos = "left" },
    }
  end,
}
