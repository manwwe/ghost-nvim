-- Configures the lualine statusline.
return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "folke/snacks.nvim",
    },
    opts = {
        options = {
            theme = "auto",
            globalstatus = true,
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            disabled_filetypes = { statusline = { "alpha" } },
        },
        sections = {
            lualine_a = {
                {
                    "mode",
                    icons_enabled = true,
                    icon = "󰊠",
                    separator = { right = "" },
                },
            },
            lualine_b = {
                {
                    "branch",
                    icon = "",
                    fmt = function(str)
                        if #str > 15 then
                            return str:sub(1, 15) .. "…"
                        end
                        return str
                    end,
                    on_click = function(_, button)
                        if button == "l" then
                            Snacks.lazygit()
                        elseif button == "r" then
                            Snacks.picker.git_branches()
                        elseif button == "m" then
                            Snacks.picker.git_log()
                        end
                    end,
                },
                {
                    "diff",
                    symbols = { added = " ", modified = " ", removed = " " },
                    separator = { right = "" },
                },
            },
            lualine_c = {
                {
                    "filename",
                    color = function()
                        if vim.bo.modified then
                            return { fg = "#ffaa88", gui = "bold" }
                        end
                        return { gui = "bold" }
                    end,
                    on_click = function()
                        Snacks.picker.files()
                    end,
                },
            },
            lualine_x = {
                {
                    function()
                        for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0, name = "copilot" })) do
                            if client.initialized then
                                return " " -- Connected
                            end
                        end
                        return " " -- Inactive
                    end,
                    color = function()
                        for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0, name = "copilot" })) do
                            if client.initialized then
                                return { fg = "#a7c080" } -- Connected
                            end
                        end
                        return { fg = "#859289" } -- Inactive
                    end,
                },
                {
                    "diagnostics",
                    sources = { "nvim_lsp" },
                    symbols = { error = " ", warn = " ", hint = " ", info = " " },
                },
                {
                    function()
                        local clients = vim.lsp.get_clients({ bufnr = 0 })
                        if #clients == 0 then
                            return ""
                        end
                        local names = {}
                        for _, client in ipairs(clients) do
                            names[#names + 1] = client.name
                        end
                        return " LSP: " .. table.concat(names, ", ")
                    end,
                },
                "filetype",
            },
            lualine_y = { "progress" },
            lualine_z = { "location" },
        },
        inactive_sections = {
            lualine_c = { "filename" },
            lualine_x = { "location" },
        },
    },
}
