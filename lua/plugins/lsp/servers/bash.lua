-- Configures bash-language-server (bashls) for shell scripting support.
local util = require("lspconfig.util")

vim.lsp.config("bashls", {
  cmd = { "bash-language-server", "start" },
  filetypes = { "sh", "bash" }, -- exclude .env here
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    if fname:match("%.env$") then
      return
    end
    local root = util.find_git_ancestor(fname) or util.path.dirname(fname)
    if root then
      on_dir(root)
    end
  end,
  settings = {
    bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command)",
    },
  },
  flags = {
    debounce_text_changes = 150,
  },
})
