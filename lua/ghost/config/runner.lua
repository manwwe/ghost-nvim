-- Runs the current file in a Snacks terminal.

local M = {}
local runners = {}

local function compiled(compiler, standard, file)
    local binary = vim.fn.tempname()
    local target = vim.fn.shellescape(binary)
    return string.format("%s -Wall -Wextra -pedantic -std=%s %s -o %s && %s",
        compiler, standard, vim.fn.shellescape(file), target, target), binary
end

local specs = {
    c = function(file) return compiled("/opt/homebrew/bin/gcc-16", "c11", file) end,
    cpp = function(file) return compiled("/opt/homebrew/bin/g++-16", "c++20", file) end,
    lua = function(file) return "lua " .. vim.fn.shellescape(file) end,
    python = function(file) return "python3 " .. vim.fn.shellescape(file) end,
    sh = function(file) return "bash " .. vim.fn.shellescape(file) end,
}

function M.run(opts)
    opts = opts or {}
    local build = specs[vim.bo.filetype]
    if not build or vim.bo.buftype ~= "" then
        vim.notify("Unsupported filetype for execution: " .. vim.bo.filetype, vim.log.levels.WARN)
        return
    end
    local file = vim.api.nvim_buf_get_name(0)
    if file == "" then
        vim.notify("Save the file before running it", vim.log.levels.WARN)
        return
    end
    if vim.bo.modified then
        vim.cmd.write()
    end
    local previous = runners[file]
    if previous then
        previous:close()
    end
    local command, binary = build(file)
    local input
    local script = command
    if opts.collect_input then
        input = vim.fn.tempname()
        local escaped_input = vim.fn.shellescape(input)
        local cleanup = "rm -f -- " .. escaped_input
        if binary then cleanup = cleanup .. " " .. vim.fn.shellescape(binary) end
        cleanup = cleanup .. '; stty "$ghost_terminal_state"'
        script = table.concat({
            'ghost_terminal_state=$(stty -g)',
            "trap " .. vim.fn.shellescape(cleanup) .. " EXIT",
            "stty -echoctl",
            "printf '%s\\n' '--- input (Ctrl+d to run) ---'",
            "cat > " .. escaped_input .. " || exit",
            'stty "$ghost_terminal_state"',
            "printf '\\n%s\\n' '--- output ---'",
            "sh -c " .. vim.fn.shellescape(command) .. " < " .. escaped_input,
        }, "\n")
    end
    local term = require("snacks").terminal.open({ "sh", "-c", script }, {
        cwd = vim.fn.fnamemodify(file, ":h"),
        auto_close = false,
        win = {
            position = "float",
            border = "rounded",
            title = "Run: " .. vim.fn.fnamemodify(file, ":t"),
            wo = { winhighlight = "FloatBorder:GhostTerminalBorder" },
        },
    })
    runners[file] = term
    term:on("BufWipeout", function()
        if runners[file] == term then runners[file] = nil end
        if input then vim.fn.delete(input) end
        if binary then vim.fn.delete(binary) end
    end, { buf = true })
end

return M
