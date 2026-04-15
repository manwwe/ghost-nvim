-- Configures global Neovim keymaps.

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

local keymap = require "ghost.utils.keymap"
local map = keymap.map
local theme = require "ghost.config.theme"

theme.setup()

map({ "n", "v" }, "<leader>w", "<cmd>w<CR><cmd>echo 'File Saved! 💾'<CR>", "Save file")
map("n", "<leader>qq", "<cmd>q<CR>", "Quit window")
map("n", "<leader>qa", "<cmd>qa<CR>", "Quit all")
map("n", "<leader>W", "<cmd>noautocmd w<CR>", "Save without formatting")

map("i", "jj", "<Esc>", "Exit insert mode")
map("t", "jj", [[<C-\><C-n>]], "Exit terminal mode")

map("n", "<leader>sa", "ggVG", "Select entire buffer")

map("n", "H", "g^", "First non-blank char")
map("n", "L", "g$", "End of line")

map("n", "n", "nzzzv", "Next match (centered)")
map("n", "N", "Nzzzv", "Previous match (centered)")

map("n", "x", '"_x', "Delete char (no yank)")

map("n", "<Tab>", "<cmd>bnext<CR>", "Next buffer")
map("n", "<S-Tab>", "<cmd>bprevious<CR>", "Previous buffer")
map("n", "<leader>bd", "<cmd>bdelete!<CR>", "Close buffer")
map("n", "<leader>bn", "<cmd>enew<CR>", "New buffer")

map("n", "<leader>sv", "<C-w>v", "Split vertical")
map("n", "<leader>sh", "<C-w>s", "Split horizontal")
map("n", "<leader>se", "<C-w>=", "Equalize splits")
map("n", "<leader>sx", "<cmd>close<CR>", "Close split")

map("n", "<C-h>", "<C-w>h", "Focus left window")
map("n", "<C-j>", "<C-w>j", "Focus below window")
map("n", "<C-k>", "<C-w>k", "Focus above window")
map("n", "<C-l>", "<C-w>l", "Focus right window")
map("t", "<C-h>", [[<C-\><C-n><cmd>wincmd h<CR>]], "Focus left window")
map("t", "<C-j>", [[<C-\><C-n><cmd>wincmd j<CR>]], "Focus below window")
map("t", "<C-k>", [[<C-\><C-n><cmd>wincmd k<CR>]], "Focus above window")
map("t", "<C-l>", [[<C-\><C-n><cmd>wincmd l<CR>]], "Focus right window")

map("v", "<", "<gv", "Unindent")
map("v", ">", ">gv", "Indent")

map("n", "<leader>uw", "<cmd>set wrap!<CR>", "Toggle line wrap")
map("n", "<leader>un", function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, "Toggle relative numbers")
map("n", "<leader>ut", function()
  theme.pick()
end, "Pick theme")

map("v", "J", ":m '>+1<CR>gv=gv", "Move line down")
map("v", "K", ":m '<-2<CR>gv=gv", "Move line up")

map("v", "p", '"_dP', "Paste without overwriting register")
