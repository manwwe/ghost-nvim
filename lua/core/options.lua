-- Neovim option settings.

-- Line numbers
vim.wo.number = true -- Show line numbers.
vim.o.relativenumber = true -- Show relative line numbers.

-- Clipboard
vim.o.clipboard = 'unnamedplus' -- Use system clipboard.

-- Text wrapping & display
vim.o.wrap = false -- Disable line wrapping.
vim.o.linebreak = true -- Break lines at word boundaries if 'wrap' is on.
vim.o.mouse = 'a' -- Enable mouse support in all modes.
vim.api.nvim_set_option('mouse', 'a') -- Ensure mouse option is applied.

-- Indentation
vim.o.autoindent = true -- Auto-indent new lines.
vim.o.ignorecase = true -- Ignore case in searches (unless uppercase is used).
vim.o.smartcase = true -- Auto switch to case-sensitive if search pattern has uppercase.
vim.o.shiftwidth = 4 -- Spaces for indentation step.
vim.o.tabstop = 4 -- Spaces for a <Tab> character.
vim.o.softtabstop = 4 -- Spaces for <Tab> during editing.
vim.o.expandtab = true -- Use spaces instead of literal tabs.
vim.o.smartindent = true -- Enable smart auto-indenting (e.g., for C-like languages).

-- Scrolling
vim.o.scrolloff = 4 -- Keep 4 lines visible above/below cursor.
vim.o.sidescrolloff = 8 -- Keep 8 columns visible left/right of cursor if 'wrap' is false.

-- Cursor & highlighting
vim.o.cursorline = false -- Disable current line highlighting.
vim.o.hlsearch = false -- Disable search match highlighting.

-- Window splitting
vim.o.splitbelow = true -- New horizontal splits below current window.
vim.o.splitright = true -- New vertical splits right of current window.

-- UI & messages
vim.o.showmode = false -- Don't show current mode (e.g., -- INSERT --).
vim.opt.termguicolors = true -- Enable true color support for colorschemes.
vim.o.whichwrap = 'bs<>[]hl' -- Allow specified keys to move to prev/next line.
vim.o.numberwidth = 4 -- Width of the number column.
vim.o.showtabline = 2 -- Always show tabline.
vim.o.pumheight = 10 -- Max items in popup completion menu.
vim.o.conceallevel = 0 -- Show concealed text (e.g., markdown syntax) by default.
vim.wo.signcolumn = 'yes' -- Always show signcolumn.
vim.o.cmdheight = 1 -- Height of command-line area.
vim.o.updatetime = 250 -- Faster updates for CursorHold events & swap file.
vim.o.timeoutlen = 300 -- Shorter wait for mapped sequences.

-- File handling & backups
vim.o.swapfile = false -- Disable swap files.
vim.o.backup = false -- Disable backup files.
vim.o.writebackup = false -- Disable backup before overwriting.
vim.o.undofile = true -- Enable persistent undo.

-- Completion
vim.o.completeopt = 'menuone,noselect' -- Completion options: show menu even for one item, don't autoselect.

-- Message verbosity & keyword handling
vim.opt.shortmess:append 'c' -- Don't show "match X of Y" completion messages.
vim.opt.iskeyword:append '-' -- Treat hyphenated words as single words.
vim.opt.formatoptions:remove { 'c', 'r', 'o' } -- Control auto-formatting of comments.

-- Runtime path
vim.opt.runtimepath:remove '/usr/share/vim/vimfiles' -- Avoid Vim's user plugin directory conflicts.

-- Special characters appearance
vim.opt.fillchars = { eob = ' ' } -- Use space for "end of buffer" lines instead of '~'.
vim.o.breakindent = true -- Maintain indent level for wrapped lines.
vim.o.fileencoding = 'utf-8' -- Default file encoding.
vim.o.backspace = 'indent,eol,start' -- Allow backspace over autoindent, EOL, start of insert.
