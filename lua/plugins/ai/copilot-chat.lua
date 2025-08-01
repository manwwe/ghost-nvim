local myprompts = require("plugins.ai.prompts.copilot-prompts")

return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      model = "gpt-4.1",
      prompts = myprompts,
      sticky = { "#buffer" },
      resource_processing = true,
      show_help = false,
      insert_at_end = false,
      headers = {
        user = " User  ",
        assistant = " Copilot  ",
        tool = "󱁤 Tool",
      },
      window = {
        layout = "vertical",
        width = 0.3,
      },
    },
    keys = {
      {
        "<leader>cc",
        "<cmd>CopilotChatToggle<cr>",
        desc = "ChatGPT",
      },
      {
        "<leader>cp",
        "<cmd>CopilotChatBufferPrompt<cr>",
        desc = "ChatGPT Prompt",
      },
    },
    config = function(_, opts)
      local chat = require("CopilotChat")
      local select = require("CopilotChat.select")
      chat.setup(opts)

      -- Disable line numbers and relative numbers in CopilotChat window
      -- vim.api.nvim_create_autocmd({ "FileType", "WinEnter" }, {
      --   pattern = "copilot-chat",
      --   callback = function()
      --     vim.opt_local.number = false
      --     vim.opt_local.relativenumber = false
      --     vim.opt_local.signcolumn = "no"
      --     vim.opt_local.foldcolumn = "0"
      --   end,
      -- })

      vim.api.nvim_create_user_command("CopilotChatBufferPrompt", function()
        chat.select_prompt({ selection = select.buffer })
      end, {})
    end,
  },
}
