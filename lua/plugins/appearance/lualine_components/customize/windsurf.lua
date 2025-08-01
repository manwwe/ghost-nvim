-- Lualine component for Codeium (windsurf.nvim) status.
-- Shows icon indicating if Codeium completion source is available via nvim-cmp.
local M = {}

-- Checks if Codeium nvim-cmp source is available.
local function is_codeium_available()
  local ok, cmp = pcall(require, "cmp") -- Safely load nvim-cmp.
  if not ok then
    return false
  end
  for _, source in ipairs(cmp.core.sources) do
    if source.name == "codeium" and source:is_available() then
      return true -- Codeium source found and available.
    end
  end
  return false
end

-- Returns icon based on Codeium availability with padding.
function M.component()
  local icon = is_codeium_available() and "" or "󱜟" -- Nerd Font icons: AI-related / disconnected.
  return icon .. " " -- Add padding (space) on both sides
end

-- Dynamically sets color based on Codeium status.
function M.color()
  if is_codeium_available() then
    return { fg = "#abb2bf", gui = "bold" } -- Light color if available.
  else
    return { fg = "#85193C", gui = "bold" } -- Dark red if not available.
  end
end

return {
  M.component, -- Function for Lualine to get component text/icon.
  color = M.color, -- Function for dynamic color.
}
