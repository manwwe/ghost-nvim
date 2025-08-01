-- Lazy.nvim configuration for ChatGPT.nvim with Telescope (readable, no scratch buffers)
return {
  "jackMort/ChatGPT.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim", -- optional
    "nvim-telescope/telescope.nvim",
  },
  event = "VeryLazy",
  config = function()
    -- imports
    local chatgpt = require("chatgpt")
    local telescope = require("telescope.builtin")
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local map = vim.keymap.set

    -- initialize plugin
    chatgpt.setup()

    -- Edit the current buffer with instructions
    map("n", "<leader>oe", function()
      chatgpt.edit_with_instructions()
    end, { desc = "ChatGPT: edit current buffer" })

    -- Select a file via Telescope and edit it
    map("n", "<leader>of", function()
      telescope.find_files({
        prompt_title = "ChatGPT: select a file",
        attach_mappings = function(_, _)
          actions.select_default:replace(function(prompt_bufnr)
            actions.close(prompt_bufnr)
            local entry = action_state.get_selected_entry()
            local path = entry.path or entry.value
            vim.cmd("edit " .. vim.fn.fnameescape(path))
            chatgpt.edit_with_instructions()
          end)
          return true
        end,
      })
    end, { desc = "ChatGPT: edit selected file" })

    -- Select a buffer via Telescope and edit it
    map("n", "<leader>ob", function()
      telescope.buffers({
        prompt_title = "ChatGPT: select a buffer",
        attach_mappings = function(_, _)
          actions.select_default:replace(function(prompt_bufnr)
            actions.close(prompt_bufnr)
            local bufnr = action_state.get_selected_entry().bufnr
            vim.cmd("buffer " .. bufnr)
            chatgpt.edit_with_instructions()
          end)
          return true
        end,
      })
    end, { desc = "ChatGPT: edit selected buffer" })
  end,
}
