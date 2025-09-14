-- Description: Custom commands for Neovim
-- -- This file defines custom commands for Neovim, such as creating scratch buffers,
vim.api.nvim_create_user_command('CleanScratch', function()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_name(buf) == '[Scratch]' then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end, { desc = 'Cerrar todos los buffers [Scratch]' })

vim.api.nvim_create_augroup('ScratchCleanup', { clear = true })
vim.api.nvim_create_autocmd('BufLeave', {
  group = 'ScratchCleanup',
  callback = function()
    if vim.api.nvim_buf_get_name(0) == '[Scratch]' then
      vim.cmd 'silent! bdelete!' -- cierra el buffer actual
    end
  end,
})

vim.api.nvim_create_autocmd('VimLeavePre', {
  callback = function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(buf) then
        local buftype = vim.api.nvim_buf_get_option(buf, 'buftype')
        if buftype == 'nofile' then
          vim.api.nvim_buf_delete(buf, { force = true })
        end
      end
    end
  end,
})
