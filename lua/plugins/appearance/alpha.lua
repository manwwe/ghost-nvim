-- This file configures the alpha-nvim plugin, which provides a customizable start screen (dashboard) for Neovim.

return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- Adds icons to the dashboard.
  },

  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Set the header with ASCII art.
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

    -- Define custom buttons.
    dashboard.section.buttons.val = {
      dashboard.button("f", "󰈞  Find file", ":Telescope find_files<CR>"),
      dashboard.button("g", " Find text", ":Telescope live_grep<CR>"),
      dashboard.button("r", "󱋡 find used files", ":Telescope oldfiles<CR>"),
      dashboard.button("t", "  Find tags", ":Telescope help_tags<CR>"),
      dashboard.button("c", "  Find git commits", ":Telescope git_commits<CR>"),
      dashboard.button("b", " Find git branches", ":Telescope git_branches<CR>"),
      dashboard.button("s", "  Settings", ":e $MYVIMRC<CR>"),
      dashboard.button("q", "󰩈  Quit Neovim", ":qa<CR>"),
    }

    -- Footer with welcome message and date.
    local function get_current_date()
      return os.date(" Today is %A, %B %d, %Y")
    end

    local function welcome_user()
      local username = os.getenv("USER") or os.getenv("USERNAME")
      return string.format("󱠢 Welcome back, %s!", username)
    end

    dashboard.section.footer.val = {
      welcome_user(),
      get_current_date(),
    }

    -- Configure layout.
    dashboard.opts.layout = {
      { type = "padding", val = 1 },
      dashboard.section.header,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      dashboard.section.footer,
    }

    -- Initialize alpha-nvim.
    alpha.setup(dashboard.opts)
  end,
}
