-- Lualine component to display current operating system with icon.
-- Uses libuv for OS info and Nerd Font icons.

local M = {}

-- Returns OS name with icon.
function M.status()
  local sys = vim.loop.os_uname().sysname -- Get OS name (e.g., "Linux", "Darwin").

  if sys == 'Linux' then
    return ' Linux' -- Tux icon.
  elseif sys == 'Darwin' then
    return ' macOS' -- Apple icon.
  elseif sys:match 'Windows' then
    return ' Windows' -- Windows icon.
  else
    return ' Unknown' -- Fallback icon.
  end
end

return M -- Lualine will call M.status.
