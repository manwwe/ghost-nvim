return {
  "antosha417/nvim-lsp-file-operations",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- "nvim-tree/nvim-tree.lua",   -- Uncomment if you use nvim-tree
    "nvim-neo-tree/neo-tree.nvim", -- Uncomment if you use neo-tree
    -- "simonmclean/triptych.nvim", -- Uncomment if you use triptych
  },
  config = function()
    require("lsp-file-operations").setup({
      debug = false,
      operations = {
        willRenameFiles = true,
        didRenameFiles = true,
        willCreateFiles = true,
        didCreateFiles = true,
        willDeleteFiles = true,
        didDeleteFiles = true,
      },
      timeout_ms = 10000,
    })

    -- Extend capabilities globally for all LSPs (using lspconfig)
    local lspconfig = require("lspconfig")
    lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
      capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), require("lsp-file-operations").default_capabilities()),
    })
  end,
}
