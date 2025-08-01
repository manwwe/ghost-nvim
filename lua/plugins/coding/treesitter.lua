return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate", -- Updates all installed parsers.
  event = { "BufReadPost", "BufNewFile" }, -- Load on buffer events for better performance
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects", -- Adds text object support.
  },
  opts = {
    ensure_installed = { -- List of parsers to install.
      -- Core languages
      "lua",
      "vim",
      "vimdoc",
      "query", -- For treesitter query files

      -- Web development
      "html",
      "css",
      "javascript",
      "typescript",
      "tsx",
      "json",
      "graphql",

      -- System/Config
      "bash",
      "dockerfile",
      "yaml",
      "toml",
      "gitignore",
      "make",
      "cmake",

      -- Programming languages
      "python",
      "go",
      "java",
      "groovy",

      -- Infrastructure
      "terraform",
      "hcl", -- Eliminé duplicado de 'terraform'
      "sql",

      -- Documentation
      "markdown",
      "markdown_inline",

      -- Patterns
      "regex",
      -- Git
      "diff",
    },
    auto_install = true, -- Automatically install missing parsers.

    highlight = {
      enable = true, -- Enables Tree-sitter based syntax highlighting.
      additional_vim_regex_highlighting = false, -- Disable for better performance (cambio)
      -- additional_vim_regex_highlighting = { 'ruby' }, -- Solo si realmente necesitas ruby
    },

    indent = {
      enable = true, -- Enables Tree-sitter based indentation.
      disable = {
        -- 'ruby', -- Solo si tienes problemas específicos
        "python", -- Python indentation puede ser problemática
      },
    },

    -- Incremental selection
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = "<C-s>",
        node_decremental = "<C-backspace>",
      },
    },

    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Improves text object selection accuracy.
        keymaps = {
          -- Functions
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",

          -- Classes
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",

          -- Parameters/Arguments
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",

          -- Blocks
          ["ab"] = "@block.outer",
          ["ib"] = "@block.inner",

          -- Conditionals
          ["ai"] = "@conditional.outer",
          ["ii"] = "@conditional.inner",

          -- Loops
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",

          -- Comments
          ["aC"] = "@comment.outer",
          ["iC"] = "@comment.inner",
        },
      },

      move = {
        enable = true,
        set_jumps = true, -- Adds movements to the jump list.
        goto_next_start = {
          ["]f"] = "@function.outer",
          ["]c"] = "@class.outer",
          ["]a"] = "@parameter.outer",
          ["]b"] = "@block.outer",
          ["]i"] = "@conditional.outer",
          ["]l"] = "@loop.outer",
        },
        goto_next_end = {
          ["]F"] = "@function.outer",
          ["]C"] = "@class.outer",
          ["]A"] = "@parameter.outer",
          ["]B"] = "@block.outer",
        },
        goto_previous_start = {
          ["[f"] = "@function.outer",
          ["[c"] = "@class.outer",
          ["[a"] = "@parameter.outer",
          ["[b"] = "@block.outer",
          ["[i"] = "@conditional.outer",
          ["[l"] = "@loop.outer",
        },
        goto_previous_end = {
          ["[F"] = "@function.outer",
          ["[C"] = "@class.outer",
          ["[A"] = "@parameter.outer",
          ["[B"] = "@block.outer",
        },
      },

      swap = {
        enable = true,
        swap_next = {
          ["<leader>sa"] = "@parameter.inner", -- swap argument
          ["<leader>sf"] = "@function.outer", -- swap function
        },
        swap_previous = {
          ["<leader>sA"] = "@parameter.inner",
          ["<leader>sF"] = "@function.outer",
        },
      },

      lsp_interop = {
        enable = true,
        border = "rounded", -- Border style for floating windows
        floating_preview_opts = {}, -- Options for floating preview
        peek_definition_code = {
          ["<leader>pf"] = "@function.outer", -- peek function (cambié de sf)
          ["<leader>pc"] = "@class.outer", -- peek class (cambié de sc)
        },
      },
    },
  },

  config = function(_, opts)
    -- Configurar treesitter
    require("nvim-treesitter.configs").setup(opts)

    -- Configurar movimientos repetibles
    local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

    -- Hacer que ; y , repitan el último movimiento
    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next, { desc = "Repeat last move next" })
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous, { desc = "Repeat last move previous" })

    -- Hacer que f, F, t, T también sean repetibles
    vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

    -- Comando de debug útil
    vim.api.nvim_create_user_command("TSDebug", function()
      vim.cmd("TSBufToggle highlight")
    end, { desc = "Toggle treesitter highlighting for debugging" })

    -- Comando para ver textobjects disponibles
    vim.api.nvim_create_user_command("TSTextobjects", function()
      local captures = vim.treesitter.get_captures_at_cursor()
      if #captures == 0 then
        print("No treesitter captures at cursor")
      else
        print("Available captures:")
        for _, capture in ipairs(captures) do
          print("  " .. capture)
        end
      end
    end, { desc = "Show available textobjects at cursor" })
  end,
}
