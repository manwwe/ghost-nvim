-- Configures Pyright (Python static type checker and language server).

local lspconfig = require('lspconfig')

lspconfig.pyright.setup {
  settings = {
    python = { -- Settings for Pyright.
      analysis = {
        typeCheckingMode = 'basic', -- "basic", "strict", or "off".
        autoSearchPaths = true, -- Auto-discover import paths.
        diagnosticMode = 'openFilesOnly', -- Analyze open files only.
        useLibraryCodeForTypes = true, -- Infer types from library code.

        memory = true, -- Enable memory caching for faster analysis.
        logLevel = 'Information', -- Logging level ("Information", "Warning", "Error").

        autoImportCompletions = true, -- Provide auto-import completions.

        exclude = { -- Directories/patterns to exclude from analysis.
          '**/node_modules/**', '**/__pycache__/**',
          '**/.venv/**', '**/venv/**',
        },
      },
    },
  },
  flags = { -- LSP client flags for this server.
    debounce_text_changes = 150, -- Delay (ms) before sending changes to server.
  },
  -- on_attach and capabilities are inherited from global LSP setup.
}
