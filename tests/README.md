# Configuration tests

GitHub Actions runs this suite on pushes to `main`. It can also be started
manually from the Actions tab. The Linux job installs Neovim 0.12.6 and plugin
sources with `tests/install.lua` before running `tests/run.sh`.

The CI installer skips plugin callbacks and build hooks. No Copilot credentials,
language toolchains, or parser builds are needed for these configuration checks.
It follows the plugin versions declared in the configuration, so upstream plugin
changes can affect subsequent runs. It does not test macOS UI behavior or the
machine-specific C/C++ runners.

Run from the repository:

```sh
./tests/run.sh
```

Requires Neovim 0.12+ and the plugins already installed by lazy.nvim. Open the
configuration normally and finish plugin installation before the first test run.
No additional test framework is needed.

The runner loads this checkout's `init.lua` with the installed plugins. It uses
temporary cache/state directories and a temporary lockfile, disables Lazy's
installation/update checks, skips parser installation, and disables Mason's server
installation and automatic activation. It does not launch language servers or
change project files. Temporary files are removed after the run. Failures return
a nonzero exit status.

Checks cover startup, merged language settings, completion selection, diagnostic
display, LSP attachment callbacks, missing-directory creation, and keymap conflicts.
The LSP callback test uses a simulated client; it does not test server binaries.

## Keymap conflicts

The audit records mappings registered by this checkout's Lua code and includes
plugin `keys` declarations and explicit Blink overrides. It compares modes,
expanded leader keys, Shift-letter aliases, and overlapping global/buffer scopes.
Visual mode is expanded into visual and select modes. Detector fixtures verify
that real conflicts fail while separate modes and unrelated buffers are allowed.

Built-in mappings, third-party plugin defaults/presets, prefix overlaps (such as
Space and Space+w), and callbacks not exercised by the suite are outside the
audit. Intentional user overrides of built-in/plugin defaults are not errors.
Add callback coverage when introducing mappings in new event handlers.
