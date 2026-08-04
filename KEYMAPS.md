# Keymaps

Reference for the default keymaps included in `ghost-nvim`.

Main mappings live in `lua/ghost/config/keymaps.lua`, with plugin-specific mappings defined in their respective plugin files.

## Recent Layout Changes

| Before | Now | Action |
| --- | --- | --- |
| `<leader>q` | `<leader>qq` | Quit window |
| `<leader>Q` | `<leader>qa` | Quit all |
| `<leader>sn` | `<leader>W` | Save without formatting |
| `<leader>b` | `<leader>bn` | New buffer |
| `<leader>x` | `<leader>bd` | Close buffer |
| `<leader>v` | `<leader>sv` | Vertical split |
| `<leader>h` | `<leader>sh` | Horizontal split |
| `<leader>xs` | `<leader>sx` | Close split |
| `<leader>lw` | `<leader>uw` | Toggle wrap |
| `<leader>f` | `<leader>fm` | Format buffer |
| `<C-a>` | `<leader>sa` | Select entire buffer |
| `gi` | `gri` | Go to implementation |
| `gt` | `grt` | Go to type definition |

## General

| Key | Action |
| --- | --- |
| `<leader>w` | Save file |
| `<leader>W` | Save without formatting |
| `<leader>qq` | Quit window |
| `<leader>qa` | Quit all |
| `<leader>bn` | New buffer |
| `<leader>bd` | Close buffer |
| `<Tab>` | Next buffer |
| `<S-Tab>` | Previous buffer |
| `<leader>sv` | Vertical split |
| `<leader>sh` | Horizontal split |
| `<leader>se` | Equalize splits |
| `<leader>sx` | Close split |
| `<leader>uw` | Toggle wrap |
| `<leader>sa` | Select entire buffer |
| `jj` | Exit insert/terminal mode |
## Telescope

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

## LSP and Diagnostics

| Key | Action |
| --- | --- |
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gri` | Go to implementation |
| `grt` | Go to type definition |
| `<leader>dd` | Line diagnostics |
| `<leader>fm` | Format buffer |

## Explorer

| Key | Action |
| --- | --- |
| `<leader>e` | Toggle Neo-tree |

## Git

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

## Terminal

| Key | Action |
| --- | --- |
| `<C-/>` | Toggle terminal |
| `<leader>tf` | Floating terminal |
| `<leader>tv` | Vertical terminal |
| `<leader>tr` | Run current file or compile and run C/C++ |

## Trouble

| Key | Action |
| --- | --- |
| `<leader>dt` | Diagnostics view |
| `<leader>ds` | Symbols view |

## Copilot Chat

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

## CodeSnap

| Key | Action |
| --- | --- |
| Visual `<leader>uc` | Copy selected code as image |
| Visual `<leader>uC` | Copy selected code as ASCII snapshot |
| Visual `<leader>us` | Save selected code as image |

## Multicursor

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
