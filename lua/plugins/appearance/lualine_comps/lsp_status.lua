-- Lualine component for LSP client status in the current buffer.

local M = {}

-- Returns status of active LSP clients for current buffer.
function M.status()
  local buf_ft = vim.bo.filetype -- Current buffer filetype.
  local clients = vim.lsp.get_clients() -- All active LSP clients.
  local names = {} -- Stores names of relevant clients.

  for _, client in ipairs(clients) do
    if client.config.filetypes and vim.tbl_contains(client.config.filetypes, buf_ft) then
      if client.name ~= 'null-ls' then -- Exclude 'null-ls'.
        table.insert(names, client.name)
      end
    end
  end

  if next(names) then
    return '󰌌 ' .. table.concat(names, ', ') -- "Connected" icon (Nerd Font) and client names.
  else
    return '󰌐 ' -- "Disconnected" icon (Nerd Font).
  end
end

return M -- Lualine calls M.status.
