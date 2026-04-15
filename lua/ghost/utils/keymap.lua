-- Shared helpers for defining consistent Neovim keymaps.

local M = {}

function M.opts(desc, extra)
  return vim.tbl_extend("force", {
    noremap = true,
    silent = true,
    desc = desc,
  }, extra or {})
end

function M.map(mode, lhs, rhs, desc, extra)
  vim.keymap.set(mode, lhs, rhs, M.opts(desc, extra))
end

function M.buf_map(bufnr, mode, lhs, rhs, desc, extra)
  M.map(mode, lhs, rhs, desc, vim.tbl_extend("force", {
    buffer = bufnr,
  }, extra or {}))
end

return M
