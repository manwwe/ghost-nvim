-- This file is automatically loaded by init.lua

-- Disable space in normal and visual mode
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Helper
local function map(mode, lhs, rhs, opts)
    if type(opts) == "string" then
        opts = { desc = opts }
    end
    vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", { silent = true }, opts or {}))
end

-- Files
map("n", "<leader>fn", "<cmd>enew<CR>", "New file")
map({ "n", "v" }, "<leader>fs", "<cmd>w<CR><cmd>echo 'File Saved! 💾'<CR>", "Save file")
map("n", "<leader>fS", "<cmd>noautocmd w<CR>", "Save without formatting")

-- Quit
map("n", "<leader>qq", "<cmd>qa<CR>", "Quit all")

-- Exit insert and terminal modes
map("i", "jj", "<Esc>", "Exit insert mode")
map("t", "jj", [[<C-\><C-n>]], "Exit terminal mode")

-- Select all
map("n", "<leader>ba", "ggVG", "Select entire buffer")

-- Move by screen rows unless a count is given
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Navigate search matches
map("n", "n", "nzzzv", "Next match (centered)")
map("n", "N", "Nzzzv", "Previous match (centered)")

-- Clear search highlighting on escape
map({ "i", "n", "s" }, "<Esc>", "<cmd>nohlsearch<CR><Esc>", "Escape and clear search highlighting")

-- Location list
map("n", "<leader>xl", function()
    local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
    if not success and err then
        vim.notify(err, vim.log.levels.ERROR)
    end
end, { desc = "Location List" })

-- Quickfix list
map("n", "<leader>xq", function()
    local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
    if not success and err then
        vim.notify(err, vim.log.levels.ERROR)
    end
end, { desc = "Quickfix List" })
map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- Diagnostics
local function diagnostic_goto(next, severity)
    return function()
        vim.diagnostic.jump({
            count = (next and 1 or -1) * vim.v.count1,
            severity = severity and vim.diagnostic.severity[severity] or nil,
            float = true,
        })
    end
end

map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- Keyword lookup
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- Commenting
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", "Add Comment Below")
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", "Add Comment Above")

-- Buffers
map("n", "<S-h>", "<cmd>bprevious<CR>", "Previous buffer")
map("n", "<S-l>", "<cmd>bnext<CR>", "Next buffer")
map("n", "[b", "<cmd>bprevious<CR>", "Previous buffer")
map("n", "]b", "<cmd>bnext<CR>", "Next buffer")
map("n", "<leader>bb", "<cmd>edit #<CR>", "Switch to other buffer")
map("n", "<leader>`", "<cmd>edit #<CR>", "Switch to other buffer")
map("n", "<leader>bd", "<cmd>bdelete!<CR>", "Close buffer")
map("n", "<leader>bD", "<cmd>bdelete<CR>", "Delete buffer and window")
map("n", "<leader>bn", "<cmd>enew<CR>", "New buffer")

-- Splits
map("n", "<leader>wv", "<C-w>v", "Split vertical")
map("n", "<leader>ws", "<C-w>s", "Split horizontal")
map("n", "<leader>w=", "<C-w>=", "Equalize splits")
map("n", "<leader>wc", "<cmd>close<CR>", "Close split")

map("n", "<leader>wo", "<cmd>only<CR>", "Close other windows")
for key, direction in pairs({ h = "left", j = "below", k = "above", l = "right" }) do
    map("n", "<leader>w" .. key, "<C-w>" .. key, "Focus " .. direction .. " window")
end

-- Navigate windows using <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", "Focus left window")
map("n", "<C-j>", "<C-w>j", "Focus below window")
map("n", "<C-k>", "<C-w>k", "Focus above window")
map("n", "<C-l>", "<C-w>l", "Focus right window")
map("t", "<C-h>", [[<C-\><C-n><cmd>wincmd h<CR>]], "Focus left window")
map("t", "<C-j>", [[<C-\><C-n><cmd>wincmd j<CR>]], "Focus below window")
map("t", "<C-k>", [[<C-\><C-n><cmd>wincmd k<CR>]], "Focus above window")
map("t", "<C-l>", [[<C-\><C-n><cmd>wincmd l<CR>]], "Focus right window")

-- Resize windows using <leader>w and arrow keys
map("n", "<leader>w<Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<leader>w<Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<leader>w<Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<leader>w<Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Adjust indentation and keep the selection
map("v", "<", "<gv", "Unindent")
map("v", ">", ">gv", "Indent")

-- Toggle display options
map(
    "n",
    "<leader>ur",
    "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
    { desc = "Redraw / Clear hlsearch / Diff Update" }
)
-- Move selected lines
map("v", "J", ":m '>+1<CR>gv=gv", "Move line down")
map("v", "K", ":m '<-2<CR>gv=gv", "Move line up")

-- Paste without overwriting the register
map("v", "p", '"_dP', "Paste without overwriting register")
