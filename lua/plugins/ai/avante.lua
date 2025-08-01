return {
  "yetone/avante.nvim",
  -- build step (only if you want to compile from source; otherwise Lazy will fetch the binary)
  build = vim.fn.has("win32") and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" or "make",
  event = "VeryLazy",

  opts = {
    -- main AI provider
    provider = "copilot",
    -- also use Copilot for auto-suggestions
    auto_suggestions_provider = "copilot",

    providers = {
      -- Copilot provider (delegates to your existing copilot.lua setup)
      copilot = {},

      -- fallback Anthropics Claude provider
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-sonnet-4-20250514",
        timeout = 30000,
        extra_request_body = {
          temperature = 0.75,
          max_tokens = 20480,
        },
      },
    },

    -- sidebar & input window UI settings
    windows = {
      position = "right", -- "right" | "left" | "top" | "bottom"
      width = 30, -- panel width in columns
      wrap = true, -- enable line wrapping
      sidebar_header = { enabled = true },
      edit = { border = "solid" },
      input = {
        position = "bottom", -- "bottom" | "top"
        height = 15, -- input area height in lines
      },
    },

    -- file selector configuration (Telescope)
    file_selector = {
      provider = "telescope",
      provider_opts = {}, -- customize your Telescope picker here
    },

    -- filetypes where Avante should not open
    exclude_filetypes = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
  },

  dependencies = {
    -- core dependencies
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim",
  },
}
