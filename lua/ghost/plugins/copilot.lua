-- Loads Copilot only when explicitly requested.

return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    init = function()
        vim.g.copilot_enabled = false
    end,
    opts = {
        panel = { enabled = false },
        suggestion = { enabled = false },
        should_attach = function(buf)
            return vim.g.copilot_enabled == true
                and vim.bo[buf].buflisted
                and vim.bo[buf].buftype == ""
        end,
    },
    config = function(_, opts)
        require("copilot").setup(opts)
        if not vim.g.copilot_enabled then
            require("copilot.command").disable()
        end
    end,
}
