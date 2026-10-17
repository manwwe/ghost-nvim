-- Loaded by init.lua.
local function augroup(name)
    return vim.api.nvim_create_augroup("ghost_" .. name, { clear = true })
end

-- Check for external file changes
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup("checktime"),
    callback = function()
        if vim.o.buftype ~= "nofile" then
            vim.cmd("checktime")
        end
    end,
})

-- Highlight copied text
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Restore the last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup("last_loc"),
    callback = function(event)
        local buf = event.buf
        if vim.bo[buf].filetype == "gitcommit" or vim.b[buf].ghost_last_loc then
            return
        end
        vim.b[buf].ghost_last_loc = true
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(buf) then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Close utility windows with q
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = { "help", "checkhealth", "qf" },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", function()
            vim.cmd("close")
            pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
        end, { buffer = event.buf, silent = true, desc = "Quit buffer" })
    end,
})

-- Create missing parent directories before saving
vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup("auto_create_dir"),
    callback = function(event)
        if event.match:match("^%w%w+:[\\/][\\/]") then
            return
        end
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})
