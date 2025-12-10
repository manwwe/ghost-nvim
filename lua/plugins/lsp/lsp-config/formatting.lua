-- LSP formatting configuration
-- Centralizes auto-format on save functionality

local M = {}

local FORMAT_METHOD = "textDocument/formatting"

local function has_formatting_client(bufnr)
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    if client.supports_method(FORMAT_METHOD) then
      return true
    end
  end
  return false
end

local function has_null_ls(bufnr)
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    if client.name == "null-ls" and client.supports_method(FORMAT_METHOD) then
      return true
    end
  end
  return false
end

local function format_buffer(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if not has_formatting_client(bufnr) then
    return
  end

  local prefer_null_ls = has_null_ls(bufnr)
  vim.lsp.buf.format({
    bufnr = bufnr,
    timeout_ms = 5000,
    filter = function(client)
      if prefer_null_ls then
        return client.name == "null-ls"
      end
      return client.supports_method(FORMAT_METHOD)
    end,
  })
end

-- Auto-format on save using LSP/none-ls
function M.setup_lsp_formatting()
  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    pattern = "*",
    callback = function(args)
      format_buffer(args.buf)
    end,
  })
end

-- Setup formatting (currently only LSP, none-ls handles its own)
function M.setup()
  M.setup_lsp_formatting()
end

return M
