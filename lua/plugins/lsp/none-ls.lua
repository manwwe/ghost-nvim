-- Configures nvimtools/none-ls.nvim for integrating formatters and linters into Neovim's LSP client.

return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim', -- Extra built-in sources for none-ls.
    { 'williamboman/mason.nvim', version = '1.11.0' }, -- Tool manager.
    'jay-babu/mason-null-ls.nvim', -- Integrates Mason with none-ls.
    'gbprod/none-ls-shellcheck.nvim', -- Shellcheck integration.
  },
  config = function()
    -- Setup Mason.
    require('mason').setup()

    -- Setup mason-null-ls to manage tools.
    require('mason-null-ls').setup {
      ensure_installed = {
        'stylua',
        'isort',
        'sqruff',
        'sqlfluff',
        'prettier',
        'yamllint',
        'shfmt',
        'shellcheck',
      },
      automatic_installation = true,
    }

    -- Load none-ls.
    local null_ls = require 'null-ls'
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    -- Path to custom sqlfluff config.
    local sqlfluff_config_path = vim.fn.expand '~/.sqlfluff'

    -- Define sources for none-ls.
    local sources = {
      formatting.stylua,
      formatting.isort,
      diagnostics.sqruff.with { extra_args = { '--config', sqlfluff_config_path } },
      formatting.sqruff.with { extra_args = { '--config', sqlfluff_config_path } },
      formatting.prettier.with {
        filetypes = { 'json', 'yaml', 'yml', 'markdown', 'html', 'javascript', 'typescript', 'dockerfile' },
      },
      diagnostics.yamllint,
      formatting.shfmt,
      require 'none-ls-shellcheck.diagnostics',
    }

    -- Autocommand group for auto-formatting.
    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

    -- Setup none-ls with sources and on_attach function.
    null_ls.setup {
      sources = sources,
      on_attach = function(client, bufnr)
        if client.supports_method 'textDocument/formatting' then
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format { async = false }
            end,
          })
        end
      end,
    }
  end,
}
