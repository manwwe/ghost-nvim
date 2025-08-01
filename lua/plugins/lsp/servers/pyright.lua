-- Configures Pyright (Python static type checker and language server).

local lspconfig = require("lspconfig")

lspconfig.pyright.setup({
  settings = {
    python = { -- Settings for Pyright.
      analysis = {
        typeCheckingMode = "off", -- "basic", "strict", or "off".
        diagnosticSeverityOverrides = {
          reportUnusedVariable = "warning",
          reportMissingImports = false,
          -- Add more overrides as needed
        },
        autoSearchPaths = true, -- Auto-discover import paths.
        diagnosticMode = "workspace", -- Analyze open files only.
        useLibraryCodeForTypes = true, -- Infer types from library code.
        flags = {
          allowUnusedVariables = true, -- Allow unused variables without warnings.
          reportMissingImports = true, -- Report missing imports.
          reportUnusedImport = true, -- Report unused imports.
          reportUnusedVariable = true, -- Report unused variables.
          reportGeneralTypeIssues = true, -- Report general type issues.
        },
        memory = true, -- Enable memory caching for faster analysis.
        logLevel = "Information", -- Logging level ("Information", "Warning", "Error").

        autoImportCompletions = true, -- Provide auto-import completions.

        exclude = { -- Directories/patterns to exclude from analysis.
          "**/node_modules/**",
          "**/__pycache__/**",
          "**/.venv/**",
          "**/venv/**",
          "**/env/**",
          "**/.mypy_cache/**",
          "**/build/**",
          "**/dist/**",
          "**/.git/**",
          "**/.pytest_cache/**",
          "**/.coverage/**",
          "**/htmlcov/**",
        },
      },
    },
  },
  -- on_attach and capabilities are inherited from global LSP setup.
})
