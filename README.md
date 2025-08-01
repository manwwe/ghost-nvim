<div align="center">
  <img src="https://dotfmg.github.io/imagenes-static/img/logo_2.jpg" alt="ghost-nvim logo" width="700"/>
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

**ghost-nvim** is an optimized Neovim configuration that places **artificial intelligence at the core** of the development experience. It seamlessly integrates AI assistants like **GitHub Copilot** and **Codeium (Windsurf)** via `nvim-cmp`, offering a fast, intelligent, and highly productive environment.

> 🧪 **Version**: `v0.0.1` – _Beta release – features and structure may change frequently._

---

<div align="center">
  <img src="https://dotfmg.github.io/imagenes-static/img/dashboard.png" alt="ghost-nvim dashboard preview"/>
  <br><br>
  <img src="https://dotfmg.github.io/imagenes-static/img/ai.png" alt="AI integration preview"/>
</div>

---

## ✨ Features

**ghost-nvim** delivers a **high-performance**, **AI-powered** development workflow with modern tools and seamless usability.

- 💡 **Unified AI Suggestions**  
  Copilot and Codeium are integrated into the completion menu—**no ghost text**, just clean and non-intrusive suggestions.

- 🤖 **Smart AI Commands**  
  Use `CopilotChat` for commit messages, refactoring, pseudocode, and more—context-aware and efficient.

- ⚡ **Ultra-fast Startup**  
  Loads in **0.02–0.05 seconds**.

- 🧩 **Modern Plugin Management**  
  Powered by `lazy.nvim`, with efficient on-demand loading.

- 🛠️ **Full IDE Feature Set**  
  Autocompletion, Git tools, debugging, LSP, snippets, and more.

- 🎨 **Highly Customizable**  
  Modular and extensible by design.

---

## 🚀 Installation

Requires Neovim ≥ **0.8.0** (nightly recommended). Plugin management is handled via `lazy.nvim`.

### 🔧 Prerequisites

Install the following dependencies:

- Neovim 0.8+
- Git
- Nerd Font (for icons)
- ripgrep (`rg`)
- fzf:
  - macOS: `brew install fzf`
  - Ubuntu: `sudo apt install fzf`
  - Arch: `sudo pacman -S fzf`
- Node.js & npm
- Python & pip

---

## ⚙️ Setup

### 📦 Step-by-Step

