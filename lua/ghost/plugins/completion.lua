return {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets", "fang2hou/blink-copilot" },
    version = "1.*",
    opts = {
        sources = {
            default = { "lsp", "path", "snippets", "buffer", "copilot" },
            providers = {
                copilot = {
                    name = "Copilot",
                    module = "blink-copilot",
                    async = true,
                    enabled = function() return vim.g.copilot_enabled == true end,
                },
            },
        },
        keymap = {
            preset = "enter",
            -- ["<C-y>"] = { "select_and_accept" },
            -- ["<C-j>"] = { "select_next", "fallback" },
            ["<Tab>"] = { "accept", "fallback" },
            ["<CR>"] = { "accept", "fallback" },
        },
        completion = {
            list = { selection = { preselect = false, auto_insert = false } },
            menu = {
                draw = {
                    treesitter = { "lsp" },
                },
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,
            },
        },
    },
}
