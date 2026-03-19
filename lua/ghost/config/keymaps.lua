-- Configures global Neovim keymaps.

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

local map = vim.keymap.set

local function opts(desc)
  return { noremap = true, silent = true, desc = desc }
end

map({ "n", "v", "i" }, "<leader>w", "<cmd>w<CR><cmd>echo 'File Saved! 💾'<CR>", opts "Save file")
map("n", "<leader>q", "<cmd>q<CR>", opts "Quit window")
map("n", "<leader>Q", "<cmd>qa<CR>", opts "Quit all")
map("n", "<leader>sn", "<cmd>noautocmd w<CR>", opts "Save without formatting")

map("i", "jk", "<Esc>", opts "Exit insert mode")

map("n", "<C-a>", "ggVG", opts "Select entire buffer")

map("n", "H", "g^", opts "First non-blank char")
map("n", "L", "g$", opts "End of line")

map("n", "n", "nzzzv", opts "Next match (centered)")
map("n", "N", "Nzzzv", opts "Previous match (centered)")

map("n", "x", '"_x', opts "Delete char (no yank)")

map("n", "<Tab>", "<cmd>bnext<CR>", opts "Next buffer")
map("n", "<S-Tab>", "<cmd>bprevious<CR>", opts "Previous buffer")
map("n", "<leader>x", "<cmd>bdelete!<CR>", opts "Close buffer")
map("n", "<leader>b", "<cmd>enew<CR>", opts "New buffer")

map("n", "<leader>v", "<C-w>v", opts "Split vertical")
map("n", "<leader>h", "<C-w>s", opts "Split horizontal")
map("n", "<leader>se", "<C-w>=", opts "Equalize splits")
map("n", "<leader>xs", "<cmd>close<CR>", opts "Close split")
map("n", "<leader>l", "<C-w>w", opts "Next split")

map("n", "<C-h>", "<C-w>h", opts "Focus left window")
map("n", "<C-j>", "<C-w>j", opts "Focus below window")
map("n", "<C-k>", "<C-w>k", opts "Focus above window")
map("n", "<C-l>", "<C-w>l", opts "Focus right window")

map("v", "<", "<gv", opts "Unindent")
map("v", ">", ">gv", opts "Indent")

map("n", "<leader>lw", "<cmd>set wrap!<CR>", opts "Toggle line wrap")

map("v", "J", ":m '>+1<CR>gv=gv", opts "Move line down")
map("v", "K", ":m '<-2<CR>gv=gv", opts "Move line up")

map("v", "p", '"_dP', opts "Paste without overwriting register")
