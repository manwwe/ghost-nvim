-- Shared defaults applied to individual LSP server configs.

local M = {}

-- Keep a single place for commonly reused flags.
M.flags = { debounce_text_changes = 150 }

-- Merge provided opts with defaults (opts take precedence).
function M.with_defaults(opts)
  return vim.tbl_deep_extend("force", { flags = M.flags }, opts or {})
end

return M
