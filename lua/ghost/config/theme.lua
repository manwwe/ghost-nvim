-- Theme selection, persistence, and interactive switching.

local M = {}

local default_theme = "catppuccin"
local available_themes = {
  "catppuccin",
  "gruvbox",
  "tokyonight",
  "kanagawa",
  "vague",
  "everforest",
}

local state_file = vim.fn.stdpath "state" .. "/ghost-theme.txt"

local function list_themes()
  return available_themes
end

local function is_valid(name)
  return vim.tbl_contains(list_themes(), name)
end

local function read_saved()
  local ok, lines = pcall(vim.fn.readfile, state_file)

  if not ok or not lines or lines[1] == nil then
    return nil
  end

  local name = vim.trim(lines[1])

  if name == "" then
    return nil
  end

  return name
end

local function write_saved(name)
  pcall(vim.fn.writefile, { name }, state_file)
end

local function load_theme_plugin(name)
  local ok, lazy = pcall(require, "lazy")

  if not ok then
    return
  end

  lazy.load({ plugins = { name } })
end

function M.current()
  local saved = read_saved()

  if saved and is_valid(saved) then
    return saved
  end

  return default_theme
end

function M.apply(name, opts)
  opts = opts or {}

  local theme = name or M.current()

  if not is_valid(theme) then
    vim.notify("Unknown theme: " .. theme, vim.log.levels.WARN)
    return false
  end

  load_theme_plugin(theme)

  local ok, err = pcall(vim.cmd.colorscheme, theme)

  if not ok then
    vim.notify("Failed to load theme '" .. theme .. "': " .. err, vim.log.levels.ERROR)
    return false
  end

  if opts.persist ~= false then
    write_saved(theme)
  end

  if opts.notify then
    vim.notify("Theme changed to " .. theme, vim.log.levels.INFO)
  end

  return true
end

function M.pick()
  vim.ui.select(list_themes(), {
    prompt = "Select theme",
    format_item = function(item)
      if item == M.current() then
        return item .. " (current)"
      end

      return item
    end,
  }, function(choice)
    if choice then
      M.apply(choice, { notify = true })
    end
  end)
end

function M.complete()
  return list_themes()
end

function M.setup()
  if M._did_setup then
    return
  end

  M._did_setup = true

  vim.api.nvim_create_user_command("Theme", function(opts)
    if opts.args == "" then
      M.pick()
      return
    end

    M.apply(opts.args, { notify = true })
  end, {
    nargs = "?",
    complete = function()
      return M.complete()
    end,
    desc = "Switch colorscheme",
  })
end

return M
