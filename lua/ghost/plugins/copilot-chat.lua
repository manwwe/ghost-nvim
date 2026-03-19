-- Configures Copilot Chat commands, prompts, and keymaps.

return {
  "CopilotC-Nvim/CopilotChat.nvim",
  cmd = {
    "CopilotChat",
    "CopilotChatOpen",
    "CopilotChatClose",
    "CopilotChatToggle",
    "CopilotChatStop",
    "CopilotChatReset",
    "CopilotChatModels",
    "CopilotChatPrompts",
  },
  dependencies = {
    { "nvim-lua/plenary.nvim", branch = "master" },
  },
  keys = {
    { "<leader>cc", "<cmd>CopilotChatToggle<CR>", desc = "Toggle Copilot Chat", mode = { "n", "v" } },
    { "<leader>cm", "<cmd>CopilotChatModels<CR>", desc = "Select Copilot model" },
    { "<leader>cp", "<cmd>CopilotChatPrompts<CR>", desc = "Select Copilot prompt" },
    { "<leader>cx", "<cmd>CopilotChatReset<CR>", desc = "Reset Copilot chat" },
    {
      "<leader>cq",
      function()
        local input = vim.fn.input "Quick Chat: "
        if input == "" then
          return
        end

        require("CopilotChat").ask(input, {
          selection = require("CopilotChat.select").buffer,
        })
      end,
      desc = "Quick chat with buffer",
    },
    {
      "<leader>ce",
      function()
        require("CopilotChat").ask("/Explain", {
          selection = require("CopilotChat.select").visual,
        })
      end,
      desc = "Explain selection",
      mode = "v",
    },
    {
      "<leader>cv",
      function()
        require("CopilotChat").ask("/Review", {
          selection = require("CopilotChat.select").visual,
        })
      end,
      desc = "Review selection",
      mode = "v",
    },
    {
      "<leader>cf",
      function()
        require("CopilotChat").ask("/Fix", {
          selection = require("CopilotChat.select").visual,
        })
      end,
      desc = "Fix selection",
      mode = "v",
    },
    {
      "<leader>co",
      function()
        require("CopilotChat").ask("/Optimize", {
          selection = require("CopilotChat.select").visual,
        })
      end,
      desc = "Optimize selection",
      mode = "v",
    },
    {
      "<leader>cd",
      function()
        require("CopilotChat").ask("/Docs", {
          selection = require("CopilotChat.select").visual,
        })
      end,
      desc = "Document selection",
      mode = "v",
    },
    {
      "<leader>ct",
      function()
        require("CopilotChat").ask("/Tests", {
          selection = require("CopilotChat.select").visual,
        })
      end,
      desc = "Generate tests for selection",
      mode = "v",
    },
  },
  opts = {
    model = "gpt-4.1",
    temperature = 0.1,
    auto_insert_mode = true,
    window = {
      layout = "vertical",
      width = 0.42,
      border = "rounded",
      title = " Copilot Chat ",
    },
    headers = {
      user = "  ",
      assistant = "  ",
      tool = " Tool  ",
    },
    separator = "━━",
  },
  config = function(_, opts)
    require("CopilotChat").setup(opts)
  end,
}
