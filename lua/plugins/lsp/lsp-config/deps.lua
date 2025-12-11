-- Shared LSP dependency helpers (keeps Mason spec and setup in one place).

local M = {}

M.mason = { "williamboman/mason.nvim", version = "1.11.0" }

local mason_configured = false

function M.setup_mason(opts)
  if mason_configured then
    return
  end

  require("mason").setup(opts)
  mason_configured = true
end

return M
