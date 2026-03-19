# ghost-nvim

A modular Neovim configuration focused on a clean editing experience, modern UI, LSP tooling, and practical defaults.

It includes:
- LSP, formatting, and linting
- Treesitter
- Telescope
- Neo-tree
- Gitsigns and LazyGit
- Toggleterm
- Trouble
- Copilot Chat
- Catppuccin

## Requirements

Tested with:
- Neovim `0.11.6`

Recommended tools:
- `git`
- `curl`
- `tar`
- a C compiler
- `ripgrep`
- `make` for `telescope-fzf-native.nvim`
- Nerd Font for icons

Optional but useful:
- `python3`, `lua`, and `bash` for the file runner in `toggleterm`
- a GitHub Copilot subscription if you want to use `CopilotChat.nvim`

## Installation

1. Backup your current Neovim config if needed:

```bash
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
```

2. Clone this repo:

```bash
git clone https://github.com/dotfmg/ghost-nvim.git ~/.config/nvim
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

## Included Plugins

- `alpha-nvim`
- `bufferline.nvim`
- `CopilotChat.nvim`
- `gitsigns.nvim`
- `indent-blankline.nvim`
- `lazygit.nvim`
- `nvim-cmp`
- `conform.nvim`
- `nvim-lint`
- `mason.nvim`
- `mason-lspconfig.nvim`
- `nvim-lspconfig`
- `lualine.nvim`
- `multicursor.nvim`
- `neo-tree.nvim`
- `noice.nvim`
- `telescope.nvim`
- `catppuccin`
- `toggleterm.nvim`
- `nvim-treesitter`
- `trouble.nvim`
- `which-key.nvim`

## Language Tooling

Installed through Mason:
- `lua_ls`
- `pyright`
- `rust_analyzer`
- `ts_ls`

Formatting tools:
- `stylua`
- `prettier`
- `ruff_format`
- `rustfmt`
- `taplo`

Linters:
- `ruff`
- `eslint_d`

## Keymaps

### General

| Key | Action |
| --- | --- |
| `<leader>w` | Save file |
| `<leader>q` | Quit window |
| `<leader>Q` | Quit all |
| `<leader>b` | New buffer |
| `<leader>x` | Close buffer |
| `<Tab>` | Next buffer |
| `<S-Tab>` | Previous buffer |
| `<leader>v` | Vertical split |
| `<leader>h` | Horizontal split |
| `<leader>l` | Next split |
| `<leader>lw` | Toggle wrap |
| `jk` | Exit insert mode |

### Telescope

| Key | Action |
| --- | --- |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fw` | Grep current word |
| `<leader>fh` | Help tags |
| `<leader>fk` | Keymaps |
| `<leader>fs` | Telescope builtins |
| `<leader>fd` | Diagnostics |
| `<leader>fr` | Resume last picker |
| `<leader>f.` | Recent files |
| `<leader>f/` | Live grep in open files |
| `<leader>/` | Fuzzy search current buffer |
| `<leader><leader>` | Open buffers |

### LSP and Diagnostics

| Key | Action |
| --- | --- |
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gt` | Go to type definition |
| `gr` | References |
| `K` | Hover |
| `<leader>ca` | Code action |
| `<leader>cr` | Rename symbol |
| `<leader>dd` | Line diagnostics |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<leader>f` | Format buffer |

### Explorer

| Key | Action |
| --- | --- |
| `<leader>e` | Toggle Neo-tree |

### Git

| Key | Action |
| --- | --- |
| `<leader>gg` | Open LazyGit |
| `[g` | Previous hunk |
| `]g` | Next hunk |
| `<leader>gs` | Stage hunk |
| `<leader>gr` | Reset hunk |
| `<leader>gS` | Stage buffer |
| `<leader>gR` | Reset buffer |
| `<leader>gu` | Undo stage hunk |
| `<leader>gp` | Preview hunk |
| `<leader>gd` | Diff against index |
| `<leader>gD` | Diff against HEAD |
| `<leader>gb` | Blame line |

### Terminal

| Key | Action |
| --- | --- |
| `<C-/>` | Toggle terminal |
| `<leader>tf` | Floating terminal |
| `<leader>tv` | Vertical terminal |
| `<leader>tr` | Run current file |

### Trouble

| Key | Action |
| --- | --- |
| `<leader>dt` | Diagnostics view |
| `<leader>ds` | Symbols view |

### Copilot Chat

| Key | Action |
| --- | --- |
| `<leader>cc` | Toggle chat |
| `<leader>cm` | Select model |
| `<leader>cp` | Select prompt |
| `<leader>cx` | Reset chat |
| `<leader>cq` | Ask about current buffer |
| Visual `<leader>ce` | Explain selection |
| Visual `<leader>cv` | Review selection |
| Visual `<leader>cf` | Fix selection |
| Visual `<leader>co` | Optimize selection |
| Visual `<leader>cd` | Generate docs |
| Visual `<leader>ct` | Generate tests |

### Multicursor

| Key | Action |
| --- | --- |
| `<leader>mk` | Add cursor above |
| `<leader>mj` | Add cursor below |
| `<leader>mK` | Skip cursor above |
| `<leader>mJ` | Skip cursor below |
| `<leader>mn` | Add next match |
| `<leader>ms` | Skip next match |
| `<leader>mN` | Add previous match |
| `<leader>mS` | Skip previous match |
| `<leader>mA` | Add all matches |
| `<leader>mq` | Toggle multicursor |
| `<leader>mv` | Restore cursors |
| `<leader>ma` | Align cursors |

## Project Structure

```text
.
├── init.lua
├── lua
│   └── ghost
│       ├── config
│       │   ├── autocmds.lua
│       │   ├── keymaps.lua
│       │   ├── lazy.lua
│       │   └── options.lua
│       └── plugins
│           ├── alpha.lua
│           ├── bufferline.lua
│           ├── copilot-chat.lua
│           ├── gitsigns.lua
│           ├── indent-blankline.lua
│           ├── lazygit.lua
│           ├── lsp
│           │   ├── completion.lua
│           │   ├── formatting.lua
│           │   ├── init.lua
│           │   └── linting.lua
│           ├── lualine.lua
│           ├── multicursor.lua
│           ├── neo-tree.lua
│           ├── noice.lua
│           ├── telescope.lua
│           ├── theme.lua
│           ├── toggleterm.lua
│           ├── treesitter.lua
│           ├── trouble.lua
│           └── which-key.lua
└── README.md
```

## Notes

- `nvim-treesitter` is pinned to `master` for compatibility with Neovim `0.11.x`.
- `CopilotChat.nvim` is included as an optional integration.
- The config is organized by feature, so it is easy to remove or replace plugins.
