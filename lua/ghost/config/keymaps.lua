-- keymaps.lua
-- Global keymaps: navigation, buffers, windows, splits, and editor actions.
-- Requires Neovim >= 0.11

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Prevent Space from moving cursor before acting as leader
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

local map = vim.keymap.set

local function opts(desc)
  return { noremap = true, silent = true, desc = desc }
end

-- Save & Quit
map({ "n", "v", "i" }, "<leader>w", "<cmd>w<CR>", opts("Save file"))
map("n", "<leader>q", "<cmd>q<CR>", opts("Quit window"))
map("n", "<leader>Q", "<cmd>qa<CR>", opts("Quit all"))
map("n", "<leader>sn", "<cmd>noautocmd w<CR>", opts("Save without formatting"))

-- Insert mode
map("i", "jk", "<Esc>", opts("Exit insert mode"))

-- Selection
map("n", "<C-a>", "ggVG", opts("Select entire buffer"))

-- Line navigation (overrides default H=top-of-screen, L=bottom-of-screen)
map("n", "H", "g^", opts("First non-blank char"))
map("n", "L", "g$", opts("End of line"))

-- Search centered
map("n", "n", "nzzzv", opts("Next match (centered)"))
map("n", "N", "Nzzzv", opts("Previous match (centered)"))

-- Delete without yanking
map("n", "x", '"_x', opts("Delete char (no yank)"))

-- Buffer management
map("n", "<Tab>", "<cmd>bnext<CR>", opts("Next buffer"))
map("n", "<S-Tab>", "<cmd>bprevious<CR>", opts("Previous buffer"))
map("n", "<leader>x", "<cmd>bdelete!<CR>", opts("Close buffer"))
map("n", "<leader>b", "<cmd>enew<CR>", opts("New buffer"))

-- Window splits
map("n", "<leader>v", "<C-w>v", opts("Split vertical"))
map("n", "<leader>h", "<C-w>s", opts("Split horizontal"))
map("n", "<leader>se", "<C-w>=", opts("Equalize splits"))
map("n", "<leader>xs", "<cmd>close<CR>", opts("Close split"))
map("n", "<leader>l", "<C-w>w", opts("Next split"))

-- Window navigation
map("n", "<C-h>", "<C-w>h", opts("Focus left window"))
map("n", "<C-j>", "<C-w>j", opts("Focus below window"))
map("n", "<C-k>", "<C-w>k", opts("Focus above window"))
map("n", "<C-l>", "<C-w>l", opts("Focus right window"))

-- Visual indent
map("v", "<", "<gv", opts("Unindent"))
map("v", ">", ">gv", opts("Indent"))

-- Toggle wrap
map("n", "<leader>lw", "<cmd>set wrap!<CR>", opts("Toggle line wrap"))

-- Move lines in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", opts("Move line down"))
map("v", "K", ":m '<-2<CR>gv=gv", opts("Move line up"))

-- Paste without overwriting register
map("v", "p", '"_dP', opts("Paste without overwriting register"))
