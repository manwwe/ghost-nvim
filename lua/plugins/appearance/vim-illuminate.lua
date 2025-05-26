-- Configures RRethy/vim-illuminate: highlights other instances of word under cursor.

return {
  'RRethy/vim-illuminate',
  event = 'BufReadPost', -- Load after buffer read (for Treesitter readiness).
  config = function()
    -- Global plugin variables.
    vim.g.Illuminate_delay = 100 -- Delay (ms) before highlighting.
    vim.g.Illuminate_highlightUnderCursor = 0 -- 0: Don't highlight word under cursor, only others.
    vim.g.Illuminate_ftblacklist = {} -- Filetypes to disable for, e.g., { 'help' }.

    -- Integrate with LSP for context-aware highlighting.
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local bufnr = args.buf
        require('illuminate').on_attach(client, bufnr) -- Enable LSP-driven highlighting.
      end,
    })

    -- Optional: Custom highlights for illuminated words (dark grey example).
    -- Adjust to match your colorscheme.
    vim.api.nvim_set_hl(0, 'IlluminatedWordText', { bg = '#3b4252' })
    vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { bg = '#3b4252' })
    vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { bg = '#3b4252' })
  end,
}
