return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    lazy = false, -- Neo-tree handles its own lazy loading
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        {
            "<leader>e",
            function()
                local root = vim.fs.root(0, { ".git", "Cargo.toml", "pyproject.toml", "package.json", "Makefile" })
                require("neo-tree.command").execute({ toggle = true, dir = root or vim.fn.getcwd() })
            end,
            desc = "Explorer (project root)",
        },
        {
            "<leader>E",
            function()
                require("neo-tree.command").execute({ toggle = true, dir = vim.fn.getcwd() })
            end,
            desc = "Explorer (current directory)",
        },
        { "<leader>fe", "<leader>e", remap = true, desc = "Explorer (project root)" },
        { "<leader>fE", "<leader>E", remap = true, desc = "Explorer (current directory)" },
        {
            "<leader>ge",
            function()
                require("neo-tree.command").execute({ source = "git_status", toggle = true })
            end,
            desc = "Git explorer",
        },
        {
            "<leader>be",
            function()
                require("neo-tree.command").execute({ source = "buffers", toggle = true })
            end,
            desc = "Buffer explorer",
        },
    },
    opts = {
        event_handlers = {
            {
                event = "file_opened",
                handler = function()
                    require("neo-tree.command").execute({ action = "close" })
                end,
            },
        },
        close_if_last_window = true,
        enable_diagnostics = false,
        sources = { "filesystem", "buffers", "git_status" },
        open_files_do_not_replace_types = { "terminal", "qf" },
        filesystem = {
            components = {
                name = function(config, node, state)
                    local component = require("neo-tree.sources.common.components").name(config, node, state)
                    if node:get_depth() == 1 then
                        component.text = vim.fn.fnamemodify(node:get_id(), ":t")
                    end
                    return component
                end,
            },
            filtered_items = {
                show_hidden_count = false,
                hide_dotfiles = false,
                hide_gitignored = false,
                hide_by_name = {
                    ".DS_Store",
                    "thumbs.db",
                    "node_modules",
                    "__pycache__",
                    ".virtual_documents",
                    ".git",
                    ".python-version",
                    ".venv",
                },
                never_show = { ".git", ".DS_Store" },
            },
            bind_to_cwd = false,
            follow_current_file = { enabled = true },
            use_libuv_file_watcher = true,
        },
        window = {
            mappings = {
                l = "open",
                h = "close_node",
                ["<space>"] = "none",
                Y = {
                    function(state)
                        vim.fn.setreg("+", state.tree:get_node():get_id(), "c")
                    end,
                    desc = "Copy path to clipboard",
                },
                O = {
                    function(state)
                        vim.ui.open(state.tree:get_node().path)
                    end,
                    desc = "Open with system application",
                },
                P = { "toggle_preview", config = { use_float = false } },
            },
        },
    },
}
