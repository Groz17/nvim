# AGENTS.md for Neovim Configuration

## Build/Lint/Test Commands

- **Formatting**: Use `stylua` for Lua files: `stylua --config-path stylua.toml file.lua`.

## Code Style Guidelines

- **Formatting**: 2 spaces indentation, 80 column width, prefer single quotes (stylua.toml).
- **Imports**: Use `require()` for Lua modules, e.g., `local config = require('config.autocmds')`.
- **Naming**: Snake_case for variables/functions, PascalCase for modules/types.
- **Types**: Use Lua type annotations: `---@type string`, `---@param name string`.
- **Error Handling**: Use `pcall()` for unsafe calls, `vim.notify()` for messages.
- **Conventions**: Follow Neovim Lua API patterns; use `vim.api` for core functions.
