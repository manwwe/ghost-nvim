-- Lualine component for file scroll progress (percentage and graphical bar).

local function progress()
  local cur = vim.fn.line(".") -- Current line.
  local total = vim.fn.line("$") -- Total lines.

  if total == 0 then
    return ""
  end -- Avoid division by zero.

  -- Display "Top 0%" or "Bot 100%" at file ends. '%%' escapes '%'.
  if cur == 1 then
    return "Top 0%%"
  end
  if cur == total then
    return "Bot 100%%"
  end

  local icons = { " ", "▂", "▃", "▄", "▅", "▆", "█" } -- Unicode block characters for bar.
  local width_factor = 3 -- Width of the graphical bar.

  local ratio = cur / total
  local pct = math.floor(ratio * 100 + 0.5) -- Rounded percentage.

  -- Map ratio to icon index, clamped to [1, #icons].
  local idx = math.min(math.max(math.ceil(ratio * #icons), 1), #icons)
  local bar = string.rep(icons[idx], width_factor) -- Graphical bar.

  return bar .. " " .. pct .. "%%" -- Bar + percentage.
end

return progress -- Lualine uses this function as the component.
