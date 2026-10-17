return {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "1.*",
    opts = {
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
