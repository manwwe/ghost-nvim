-- Lualine component for Docker status.
-- Checks Docker daemon/socket accessibility and shows an icon.

local M = {}

-- Checks if Docker service is running/accessible.
-- Looks for Docker socket (Unix) or named pipe (Windows).
function M.is_running()
  local is_win = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
  local path = is_win and [[\\.\pipe\docker_engine]] or "/var/run/docker.sock"
  local st = vim.loop.fs_stat(path) -- Get filesystem stats.
  return st and (is_win or st.type == "socket")
end

-- Returns Docker icon; color indicates status.
function M.component()
  return M.is_running() and "" or " " -- Nerd Font Docker icon.
end

-- Dynamically sets color based on Docker status.
function M.color()
  if M.is_running() then
    return { fg = "#0D4715", gui = "bold" } -- Dark green if running.
  else
    return { fg = "#85193C", gui = "bold" } -- Dark red if not running.
  end
end

return {
  M.component, -- Function for Lualine to get component text.
  -- color = M.color, -- Callback for dynamic color.
}
