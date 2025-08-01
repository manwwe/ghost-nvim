-- Lualine component to show active LSP server(s) for current buffer.
local M = {}

-- Gets active LSP clients for the current buffer (excluding linters/formatters).
local function get_active_lsp_servers()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })

  if #clients == 0 then
    return nil
  end

  -- List of servers that are primarily linters/formatters, not true LSP servers
  local excluded_servers = {
    "null-ls",
    "none-ls",
    "ruff", -- Python linter/formatter
    "eslint", -- JavaScript/TypeScript linter
    "prettier", -- Formatter
    "stylua", -- Lua formatter
    "black", -- Python formatter
    "isort", -- Python import sorter
    "flake8", -- Python linter
    "mypy", -- Python type checker (more of a linter)
    "copilot",
  }

  local server_names = {}
  for _, client in pairs(clients) do
    -- Only include if not in excluded list
    local is_excluded = false
    for _, excluded in ipairs(excluded_servers) do
      if client.name == excluded then
        is_excluded = true
        break
      end
    end

    if not is_excluded then
      table.insert(server_names, client.name)
    end
  end

  -- Return nil if no real LSP servers (only linters/formatters were active)
  if #server_names == 0 then
    return nil
  end

  return server_names
end

-- Returns formatted LSP server names with icon and padding.
function M.component()
  local servers = get_active_lsp_servers()

  if not servers or #servers == 0 then
    return " 󰌘 No LSP " -- Icon for no LSP server
  end

  local server_text = table.concat(servers, ", ")
  return " 󰒋 " .. server_text -- LSP icon with server names
end

-- Dynamically sets color based on LSP status.
function M.color()
  local servers = get_active_lsp_servers()

  if servers and #servers > 0 then
    return { fg = "#abb2bf" } -- Green if LSP is active
  else
    return { fg = "#E06C75" } -- Red if no LSP
  end
end

-- Alternative version with server count
function M.component_with_count()
  local servers = get_active_lsp_servers()

  if not servers or #servers == 0 then
    return " 󰌘 No LSP "
  end

  if #servers == 1 then
    return " 󰒋 " .. servers[1] .. " "
  else
    return " 󰒋 " .. servers[1] .. " (+" .. (#servers - 1) .. ") "
  end
end

-- Version that shows only the icon with server count
function M.component_minimal()
  local servers = get_active_lsp_servers()

  if not servers or #servers == 0 then
    return " 󰌘 "
  end

  return " 󰒋 " .. #servers .. " "
end

-- Main component export (you can change this to use different variants)
return {
  M.component, -- Shows all server names
  -- M.component_with_count, -- Shows first server + count if multiple
  -- M.component_minimal, -- Shows only icon + count
  color = M.color,
}
