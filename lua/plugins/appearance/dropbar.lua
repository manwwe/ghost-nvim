return {
  'Bekaboo/dropbar.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'nvim-telescope/telescope-fzf-native.nvim',
  },
  opts = {
    bar = {
      enable = function(buf, win, _)
        local buf_ft = vim.bo[buf].filetype
        local winbar = vim.wo[win].winbar
        local win_type = vim.fn.win_gettype(win)
        local is_valid_buf = vim.api.nvim_buf_is_valid(buf)
        local is_valid_win = vim.api.nvim_win_is_valid(win)
        local is_help = vim.bo[buf].ft == 'help'

        if buf_ft == 'copilot-chat' then
          return false
        end
        if not is_valid_buf or not is_valid_win or win_type ~= '' or winbar ~= '' or is_help then
          return false
        end

        local buf_name = vim.api.nvim_buf_get_name(buf)
        local stat = vim.uv.fs_stat(buf_name)
        if stat and stat.size > 1024 * 1024 then
          return false
        end

        local is_markdown = vim.bo[buf].ft == 'markdown'
        local has_treesitter = pcall(vim.treesitter.get_parser, buf)
        local has_lsp = not vim.tbl_isempty(vim.lsp.get_clients {
          bufnr = buf,
          method = 'textDocument/documentSymbol',
        })

        return is_markdown or has_treesitter or has_lsp
      end,
    },
    icons = {
      kinds = {
        symbols = {
          Folder = '',
        },
      },
    },
    sources = {
      lsp = {
        max_depth = 3,
        -- valid_symbols = { 'Class', 'Function', 'Method' },
      },
      treesitter = {
        max_depth = 3,
        -- valid_types = { 'class', 'function', 'method' },
      },
    },
  },
}
