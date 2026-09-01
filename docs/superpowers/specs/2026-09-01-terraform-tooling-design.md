# Terraform Tooling Design

## Goal

Add Terraform completion, navigation, diagnostics, and format-on-save while following the repository's existing language-tooling conventions.

## Design

- Add `terraformls` to the Mason-managed LSP server list.
- Add an `lsp/terraformls.lua` configuration for `terraform` and `terraform-vars` buffers, using standard Terraform project root markers.
- Configure Conform's `terraform_fmt` formatter for both Terraform filetypes.
- Document Terraform support alongside the other supported language tools.

`terraform-ls` is installed automatically through Mason. Formatting invokes `terraform fmt`, so the Terraform CLI remains a system prerequisite.

## Error Handling

Neovim and Mason retain their existing behavior when `terraform-ls` cannot be installed. If the Terraform CLI is unavailable, Conform reports that the formatter executable is missing without affecting other language tooling.

## Verification

- Run the repository's existing automated checks.
- Confirm the Lua configuration loads successfully.
- Verify the configured server and formatter names match their Neovim plugin integrations.
