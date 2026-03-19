-- Configures bufferline for buffer tabs.

return {
  "akinsho/bufferline.nvim",
  dependencies = {
    "moll/vim-bbye",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("bufferline").setup {
      options = {
        offsets = {
          {
            filetype = "neo-tree",
            text = "󰙅 File Explorer",
            text_align = "center",
            separator = false,
            highlight = "Directory",
          },
          {
            filetype = "copilot-chat",
            text = " Copilot Chat",
            text_align = "center",
            separator = false,
            highlight = "Directory",
          },
          {
            filetype = "Avante",
            text = "",
            text_align = "center",
            separator = false,
            highlight = "Directory",
          },
        },
        mode = "buffers",
        numbers = "none",
        themable = true,
        close_command = "Bdelete! %d",
        buffer_close_icon = "✗",
        close_icon = "✗",
        path_components = 1,
        modified_icon = "●",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 15,
        max_prefix_length = 15,
        tab_size = 20,
        diagnostics = false,
        diagnostics_update_in_insert = false,
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        persist_buffer_sort = true,
        separator_style = "thick",
        enforce_regular_tabs = true,
        show_tab_indicators = false,
        icon_pinned = "󰐃",
        sort_by = "insert_at_end",
      },
      highlights = {
        fill = {
          bg = {
            attribute = "fg",
            highlight = "EndOfBuffer",
          },
        },
      },
    }
  end,
}