1. Backup existing config:

   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   mv ~/.local/share/nvim ~/.local/share/nvim.bak
   ```

2. Clone the repo:

   ```bash
   git clone https://github.com/dotfmg/ghost-nvim.git ~/.config/nvim
   ```

3. Launch Neovim:

   ```bash
   nvim
   ```

4. Let `lazy.nvim` install plugins. Use:
   - `:Lazy`
   - `:Lazy sync`
   - `:Lazy update`

5. Run `:Mason` to install/manage LSPs and formatters.

✅ You're ready to use **ghost-nvim**!

---

## 🧪 Usage

### 🔌 Plugin Management

- Plugins are auto-installed on launch.
- Use `:Lazy` for sync, updates, and status.

---

### Key Features & Plugins

#### 🤖 AI Assistance

**GitHub Copilot**:

- Suggestions via `copilot.lua`
- Chat interface via `CopilotChat.nvim`
- 🛂 **Authentication**: Run `:Copilot setup` to log in to GitHub and enable Copilot.

**Codeium**:

- Real-time completions with `windsurf.nvim`
- Unified with Copilot in the `nvim-cmp` menu
- 🛂 **Authentication**: Run `:Codeium Auth` to authenticate your Codeium account.

#### ⚙️ Completion Engine (`nvim-cmp`)

- Unified suggestions: AI, LSP, snippets, paths
- Uses `<Tab>`, `<S-Tab>`, `<CR>` for navigation
- AI prioritized with custom sorting

#### 🔍 Telescope

- Fuzzy finder mapped to `<leader>f` commands

#### 🧠 LSP + Code Intelligence

- `mason.nvim`, `nvim-lspconfig`, `none-ls.nvim`
- Autoformat on save
- Prettier, Ruff, Shellcheck, and more

#### 🌈 UI/UX

- Themes: Catppuccin, Gruvbox, Nord
- Dashboard: `alpha-nvim`
- File tree: `neo-tree.nvim`
- Notifications: `noice.nvim`

#### 🧩 Tools

- Git: `gitsigns.nvim`, `lazygit.nvim`
- Terminal: `toggleterm.nvim`
- QoL: sessions, last-place, autopairs, todos

---

### 🤖 Custom AI Features

- Smart commit: `<leader>ac`
- Prompt visual code: `<leader>av`
- Full-buffer prompt: `<leader>ab`
- Ask anything: `<leader>ai`

Prompt options:

- Explain
- Refactor
- Add types
- Pseudocode
- Improve names
- Logging
- Security audit

Explore `lua/plugins/ai` or run `:Lazy`.

---

## 🎮 Keybindings

### 🤖 CopilotChat

| Keybinding   | Action                     |
| ------------ | -------------------------- |
| `<leader>ao` | Open chat                  |
| `<leader>ac` | Smart commit from Git diff |
| `<leader>av` | AI on selection            |
| `<leader>ab` | AI on buffer               |
| `<leader>ai` | Ask question               |
| `<leader>a?` | Select model               |
| `<leader>aa` | Select agent               |
| `<leader>al` | Reset CopilotChat buffer   |

### ⚙️ Completion

| Key       | Action              |
| --------- | ------------------- |
| `<Tab>`   | Next suggestion     |
| `<S-Tab>` | Previous suggestion |
| `<CR>`    | Confirm selection   |

### 🔍 Telescope

| Keybinding   | Action       |
| ------------ | ------------ |
| `<leader>ff` | Find files   |
| `<leader>fg` | Live grep    |
| `<leader>fb` | Open buffers |
| `<leader>fh` | Help tags    |

### 🧠 LSP

| Keybinding   | Action           |
| ------------ | ---------------- |
| `gd`         | Go to definition |
| `gr`         | Find references  |
| `K`          | Hover info       |
| `<leader>rn` | Rename symbol    |
| `<leader>ca` | Code action      |

### 🧱 File Explorer

| Keybinding  | Action           |
| ----------- | ---------------- |
| `<leader>e` | Toggle file tree |

### 🖥️ Terminal

| Keybinding   | Action               |
| ------------ | -------------------- |
| `<C-_>`      | Toggle main terminal |
| `<leader>tf` | Floating terminal    |
| `<leader>tr` | Run file in terminal |

### 🔧 Sessions

| Keybinding   | Action                   |
| ------------ | ------------------------ |
| `<leader>ps` | Restore previous session |
| `<leader>pl` | List saved sessions      |

---

## 🤝 Contributing

Help improve **ghost-nvim** with ideas, fixes, and features.

### 💡 What You Can Do

- Improve AI tools or UX
- Add prompts/workflows
- Support more tools or languages

### 🧪 How to Contribute

1. Fork the repo
2. Create a branch
3. Write clear, documented code
4. Submit a PR with description

### 📂 Guidelines

- Follow the folder structure (`lua/plugins/ai/`, etc.)
- Use lazy-loaded plugins
- Document keybindings and features

---

## 📁 Project Structure

```
.
├── init.lua                  # Entry point
├── lua
│   ├── core                  # Options, keymaps, lazy setup
│   ├── plugins
│   │   ├── ai               # Copilot & Codeium
│   │   ├── appearance       # Themes & UI
│   │   ├── coding           # Syntax helpers
│   │   ├── git              # Git integrations
│   │   ├── lsp              # LSP, cmp, formatting
│   │   ├── search           # Telescope, ctrlsf
│   │   ├── session          # Persistence tools
│   │   ├── terminal         # Terminal helpers
│   │   └── themes           # Color schemes
└── README.md
```
