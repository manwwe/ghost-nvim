-- Configures lua-language-server (lua_ls) for Lua LSP features.

local lspconfig = require('lspconfig')

lspconfig.lua_ls.setup {
  settings = {
    Lua = { -- Settings for lua_ls.
      diagnostics = {
        globals = { 'vim' }, -- Define 'vim' as a global for Neovim Lua config.
      },
      workspace = {
        checkThirdParty = false, -- Disable checking third-party libraries (performance).
      },
      format = {
        enable = false, -- Disable lua_ls formatter (use stylua via none-ls instead).
      },
    },
  },
  -- on_attach and capabilities are inherited from global LSP setup.
}
