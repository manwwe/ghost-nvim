-- Configures dyng/ctrlsf.vim: search & replace in multiple files (uses ripgrep).

return {
  'dyng/ctrlsf.vim',
  opts = {}, -- Configured via global Vim variables below.
  config = function()
    -- CtrlSF global settings.
    vim.g.ctrlsf_ackprg = 'rg --vimgrep --hidden' -- Search program: ripgrep, vimgrep format, search hidden.
    vim.g.ctrlsf_default_root = 'project' -- Search root: project root (e.g., Git repo).
    vim.g.ctrlsf_case_sensitive = 'smart' -- Case sensitivity: smart.
    vim.g.ctrlsf_auto_close = 1 -- Auto-close window after action.
    vim.g.ctrlsf_position = 'left' -- Results window position.
    vim.g.ctrlsf_winsize = '35%' -- Results window size.
    vim.g.ctrlsf_context = '-C 3' -- Lines of context around matches.
    vim.g.ctrlsf_ignore_dir = { -- Directories to ignore.
      'node_modules', '.git', 'dist', '__pycache__',
      '.mypy_cache', '.pytest_cache', '.venv', 'env', 'venv',
    }

    -- Keymaps for CtrlSF.
    local keymap = vim.keymap.set
    keymap({ 'n', 'i' }, '<C-f>f', ':CtrlSF ', { noremap = true, silent = true, desc = 'CtrlSF Search' }) -- <C-f>f: Start search.
    keymap('n', '<C-f>c', ':CtrlSFClose<CR>', { noremap = true, silent = true, desc = 'CtrlSF Close' }) -- <C-f>c: Close window.
  end,
}
