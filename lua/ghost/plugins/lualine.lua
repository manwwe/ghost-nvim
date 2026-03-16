return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("lualine").setup {
      options = {
        theme = "nord",
        globalstatus = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = { "neo-tree", "Avante" },
        },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            icons_enabled = true,
            icon = "󰊠",
            separator = { right = "" },
            fmt = function(str)
              return str:sub(1, 1)
            end,
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
            on_click = function(clicks, button)
              if button == "l" then
                vim.cmd "LazyGit"
              elseif button == "r" then
                vim.cmd "Telescope git_branches"
              elseif button == "m" then
                vim.cmd "Telescope git_commits"
              end
            end,
          },
          {
            "diff",
            symbols = { added = " ", modified = " ", removed = " " },
            fmt = function(str)
              local ahead = vim.fn.system("git rev-list @{u}..HEAD --count 2>/dev/null"):gsub("\n", "")
              local behind = vim.fn.system("git rev-list HEAD..@{u} --count 2>/dev/null"):gsub("\n", "")

              local result = str
              if tonumber(ahead) and tonumber(ahead) > 0 then
                result = result .. " " .. ahead -- commits para pushear
              end
              if tonumber(behind) and tonumber(behind) > 0 then
                result = result .. " " .. behind -- commits para pullear
              end
              return result
            end,
          },
        },
        lualine_c = {},
        lualine_x = {
          {
            "diagnostics",
            sources = { "nvim_lsp" },
            symbols = { error = " ", warn = " ", hint = " ", info = " " },
          },
          {
            function()
              local clients = vim.lsp.get_clients { bufnr = 0 }
              if #clients == 0 then
                return ""
              end
              local names = {}
              for _, c in pairs(clients) do
                table.insert(names, c.name)
              end
              return " " .. table.concat(names, ", ")
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
    }
  end,
}
