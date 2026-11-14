return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = { ensure_installed = { "rust_analyzer" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local default_root_dir = vim.lsp.config.rust_analyzer.root_dir
      local default_before_init = vim.lsp.config.rust_analyzer.before_init
      opts.servers.rust_analyzer = {
        root_dir = function(bufnr, on_dir)
          local file = vim.api.nvim_buf_get_name(bufnr)
          if vim.fs.root(file, { "Cargo.toml", "rust-project.json" }) then
            default_root_dir(bufnr, on_dir)
          else
            -- Independent exercises need a crate model even inside a Git repo.
            on_dir(vim.fs.dirname(file))
          end
        end,
        before_init = function(params, config)
          local settings = config.settings["rust-analyzer"]
          if not vim.fs.root(config.root_dir, { "Cargo.toml", "rust-project.json" }) and not settings.linkedProjects then
            local result = vim
              .system({ "rustc", "--print", "sysroot" }, {
                cwd = config.root_dir,
                text = true,
              })
              :wait()
            if result.code == 0 then
              local crates = {}
              for _, file in ipairs(vim.fn.glob(config.root_dir .. "/*.rs", false, true)) do
                crates[#crates + 1] = { root_module = file, edition = "2021", deps = {} }
              end
              local sysroot = vim.trim(result.stdout)
              settings.linkedProjects = {
                {
                  sysroot = sysroot,
                  sysroot_src = sysroot .. "/lib/rustlib/src/rust/library",
                  crates = crates,
                },
              }
            end
          end
          default_before_init(params, config)
        end,
        settings = {
          ["rust-analyzer"] = {
            check = { command = "clippy" },
          },
        },
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { parsers = { "rust" } },
  },
}
