<div align="center">
  <img src="https://manwwe.github.io/imagenes-static/img/logo_2.jpg" alt="ghost-nvim logo" width="700"/>
</div>

<div align="center">
  <a href="#-features">Features</a>
  <span> • </span>
  <a href="#-installation">Install</a>
  <span> • </span>
  <a href="#-setup">Setup</a>
  <span> • </span>
  <a href="#-usage">Usage</a>
  <span> • </span>
  <a href="#-keybindings">Keybindings</a>
  <span> • </span>
  <a href="#-contributing">Contribute</a>
  <span> • </span>
  <a href="#-project-structure">Structure</a>
  <p></p>
</div>

<hr>

**ghost-nvim** is a modular Neovim configuration for a clean editing experience, modern UI, solid LSP tooling, and practical defaults. The `refactor/v0.1` branch focuses on a cleaner architecture under `lua/ghost`, keeping the setup fast, maintainable, and ready for everyday development.

> 🧪 **Version**: `refactor/v0.1` – preview branch for the `v0.1` refactor. Layout, defaults, and documentation may still evolve.
>
> ✅ **Tested with**: Neovim `0.11.6`

---

<div align="center">
  <img src="https://manwwe.github.io/imagenes-static/img/dashboard.png" alt="ghost-nvim dashboard preview"/>
  <br><br>
  <img src="https://manwwe.github.io/imagenes-static/img/ai.png" alt="ghost-nvim AI workflow preview"/>
</div>

---

## ✨ Features

**ghost-nvim** delivers a refactored, high-signal Neovim workflow with modern tools and a cleaner internal structure.

- 🤖 **Focused AI Workflows**
  `CopilotChat.nvim` is integrated for quick buffer questions, visual explain/review/fix prompts, prompt selection, and model switching.

- ⚡ **Fast, Lazy-Loaded Setup**
  Powered by `lazy.nvim`, with on-demand loading and a modular layout built for the `v0.1` refactor.

- 🧠 **Modern LSP Tooling**
  `mason.nvim`, `nvim-lspconfig`, `conform.nvim`, and `nvim-lint` provide language servers, format-on-save, and lint feedback with minimal setup.

- 🔍 **Practical Navigation**
  `telescope.nvim` covers files, grep, buffers, diagnostics, and keymaps, while `neo-tree.nvim` provides a floating explorer for files, buffers, and Git status.

- 🎨 **Modern UI Stack**
  Includes `alpha-nvim`, `lualine.nvim`, `bufferline.nvim`, `noice.nvim`, and multiple bundled themes such as Catppuccin, Gruvbox, TokyoNight, Kanagawa, Vague, and Everforest.

- 🛠️ **Full Daily Driver Toolkit**
  Ships with terminals, Git tooling, diagnostics views, snippets, autopairs, code snapshots, and multicursor editing.

- 🧩 **Refactored by Feature**
  Core config lives in `lua/ghost/config`, plugin specs are grouped by feature, and language-specific LSP settings are isolated under `lsp/`.

---

## 🚀 Installation

Requires Neovim `0.11.6`. Plugin management is handled via `lazy.nvim`.

### 🔧 Prerequisites

Install the following dependencies:

- `git`
- `curl`
- `tar`
- a C compiler
- `ripgrep`
- `make` for `telescope-fzf-native.nvim`
- Nerd Font for icons

Optional but useful:

- `python3`, `lua`, and `bash` for the file runner in `toggleterm`
- an active GitHub Copilot subscription if you want to use `CopilotChat.nvim`

---

## ⚙️ Setup

### 📦 Step-by-Step

