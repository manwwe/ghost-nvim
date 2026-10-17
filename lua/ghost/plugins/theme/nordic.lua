-- Configures Nordic's operator and punctuation colors.

return {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        on_highlight = function(highlights)
            highlights.Operator = { fg = "#88C0D0" } -- Operators
            highlights["@operator"] = { fg = "#88C0D0" }
            highlights.Delimiter = { fg = "#B48EAD" } -- Colons and other delimiters
            highlights["@punctuation.delimiter"] = { fg = "#B48EAD" }
            highlights["@punctuation.bracket"] = { fg = "#81A1C1" } -- Brackets
        end,
    },
    config = function(_, opts)
        require("nordic").setup(opts)
        vim.cmd.colorscheme("nordic")
    end,
}
