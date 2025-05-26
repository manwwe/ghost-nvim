-- Configures yamlls (YAML Language Server) for YAML LSP features.

local lspconfig = require('lspconfig')

lspconfig.yamlls.setup {
  settings = {
    yaml = { -- Settings for yamlls.
      validate = true, -- Enable validation against schemas/syntax.
      hover = true,    -- Enable hover information.
      completion = true, -- Enable completion suggestions.

      -- Map JSON Schema URIs to YAML file glob patterns for validation.
      schemas = {
        ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
        ['https://json.schemastore.org/kustomization.json'] = 'kustomization.yaml',
        ['https://json.schemastore.org/kubernetes.json'] = '/*.k8s.yaml',
        ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = 'docker-compose*.yaml',
      },

      format = {
        enable = true, -- Enable yamlls's built-in formatter.
                       -- Disable if using Prettier via none-ls for YAML.
      },
      -- customTags = { "!Ref", "!GetAtt" }, -- Example for custom YAML tags.
    },
  },
  -- on_attach and capabilities are inherited from global LSP setup.
}
