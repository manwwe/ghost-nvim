-- Central registry for server-specific option tables.

local server_modules = {
  lua_ls = "plugins.lsp.servers.lua",
  pyright = "plugins.lsp.servers.pyright",
  ruff = "plugins.lsp.servers.ruff",
  yamlls = "plugins.lsp.servers.yamlls",
  helm_ls = "plugins.lsp.servers.helm_ls",
  bashls = "plugins.lsp.servers.bash",
  gopls = "plugins.lsp.servers.gopls",
  rust_analyzer = "plugins.lsp.servers.rust",
}

local M = {}

function M.names()
  return vim.tbl_keys(server_modules)
end

function M.get(server_name)
  local module = server_modules[server_name]
  if not module then
    return nil
  end

  local ok, opts = pcall(require, module)
  if not ok then
    vim.notify(string.format("[lsp] Failed to load %s: %s", module, opts), vim.log.levels.WARN)
    return nil
  end

  return opts or {}
end

return M
