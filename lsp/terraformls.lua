-- terraformls.lua
-- Terraform language server — completion, navigation, and diagnostics.

return {
  cmd = { "terraform-ls", "serve" },
  filetypes = { "terraform", "terraform-vars" },
  root_markers = { ".terraform", ".git" },
}
