-- Configures CopilotChat.nvim plugin for interactive chat with GitHub Copilot.

-- Pre-defined prompts for common tasks.
local prompts = {
  SmartCommit = 'Generate a concise commit message using Conventional Commits. Only use staged/unstaged git changes as context. Respond in plain text only (no markdown).',
  BetterNames = 'Suggest clearer and more meaningful names for the variables and functions in the selected code. Return only the improved names as suggestions.',
  AddLogging = 'Insert logging or debugging statements into the selected code to help trace execution or capture errors. Use conventions appropriate for the language.',
  TypeHints = 'Analyze the selected code and add or suggest type annotations if the language supports them. Improve clarity without changing behavior.',
  ComplexityReport = 'Analyze the cyclomatic complexity and structure of the selected code. Identify any overly complex sections and suggest simplifications.',
  SecurityReview = 'Perform a security review of the selected code. Highlight any risky patterns or missing validations and suggest improvements.',
  RefactorToFunction = 'Refactor the selected block of code into a well-named reusable function or method. Maintain the same behavior and include documentation.',
  Pseudocode = 'Convert the selected code into clear and concise pseudocode that describes what the code is doing in plain language, step by step.',
  TranslateToEnglish = 'Explain what the selected code does in plain English. Assume the reader is familiar with programming basics but not this specific language.',
  RegexExplain = 'Explain what this regular expression does, including the meaning of each part. Return only the explanation in natural language.',
}

-- Plugin specification for lazy.nvim.
return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
    },
    opts = {
      question_header = ' Me ',
      answer_header = ' Copilot ',
      error_header = ' Error ',
      model = 'gpt-4o',
      prompts = prompts,
      window = {
        layout = 'float',
        border = 'rounded',
        title = 'Copilot Chat  ',
        width = 0.75,
        height = 0.75,
      },
    },
    cmd = {
      'CopilotChatCommitSmart',
      'CopilotChatVisualPrompt',
      'CopilotChatBufferPrompt',
      'CopilotChatReset',
      'CopilotChatModels',
      'CopilotChatAgents',
    },
    config = function(_, opts)
      local chat = require 'CopilotChat'
      chat.setup(opts)

      local select = require 'CopilotChat.select'

      -- Command for generating smart commit messages.
      vim.api.nvim_create_user_command('CopilotChatCommitSmart', function()
        chat.ask(prompts.SmartCommit, {
          context = { 'git:staged', 'git:unstaged' },
        })
      end, {})

      -- Command for prompting with visual selection.
      vim.api.nvim_create_user_command('CopilotChatVisualPrompt', function()
        chat.select_prompt {
          context = { 'visual' },
        }
      end, { nargs = '*', range = true })

      -- Command for prompting with the entire buffer content.
      vim.api.nvim_create_user_command('CopilotChatBufferPrompt', function()
        chat.select_prompt {
          selection = select.buffer,
        }
      end, {})

      -- Configure Copilot Chat buffers.
      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = 'copilot-*',
        callback = function()
          vim.opt_local.relativenumber = true
          vim.opt_local.number = true
          if vim.bo.filetype == 'copilot-chat' then
            vim.bo.filetype = 'markdown'
            vim.opt_local.conceallevel = 2
            vim.opt_local.concealcursor = 'nc'
          end
        end,
      })
    end,

    keys = {
      {
        '<leader>ac',
        '<cmd>CopilotChatCommitSmart<cr>',
        desc = 'CopilotChat - Smart Commit message', -- Generate a commit message based on Git changes.
      },
      {
        '<leader>av',
        ':CopilotChatVisualPrompt<cr>',
        mode = 'x',
        desc = 'CopilotChat - Select prompt for visual selection', -- Use a prompt for the selected visual code.
      },
      {
        '<leader>ab',
        ':CopilotChatBufferPrompt<cr>',
        mode = 'n',
        desc = 'CopilotChat - Select prompt for entire buffer', -- Use a prompt for the entire buffer content.
      },
      {
        '<leader>al',
        '<cmd>CopilotChatReset<cr>',
        desc = 'CopilotChat - Clear buffer and chat history', -- Reset the chat buffer and history.
      },
      {
        '<leader>a?',
        '<cmd>CopilotChatModels<cr>',
        desc = 'CopilotChat - Select Models', -- Open a menu to select AI models.
      },
      {
        '<leader>aa',
        '<cmd>CopilotChatAgents<cr>',
        desc = 'CopilotChat - Select Agents', -- Open a menu to select AI agents.
      },
      {
        '<leader>ao',
        '<cmd>CopilotChat<cr>',
        desc = 'CopilotChat - Open chat window', -- Open the Copilot chat window.
      },
      {
        '<leader>ai',
        function()
          local input = vim.fn.input 'Ask Copilot   (visual): '
          if input ~= '' then
            require('CopilotChat').ask(input, {
              context = { 'visual' },
            })
          end
        end,
        mode = 'x',
        desc = 'CopilotChat - Ask with manual prompt (visual)', -- Ask a custom question using visual selection.
      },
      {
        '<leader>ai',
        function()
          local input = vim.fn.input 'Ask Copilot   (buffer): '
          if input ~= '' then
            require('CopilotChat').ask(input, {
              context = { 'buffer' },
            })
          end
        end,
        mode = 'n',
        desc = 'CopilotChat - Ask with manual prompt (buffer)', -- Ask a custom question using the entire buffer.
      },
      {
        '<leader>aB',
        function()
          local input = vim.fn.input 'Ask Copilot   (buffers): '
          if input ~= '' then
            require('CopilotChat').ask(input, {
              context = { 'buffers' },
            })
          end
        end,
        mode = 'n',
        desc = 'CopilotChat - Ask with manual prompt (buffers)', -- Ask a custom question using all open buffers.
      },
      {
        '<leader>aB',
        function()
          local input = vim.fn.input 'Ask Copilot   (buffers): '
          if input ~= '' then
            require('CopilotChat').ask(input, {
              context = { 'buffers' },
            })
          end
        end,
        mode = 'v',
        desc = 'CopilotChat - Ask with manual prompt (buffers)', -- Ask a custom question using selected buffers.
      },
    },
  },
}
