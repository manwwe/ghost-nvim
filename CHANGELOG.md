# Changelog

All notable changes to `ghost-nvim` will be documented in this file.

## [v0.0.1] - 2026-04-15

This release promotes the previous `v0.0.1-alpha` work into the first non-alpha `v0.0.1` release and consolidates the `refactor/v0.1` branch.

### ✨ Added

- Added persistent colorscheme management with a built-in theme picker.
- Added Rust development support with `rust_analyzer`, `rustfmt`, and Treesitter Rust parser coverage.
- Added a dedicated `KEYMAPS.md` reference with the full shortcut layout.
- Added a cleaner feature-based internal structure under `lua/ghost` and `lsp/`.

### 🔧 Changed

- Reworked the Neovim configuration into smaller, focused modules for core config, plugins, UI helpers, and language tooling.
- Simplified plugin loading and shared setup around `lazy.nvim`, Mason-managed tooling, and the newer Neovim LSP configuration flow.
- Reorganized default keymaps and completion behavior for a more consistent editing workflow.
- Refreshed the main `README.md` to match the current architecture, setup flow, and documentation layout.
- Updated Neo-tree to a floating explorer workflow and refined the overall UI stack.

### 🤖 AI

- Simplified the AI surface to focus on `CopilotChat.nvim`.
- Removed older or experimental AI integrations that were no longer part of the maintained workflow.

### 🐛 Fixed

- Updated repository and image links in the documentation.
- Cleaned up stray files and documentation artifacts that should not ship in the repository.

### 📝 Notes

- `v0.0.1-alpha` remains as the historical prerelease tag.
- `v0.0.1` is the recommended tag for the current stable state of the refactor branch before merging into `main`.
