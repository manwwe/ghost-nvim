-- Configures the alpha-nvim dashboard.

return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  cmd = "Alpha",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "folke/snacks.nvim",
  },

  config = function()
    local alpha = require "alpha"
    local dashboard = require "alpha.themes.dashboard"

    dashboard.section.header.val = {
      [[                        ⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⢸⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀                         ]],
      [[⠀⠀⠀⠀⠀⠀                         ⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀                         ]],
      [[⠀⠀⠀⠀                         ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀                         ]],
      [[⠀                        ⠀ ⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⠀⠀                         ]],
      [[⠀⠀                        ⣿⣿⣿⣿⡟⠛⠛⠛⠛⣿⣿⣿⣿⣿⣿⣿⣿⠛⠛⠛⠛⢻⣿⣿⣿⣿⠀⠀                         ]],
      [[⠀⠀                        ⣿⣿⡟⠛⠃⠀⠀⠀⠀⠛⠛⣿⣿⣿⣿⠛⠛⠀⠀⠀⠀⠘⠛⢻⣿⣿⠀⠀                         ]],
      [[                        ⣶⣶⣿⣿⡇⠀⠀⠀⢸⣿⣷⣶⠀⣿⣿⣿⣿⠀⠀⠀⠀⣿⣿⣶⡆⢸⣿⣿⣶⣶                         ]],
      [[                        ⣿⣿⣿⣿⡇⠀⠀⠀⢸⣿⠿⠿⠀⣿⣿⣿⣿⠀⠀⠀⠀⣿⣿⠿⠇⢸⣿⣿⣿⣿                         ]],
      [[                        ⣿⣿⣿⣿⣧⣤⡄⠀⠀⠀⠀⣤⣤⣿⣿⣿⣿⣤⣤⠀⠀⠀⠀⢠⣤⣼⣿⣿⣿⣿                         ]],
      [[                        ⣿⣿⣿⣿⣿⣿⣧⣤⣤⣤⣤⣿⣿⣿⣿⣿⣿⣿⣿⣤⣤⣤⣤⣼⣿⣿⣿⣿⣿⣿                         ]],
      [[                        ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿                         ]],
      [[                        ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿                         ]],
      [[                        ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿                         ]],
      [[                        ⣿⣿⣿⣿⠀ ⢹⣿⣿⣿⣿⣿⣿⡇⠀⠀⠘⣿⣿⣿⣿⣿⣿⡇  ⣿⣿⣿⣿                         ]],
      [[                        ⣿⣿⡏⠀⠀⠀⠀⠀⢹⣿⣿⣿⣿⠁⠀⠀⠀⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⢻⣿⣿                         ]],
      [[                                                                               ]],
      [[ ██████╗ ██╗  ██╗ ██████╗ ███████╗████████╗   ███╗   ██╗██╗   ██╗██╗███╗   ███╗]],
      [[██╔════╝ ██║  ██║██╔═══██╗██╔════╝╚══██╔══╝   ████╗  ██║██║   ██║██║████╗ ████║]],
      [[██║  ███╗███████║██║   ██║███████╗   ██║█████╗██╔██╗ ██║██║   ██║██║██╔████╔██║]],
      [[██║   ██║██╔══██║██║   ██║╚════██║   ██║╚════╝██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
      [[╚██████╔╝██║  ██║╚██████╔╝███████║   ██║      ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║]],
      [[ ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝      ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝]],
    }

    dashboard.section.buttons.val = {
      dashboard.button("f", "󰈞  Find file", ":lua Snacks.picker.files()<CR>"),
      dashboard.button("g", " Find text", ":lua Snacks.picker.grep()<CR>"),
      dashboard.button("r", "󱋡 find used files", ":lua Snacks.picker.recent()<CR>"),
      dashboard.button("t", "  Find tags", ":lua Snacks.picker.help()<CR>"),
      dashboard.button("c", "  Find git commits", ":lua Snacks.picker.git_log()<CR>"),
      dashboard.button("b", " Find git branches", ":lua Snacks.picker.git_branches()<CR>"),
      dashboard.button("s", "  Settings", ":e $MYVIMRC<CR>"),
      dashboard.button("q", "󰩈  Quit Neovim", ":qa<CR>"),
    }

    local function get_current_date()
      return os.date " Today is %A, %B %d, %Y"
    end

    local function welcome_user()
      local username = os.getenv "USER" or os.getenv "USERNAME" or "friend"
      return string.format("󱠢 Welcome back, %s!", username)
    end

    dashboard.section.footer.val = {
      welcome_user(),
      get_current_date(),
    }

    dashboard.opts.layout = {
      { type = "padding", val = 4 },
      dashboard.section.header,
      { type = "padding", val = 4 },
      dashboard.section.buttons,
      dashboard.section.footer,
    }

    alpha.setup(dashboard.opts)

    -- Hide the buffer bar on the dashboard and restore it when leaving.
    local tabline
    vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "BufLeave" }, {
      group = vim.api.nvim_create_augroup("ghost_alpha_tabline", { clear = true }),
      callback = function(event)
        if vim.bo[event.buf].filetype ~= "alpha" then
          return
        end
        if event.event == "BufLeave" then
          if tabline ~= nil then
            vim.o.showtabline = tabline
            tabline = nil
          end
        else
          tabline = tabline or vim.o.showtabline
          vim.o.showtabline = 0
        end
      end,
    })
  end,
}
