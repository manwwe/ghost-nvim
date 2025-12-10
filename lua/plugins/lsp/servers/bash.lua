-- Configures bash-language-server (bashls) for shell scripting support.
local util = require("lspconfig.util")

local function root_dir(fname)
  if fname:match("%.env$") then
    return nil
  end
  return util.find_git_ancestor(fname) or util.path.dirname(fname)
end

return {
  cmd = { "bash-language-server", "start" },
  filetypes = { "sh", "bash" }, -- exclude .env here
  root_dir = root_dir,
  settings = {
    bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command)",
    },
  },
  flags = {
    debounce_text_changes = 150,
  },
}
