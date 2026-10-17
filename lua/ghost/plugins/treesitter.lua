return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    commit = vim.fn.has("nvim-0.12") == 0 and "7caec274fd19c12b55902a5b795100d21531391f" or nil,
    version = false, -- Follow the branch instead of tagged releases
    lazy = false,
    build = ":TSUpdate",
    -- `parsers` is our shared list, consumed by install() below.
    opts_extend = { "parsers" },
    opts = { parsers = { "diff", "html", "json", "markdown", "markdown_inline", "query", "regex", "toml", "vim", "vimdoc", "xml", "yaml" } },
    config = function(_, opts)
      require("nvim-treesitter").install(opts.parsers)

      -- Enable highlighting and folding where a parser is available.
      vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter" }, {
        group = vim.api.nvim_create_augroup("ghost_treesitter", { clear = true }),
        callback = function(event)
          if vim.bo[event.buf].buftype ~= "" or vim.bo[event.buf].filetype == "" then
            return
          end
          if not pcall(vim.treesitter.start, event.buf) then
            return
          end
          vim.wo.foldmethod = "expr"
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo.foldlevel = 99 -- Keep folds open initially
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
    keys = {
      {
        "af",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
        end,
        mode = { "x", "o" },
        desc = "Around function",
      },
      {
        "if",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
        end,
        mode = { "x", "o" },
        desc = "Inside function",
      },
      {
        "]m",
        function()
          require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
        end,
        mode = { "n", "x", "o" },
        desc = "Next function",
      },
      {
        "[m",
        function()
          require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
        end,
        mode = { "n", "x", "o" },
        desc = "Previous function",
      },
    },
  },
}
