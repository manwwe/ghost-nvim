-- Install plugin sources for CI without starting the personal configuration.
local root = vim.fn.getcwd()
vim.opt.rtp:prepend(root)
local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazy_path) then
  local output = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazy_path })
  assert(vim.v.shell_error == 0, output)
end
vim.opt.rtp:prepend(lazy_path)
vim.go.loadplugins = true -- -l disables plugin loading by default.

-- Collect repository/version declarations and dependencies, leaving callbacks,
-- build hooks, parser downloads, and language servers for their own workflows.
local plugins = {}
local function collect(spec)
  if type(spec) == "string" then spec = { spec } end
  if type(spec) ~= "table" then return end
  if type(spec[1]) == "string" then
    if spec[1]:find("/", 1, true) then
      local name = spec.name or spec[1]:match("([^/]+)$")
      local plugin = plugins[name] or { spec[1], name = name, lazy = true, build = false }
      for _, key in ipairs({ "branch", "tag", "version" }) do
        if spec[key] ~= nil then plugin[key] = spec[key] end
      end
      plugins[name] = plugin
    end
    for _, dependency in ipairs(spec.dependencies or {}) do collect(dependency) end
  else
    for _, child in ipairs(spec) do collect(child) end
  end
end
for _, file in ipairs(vim.fs.find(function(name) return name:sub(-4) == ".lua" end,
  { path = root .. "/lua/ghost/plugins", type = "file", limit = math.huge })) do
  collect(dofile(file))
end

require("lazy").setup({
  spec = vim.tbl_values(plugins),
  lockfile = vim.fn.stdpath("state") .. "/ghost-ci-lock.json",
  install = { missing = false },
  checker = { enabled = false },
  change_detection = { enabled = false },
})
require("lazy").install({ wait = true })
for name, plugin in pairs(require("lazy.core.config").plugins) do
  assert(vim.uv.fs_stat(plugin.dir), "Missing plugin: " .. name)
  for _, task in ipairs(plugin._.tasks or {}) do
    assert(not task:has_errors(), "Plugin installation failed: " .. name)
  end
end
io.stdout:write("Plugin sources installed for configuration tests\n")
vim.cmd("qa!")
