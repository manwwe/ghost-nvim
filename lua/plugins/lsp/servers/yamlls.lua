-- Configures yamlls (YAML Language Server) for YAML LSP features.
local lspconfig = require("lspconfig")

lspconfig.yamlls.setup({
  settings = {
    yaml = {
      validate = true,
      hover = true,
      completion = true,
      format = {
        enable = true,
        singleQuote = true,
        printWidth = 120,
      },
      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json", -- Updated schema store URL
      },
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        ["https://json.schemastore.org/github-action.json"] = "/.github/actions/*/action.{yml,yaml}",
        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] =
        "{docker-,}compose*.{yml,yaml}",
        ["https://json.schemastore.org/chart.json"] = "Chart.{yml,yaml}",
        ["https://json.schemastore.org/helmfile.json"] = "helmfile*.{yml,yaml}",
        -- Kubernetes schemas
        kubernetes = "*.{yml,yaml}",
      },
      customTags = {
        "!Ref",
        "!GetAtt",
        "!Sub",
        "!If",
        "!Not",
        "!Equals",
        "!Join",
        "!Select",
        "!Base64",
        "!Cidr",
        "!FindInMap",
        "!GetAZs",
        "!ImportValue",
        "!Split",
      },
      maxItemsComputed = 5000, -- Increase performance for large files
      suggest = {
        parentSkeletonSelectedFirst = true,
      },
    },
  },
})
