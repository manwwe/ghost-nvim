-- Integration tests against the installed plugins; no downloads or server processes.
local root = assert(vim.env.GHOST_TEST_ROOT)
local scratch = assert(vim.env.GHOST_TEST_TMP)
-- Write directly so UI plugins cannot capture test results as notifications.
local function print(message)
  io.stdout:write(tostring(message), "\n")
  io.stdout:flush()
end
local failures, passed = {}, 0
local function test(name, fn)
  local ok, err = xpcall(fn, debug.traceback)
  if ok then
    passed = passed + 1
    print("PASS " .. name)
  else
    failures[#failures + 1] = name .. ": " .. err
    print("FAIL " .. name .. ": " .. err)
  end
end

local maps = {}
local original_set = vim.keymap.set
vim.keymap.set = function(mode, lhs, rhs, opts)
  local source = debug.getinfo(2, "Sl")
  if source.source:find(root, 1, true) then
    maps[#maps + 1] = {
      mode = mode, lhs = lhs, opts = vim.deepcopy(opts or {}),
      source = source.short_src .. ":" .. source.currentline,
    }
  end
  return original_set(mode, lhs, rhs, opts)
end

local function canonical(lhs)
  lhs = lhs:gsub("<[Ll][Ee][Aa][Dd][Ee][Rr]>", function() return vim.g.mapleader or "\\" end)
  lhs = lhs:gsub("<[Ll][Oo][Cc][Aa][Ll][Ll][Ee][Aa][Dd][Ee][Rr]>", function() return vim.g.maplocalleader or "\\" end)
  lhs = lhs:gsub("<[Ss]%-([%a])>", function(key) return key:upper() end)
  return vim.api.nvim_replace_termcodes(lhs, true, true, true)
end
local function conflicts(records)
  local seen, errors = {}, {}
  for _, record in ipairs(records) do
    local modes = type(record.mode) == "table" and record.mode or { record.mode }
    for _, mode in ipairs(modes) do
      local expanded = mode == "v" and { "x", "s" } or { mode }
      for _, effective in ipairs(expanded) do
        local key = effective .. ":" .. canonical(record.lhs)
        local scope = record.opts.buffer
        scope = (scope == true or scope == 0) and vim.api.nvim_get_current_buf() or scope
        for _, previous in ipairs(seen[key] or {}) do
          if not scope or not previous.scope or scope == previous.scope then
            errors[#errors + 1] = effective .. " " .. record.lhs .. ": " .. previous.source .. " vs " .. record.source
          end
        end
        seen[key] = seen[key] or {}
        seen[key][#seen[key] + 1] = { scope = scope, source = record.source }
      end
    end
  end
  return errors
end

local startup_errors, requested_servers = {}, {}
local original_notify = vim.notify
vim.notify = function(msg, level, opts)
  if level == vim.log.levels.ERROR then startup_errors[#startup_errors + 1] = tostring(msg) end
  return original_notify(msg, level, opts)
end

local booted = false
test("configuration starts with installed plugins", function()
  vim.opt.rtp:prepend(root)
  local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  assert(vim.fn.isdirectory(lazy_path) == 1, "Install plugins by opening Neovim before running tests")
  vim.opt.rtp:prepend(lazy_path)
  vim.go.loadplugins = true -- -l disables plugin loading by default.
  local lazy = require("lazy")
  local setup = lazy.setup
  lazy.setup = function(opts)
    opts.install = { missing = false }
    opts.checker = { enabled = false }
    opts.change_detection = { enabled = false }
    opts.lockfile = scratch .. "/lazy-lock.json"
    -- Keep parser installation and Mason registry/network activity out of tests.
    opts.spec[#opts.spec + 1] = {
      "mason-org/mason-lspconfig.nvim",
      opts = function(_, merged)
        requested_servers = vim.deepcopy(merged.ensure_installed)
        merged.ensure_installed = {}
        merged.automatic_enable = false
      end,
    }
    local ok, err = pcall(setup, opts)
    lazy.setup = setup
    assert(ok, err)
  end
  package.loaded["nvim-treesitter"] = { install = function() end }
  dofile(root .. "/init.lua")
  vim.wait(50)
  assert(#startup_errors == 0, table.concat(startup_errors, "\n"))
  assert(vim.v.errmsg == "", vim.v.errmsg)
  booted = true
end)

if booted then
  local config = require("lazy.core.config")
  local function opts(name)
    assert(config.plugins[name], "Missing plugin: " .. name)
    return require("lazy.core.plugin").values(config.plugins[name], "opts", false)
  end

  test("language specs preserve servers, parsers, and formatters", function()
    for _, name in ipairs({ "lua_ls", "pyright", "ruff", "rust_analyzer", "clangd", "ts_ls", "terraformls", "eslint" }) do
      assert(vim.tbl_contains(requested_servers, name), "Missing server " .. name)
      assert(vim.lsp.config[name], "Missing config " .. name)
    end
    local parsers = opts("nvim-treesitter").parsers
    for _, name in ipairs({ "lua", "python", "c", "cpp", "rust", "typescript", "bash" }) do
      assert(vim.tbl_contains(parsers, name), "Missing parser " .. name)
    end
    local ft = opts("conform.nvim").formatters_by_ft
    assert(ft.lua[1] == "stylua" and ft.cpp[1] == "clang-format" and ft.sh[1] == "shfmt")
  end)

  test("Prettier formats web files and ESLint supplies linting", function()
    local ft = opts("conform.nvim").formatters_by_ft
    for _, name in ipairs({ "javascript", "typescript", "json", "markdown", "yaml", "html", "css" }) do
      assert(ft[name][1] == "prettier", "Missing Prettier for " .. name)
    end
    assert(opts("nvim-lspconfig").servers.eslint.settings.format == false)
  end)

  test("Rust uses Clippy and shell scripts lint after saving", function()
    assert(opts("nvim-lspconfig").servers.rust_analyzer.settings["rust-analyzer"].check.command == "clippy")
    require("lazy").load({ plugins = { "nvim-lint" } })
    local lint = require("lint")
    assert(lint.linters_by_ft.sh[1] == "shellcheck")
    assert(not lint.linters_by_ft.python and not lint.linters_by_ft.cpp and not lint.linters_by_ft.rust)
    -- Exercise the save trigger without requiring an external executable in the suite.
    local original = lint.try_lint
    local called = false
    lint.try_lint = function() called = true end
    vim.api.nvim_exec_autocmds("BufWritePost", { group = "ghost_lint", buffer = 0 })
    lint.try_lint = original
    assert(called, "Saving should trigger linting")
  end)

  test("Copilot stays off until explicitly enabled", function()
    assert(vim.g.copilot_enabled == false)
    assert(not package.loaded["copilot"], "Copilot must not start at launch")
    local copilot = opts("copilot.lua")
    assert(not copilot.suggestion.enabled and not copilot.panel.enabled)
    local provider = opts("blink.cmp").sources.providers.copilot
    assert(provider.module == "blink-copilot" and not provider.enabled())
    assert(not copilot.should_attach(0), "Disabled Copilot must not attach")
    local toggle = require("snacks").toggle.get("copilot")
    assert(toggle and not toggle:get())
  end)

  test("completion requires explicit selection", function()
    local c = require("blink.cmp.config")
    assert(not c.completion.list.selection.preselect({}))
    assert(not c.completion.list.selection.auto_insert({}))
    assert(c.keymap["<Tab>"][1] == "accept" and c.keymap["<CR>"][1] == "accept")
  end)

  test("mini.diff loads before its overlay shortcut is invoked", function()
    assert(config.plugins["mini.diff"].lazy == false, "Key-only loading races buffer attachment")
    assert(package.loaded["mini.diff"], "mini.diff must already be initialized at startup")
  end)

  test("diagnostics retain inline messages and severity icons", function()
    local diagnostics = vim.diagnostic.config()
    assert(diagnostics.underline and diagnostics.severity_sort)
    assert(diagnostics.update_in_insert == false)
    assert(diagnostics.virtual_text.spacing == 4)
    for _, severity in pairs(vim.diagnostic.severity) do
      if type(severity) == "number" then
        assert(type(diagnostics.signs.text[severity]) == "string")
      end
    end
  end)

  test("LSP attach registers local shortcuts and preserves clangd hint preference", function()
    local get_client = vim.lsp.get_client_by_id
    local client = { server_capabilities = { inlayHintProvider = true } }
    vim.lsp.config.clangd.on_init(client)
    assert(client.server_capabilities.inlayHintProvider == false)
    function client:supports_method() return false end
    vim.lsp.get_client_by_id = function() return client end
    local ok, err = pcall(vim.api.nvim_exec_autocmds, "LspAttach", {
      buffer = 0, group = "ghost_lsp", data = { client_id = 12345 },
    })
    vim.lsp.get_client_by_id = get_client
    assert(ok, err)
    local mapping = vim.fn.maparg("<C-k>", "i", false, true)
    assert(mapping.buffer == 1 and mapping.callback == vim.lsp.buf.signature_help)
    assert(vim.fn.maparg("gd", "n", false, true).buffer == 1)
  end)

  test("conflict detector catches aliases and overlapping scopes", function()
    local function rec(mode, lhs, buffer)
      return { mode = mode, lhs = lhs, opts = { buffer = buffer }, source = "fixture" }
    end
    assert(#conflicts({ rec("n", "H"), rec("n", "<S-h>") }) == 1)
    assert(#conflicts({ rec("v", "p"), rec("x", "p", 1) }) == 1)
    assert(#conflicts({ rec("n", "<leader>w"), rec("n", "<Space>w") }) == 1)
    assert(#conflicts({ rec("n", "q", 1), rec("n", "q", 2) }) == 0)
    assert(#conflicts({ rec("n", "q"), rec("i", "q") }) == 0)
  end)

  test("user keymaps have no conflicting registrations", function()
    local records = vim.deepcopy(maps)
    -- Include declarative plugin keys, which lazy.nvim registers via lower-level APIs.
    for name, plugin in pairs(config.plugins) do
      local keys = require("lazy.core.plugin").values(plugin, "keys", true)
      for _, key in ipairs(keys or {}) do
        if type(key) == "table" and key[2] ~= false then
          records[#records + 1] = {
            mode = key.mode or "n", lhs = key[1], opts = {}, source = name .. " keys",
          }
        end
      end
    end
    -- Explicit Blink overrides share insert/select mode with user mappings.
    for lhs in pairs(opts("blink.cmp").keymap or {}) do
      if lhs ~= "preset" then
        records[#records + 1] = { mode = { "i", "s" }, lhs = lhs, opts = {}, source = "Blink override" }
      end
    end
    local errors = conflicts(records)
    assert(#errors == 0, table.concat(errors, "\n"))
  end)

  test("saving creates missing parent directories", function()
    vim.cmd.enew()
    vim.api.nvim_buf_set_name(0, scratch .. "/nested/deep/sample.txt")
    vim.api.nvim_buf_set_lines(0, 0, -1, false, { "test" })
    vim.cmd.write()
    assert(vim.fn.filereadable(scratch .. "/nested/deep/sample.txt") == 1)
  end)
end

vim.keymap.set = original_set
vim.notify = original_notify
print(string.format("\n%d passed, %d failed", passed, #failures))
if #failures > 0 then vim.cmd("cquit 1") else vim.cmd("qa!") end