1. Backup your current Neovim config if needed:

   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   mv ~/.local/share/nvim ~/.local/share/nvim.bak
   ```

2. Clone the repo:

   ```bash
   git clone https://github.com/manwwe/ghost-nvim.git ~/.config/nvim
   ```

3. Start Neovim:

   ```bash
   nvim
   ```

4. Let `lazy.nvim` install the plugins.

5. Run the following once:

   ```vim
   :Lazy sync
   :TSUpdate
   :Mason
   ```

✅ You are ready to use **ghost-nvim** on the `refactor/v0.1` branch.

---

## 🧪 Usage

### 🔌 Plugin Management

- Plugins are installed automatically on first launch.
- Use `:Lazy` to inspect, sync, clean, and update plugin state.
- Use `:Mason` to manage language servers, formatters, and linters.

---

### Key Features & Plugins

#### 🤖 AI Assistance

- `CopilotChat.nvim` is available through a compact keymap set for toggling chat, selecting models and prompts, and asking questions about the current buffer.
- Visual mode shortcuts are configured for explain, review, fix, optimize, docs, and tests.
- The default model is configured as `gpt-4.1`.

#### ⚙️ Completion Engine (`nvim-cmp`)

- Unified completion sources include LSP, snippets, paths, and buffer suggestions.
- Snippet support is powered by `LuaSnip` and `friendly-snippets`.
- Completion keeps `<Tab>` and `<S-Tab>` free while using `Ctrl`-based navigation and snippet jumps.

#### 🔍 Telescope

- Fuzzy finder mapped around `<leader>f` for files, grep, diagnostics, keymaps, and recent files.
- Includes `telescope-fzf-native.nvim` when `make` is available.

#### 🧠 LSP + Code Intelligence

- LSP servers are managed through Mason and enabled with `nvim-lspconfig`.
- Formatting runs on save through `conform.nvim`, with manual formatting on `<leader>fm`.
- Linting runs on buffer enter, write, and insert leave through `nvim-lint`.
- Default language tooling includes `lua_ls`, `pyright`, `rust_analyzer`, and `ts_ls`.

#### 🌈 UI/UX

- `alpha-nvim` provides the startup dashboard.
- `neo-tree.nvim` handles files, buffers, and Git status in floating views.
- `noice.nvim` and `nvim-notify` improve command-line, message, and notification handling.
- `bufferline.nvim` and `lualine.nvim` provide buffer and statusline context.
- Theme switching is built in, with `<leader>ut` opening the theme picker.

#### 🧩 Tools

- `toggleterm.nvim` provides a main terminal, floating terminal, vertical terminal, and a current-file runner for `python`, `lua`, and `sh`.
- Git flows are covered by `gitsigns.nvim` and `lazygit.nvim`.
- `trouble.nvim`, `which-key.nvim`, `mini.surround`, `nvim-autopairs`, `codesnap.nvim`, and `multicursor.nvim` round out the daily editing workflow.

---

## 🎮 Keybindings

Detailed keybindings are documented in [KEYMAPS.md](KEYMAPS.md).

That file includes:

- recent layout changes
- general editor mappings
- Telescope, LSP, Git, Terminal, Trouble, Copilot Chat, CodeSnap, and Multicursor shortcuts

---

## 🤝 Contributing

Contributions should follow the refactored layout used by this branch and keep documentation aligned with behavior.

### 💡 What You Can Improve

- plugin behavior and editor UX
- language tooling and defaults
- UI consistency and theme integrations
- documentation, examples, and keymap coverage

### 🧪 How to Contribute

1. Fork the repo
2. Create a branch
3. Keep changes scoped and documented
4. Update docs when behavior or mappings change
5. Open a PR with a clear description

### 📂 Guidelines

- Keep core settings in `lua/ghost/config`
- Group plugins by feature under `lua/ghost/plugins`
- Keep language-specific server config under `lsp/`
- Prefer lazy-loaded plugins and small, focused modules
- Update `KEYMAPS.md` when adding or changing user-facing mappings

---

## 📁 Project Structure

```text
.
├── init.lua
├── KEYMAPS.md
├── lsp
│   ├── lua_ls.lua
│   ├── pyright.lua
│   ├── rust_analyzer.lua
│   └── ts_ls.lua
├── lua
│   └── ghost
│       ├── config
│       │   ├── autocmds.lua
│       │   ├── keymaps.lua
│       │   ├── lang_tools.lua
│       │   ├── lazy.lua
│       │   ├── options.lua
│       │   ├── theme.lua
│       │   └── treesitter.lua
│       ├── plugins
│       │   ├── alpha.lua
│       │   ├── bufferline.lua
│       │   ├── colorschemes.lua
│       │   ├── copilot-chat.lua
│       │   ├── gitsigns.lua
│       │   ├── indent-blankline.lua
│       │   ├── lsp
│       │   │   ├── completion.lua
│       │   │   ├── formatting.lua
│       │   │   ├── init.lua
│       │   │   └── linting.lua
│       │   ├── lualine.lua
│       │   ├── misc.lua
│       │   ├── multicursor.lua
│       │   ├── neo-tree.lua
│       │   ├── noice.lua
│       │   ├── telescope.lua
│       │   ├── toggleterm.lua
│       │   └── treesitter.lua
│       └── utils
│           ├── keymap.lua
│           └── ui.lua
└── README.md
```

## Notes

- `nvim-treesitter` is pinned to `master` for compatibility with Neovim `0.11.x`.
- `CopilotChat.nvim` is an optional integration and requires GitHub Copilot access.
- The refactor branch intentionally favors small, focused modules over a monolithic config layout.
