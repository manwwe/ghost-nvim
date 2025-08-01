-- Lualine component for LSP client status in the current buffer.
local M = {}

function M.status()
  local buf_ft = vim.bo.filetype
  local clients = vim.lsp.get_clients()
  local names = {}
  local excluded_servers = { "null-ls", "pyright", "lua_ls" }

  for _, client in ipairs(clients) do
    if client.config.filetypes and vim.tbl_contains(client.config.filetypes, buf_ft) then
      if not vim.tbl_contains(excluded_servers, client.name) then
        table.insert(names, client.name)
      end
    end
  end

  if next(names) then
    return "󰌌 " .. table.concat(names, ", ")
  else
    return "󰌐 "
  end
end

return M
