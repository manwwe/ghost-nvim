-- autocmds.lua
-- Automatic behaviors triggered by Neovim events.
-- Requires Neovim >= 0.11

local autocmd = vim.api.nvim_create_autocmd

-- Highlight yanked text briefly after copying
autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

-- Restore cursor position when reopening a file
autocmd("BufReadPost", {
  desc = "Restore cursor position on file open",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  desc = "Remove trailing whitespace on save",
  pattern = "*",
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[%s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, pos)
  end,
})

-- Close special buffers with q
autocmd("FileType", {
  desc = "Close special buffers with q",
  pattern = { "help", "qf", "notify", "lspinfo", "man" },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = true, silent = true })
  end,
})

-- Auto resize splits when Neovim window is resized
autocmd("VimResized", {
  desc = "Auto resize splits on window resize",
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})
