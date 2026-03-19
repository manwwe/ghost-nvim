-- Configures Treesitter parsers and syntax features.

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local parser_root = vim.fn.stdpath "data" .. "/site"
    local ok, configs = pcall(require, "nvim-treesitter.configs")

    if not ok then
      vim.schedule(function()
        vim.notify(
          "nvim-treesitter incompatible branch detected. Neovim 0.11.6 needs nvim-treesitter/master. Run :Lazy sync and :TSUpdate.",
          vim.log.levels.ERROR
        )
      end)
      return
    end

    vim.fn.mkdir(parser_root .. "/parser", "p")
    vim.opt.runtimepath:prepend(parser_root)

    configs.setup {
      parser_install_dir = parser_root,
      ensure_installed = {
        "bash",
        "css",
        "html",
        "javascript",
        "json",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "rust",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = "<C-s>",
          node_decremental = "<M-space>",
        },
      },
    }
  end,
}
