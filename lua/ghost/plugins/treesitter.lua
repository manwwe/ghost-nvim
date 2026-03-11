-- treesitter.lua
-- Syntax highlighting, indentation, and code navigation via Treesitter.
-- Requires Neovim >= 0.11

return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    local ts = require("nvim-treesitter")
    local textobjects = require("nvim-treesitter-textobjects")

    local parsers = {
      "lua",
      "python",
      "typescript",
      "javascript",
      "tsx",
      "rust",
      "json",
      "yaml",
      "toml",
      "markdown",
      "markdown_inline",
      "bash",
      "html",
      "css",
      "gitignore",
      "vim",
      "vimdoc",
    }

    ts.setup({})

    local installed = {}
    for _, lang in ipairs(ts.get_installed()) do
      installed[lang] = true
    end

    local missing = {}
    for _, lang in ipairs(parsers) do
      if not installed[lang] then
        table.insert(missing, lang)
      end
    end
    if #missing > 0 then
      ts.install(missing, { summary = false })
    end

    textobjects.setup({
      select = {
        lookahead = true,
      },
      move = {
        set_jumps = true,
      },
    })

    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.opt.foldenable = false
    vim.opt.foldlevel = 99

    local group = vim.api.nvim_create_augroup("ghost_treesitter", { clear = true })

    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = "*",
      callback = function(args)
        local bufnr = args.buf

        local ft = vim.bo[bufnr].filetype
        if ft == "" then
          return
        end

        local lang = vim.treesitter.language.get_lang(ft) or ft
        if pcall(vim.treesitter.start, bufnr, lang) then
          vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })

    local map = vim.keymap.set
    local select = require("nvim-treesitter-textobjects.select")
    local move = require("nvim-treesitter-textobjects.move")

    local select_maps = {
      { "af", "@function.outer", "around function" },
      { "if", "@function.inner", "inside function" },
      { "ac", "@class.outer", "around class" },
      { "ic", "@class.inner", "inside class" },
      { "aa", "@parameter.outer", "around parameter" },
      { "ia", "@parameter.inner", "inside parameter" },
    }

    for _, m in ipairs(select_maps) do
      map({ "x", "o" }, m[1], function()
        select.select_textobject(m[2], "textobjects")
      end, { desc = "Treesitter: " .. m[3] })
    end

    local move_maps = {
      { "]f", move.goto_next_start, "@function.outer", "next function" },
      { "[f", move.goto_previous_start, "@function.outer", "previous function" },
      { "]c", move.goto_next_start, "@class.outer", "next class" },
      { "[c", move.goto_previous_start, "@class.outer", "previous class" },
    }

    for _, m in ipairs(move_maps) do
      map({ "n", "x", "o" }, m[1], function()
        m[2](m[3], "textobjects")
      end, { desc = "Treesitter: " .. m[4] })
    end
  end,
}
