--- Module containing functions related to HydraVim configurations.
-- @module hydra_config

local M = {}

-- Counts the number of arguments passed to Neovim.
-- @return number The number of arguments passed.
function M.count_args()
  return #vim.fn.argv()
end

--- Duplicate the current line and place it above or below.
-- @param direction The direction to place the duplicated line ("up" or "down").
function M.duplicate_line(direction)
  local new_line = vim.fn.getline "."

  if direction == "up" then
    vim.fn.append(vim.fn.line "." - 1, new_line)
  elseif direction == "down" then
    vim.fn.append(vim.fn.line ".", new_line)
  else
    error "Invalid direction argument. Use 'up' or 'down'"
  end
end

--- Converts a numeric highlight level value to a string compatible with `vim.api.nvim_echo`.
-- @param level The numeric value of the highlight level.
-- @return The string corresponding to the highlight level, or "info" if the value is invalid.
function M.log_level_str(level)
  local levels = {
    [vim.log.levels.DEBUG] = "Debug",
    [vim.log.levels.INFO] = "Info",
    [vim.log.levels.WARN] = "WarningMsg",
    [vim.log.levels.ERROR] = "Error",
  }
  return levels[level] or "Normal"
end

--- Displays a message in Vim.
-- @param message The text of the message to be displayed.
-- @param highlight (optional) The highlight group to be used for the message. Default is "Normal".
-- @param redraw (optional) Forces a redraw before displaying the message. Default is false.
function M.echo(message, highlight, redraw)
  if redraw then
    vim.cmd "redraw"
  end
  vim.api.nvim_echo({ { message, highlight or "Normal" } }, true, {})
end

--- Displays a notification in Vim.
-- @param message The text of the notification to be displayed.
-- @param level (optional) The level of the notification. Default is `vim.log.levels.INFO`.
-- @param options (optional) Additional options for the notification.
function M.notify(message, level, options)
  local ok, notify = pcall(require, "notify")

  if ok then
    local async = require "plenary.async"
    async.run(function()
      notify.async(message, level or vim.log.levels.INFO, options or { title = "HydraVim" })
    end)
  else
    M.echo(message, M.log_level_str(level), true)
  end
end

--- Generates the user config.
-- Checks if the user configuration already exists. If it doesn't exist, clones the
-- HydraVim configuration template repository and installs it.
-- @param remote (optional) Remote of the repository to clone from.
-- @param branch (optional) Branch to clone from.
function M.install_user_config(remote, branch)
  local user_path = vim.g.hydravim.dirs.user

  if not vim.loop.fs_stat(user_path) then
    M.notify " Installing user configuration template..."
    local repo = "https://github.com/" .. remote .. ".git"

    local clone_command = { "git", "clone", "--filter=blob:none", "--depth=1", repo, user_path }

    if branch then
      table.insert(clone_command, "--branch=" .. branch)
    end

    vim.fn.system(clone_command)

    if vim.v.shell_error ~= 0 then
      M.notify("Error to install config: " .. repo)
    else
      vim.fn.delete(user_path .. "/.git", "rf")
      M.notify("Completed. Check HydraVim Wiki. Directory: " .. user_path)
    end
  else
    local answer = vim.fn.input "A user configuration already exists. Delete and install a new one? [y/N]: "
    if answer:lower() == "y" then
      vim.fn.delete(user_path, "rf")
      M.install_user_config(remote, branch)
    else
      M.notify("Config available at: " .. user_path)
    end
  end
end

--- Get information about available Null-ls sources for a given file type.
-- @param ft (string) The file type for which sources are needed.
-- @return (table) A table containing information about available sources; names and supported methods.
function M.null_ls_sources(ft)
  local available = require("null-ls.sources").get_available(ft)
  local sources = {}

  for _, source in pairs(available) do
    table.insert(sources, { name = source.name, methods = source.methods })
  end

  return sources
end

--- Get the names of Null-ls sources that support code formatting for a given file type.
-- @param ft (string) The file type for which formatters are needed.
-- @return (table) A table containing the names of Null-ls sources that support code formatting.
function M.null_ls_formatters(ft)
  local formatters = {}

  for _, source in pairs(M.null_ls_sources(ft)) do
    if source.methods.NULL_LS_FORMATTING then
      table.insert(formatters, source.name)
    end
  end

  return formatters
end

--- Get the names of Null-ls sources that support code linting for a given file type.
-- @param ft (string) The file type for which linters are needed.
-- @return (table) A table containing the names of Null-ls sources that support code linting.
function M.null_ls_linters(ft)
  local linters = {}

  for _, source in pairs(M.null_ls_sources(ft)) do
    if source.methods.NULL_LS_DIAGNOSTICS then
      table.insert(linters, source.name)
    end
  end

  return linters
end

--- Gets the active LSP (Language Server Protocol) name for the current filetype.
-- @return (string) The name of the LSP or an empty string if no LSP is active for the filetype.
function M.get_lsp_clients()
  local ft = vim.bo.filetype
  local client_names = {}

  for _, client in ipairs(vim.lsp.get_active_clients()) do
    if client.config.filetypes and vim.fn.index(client.config.filetypes, ft) ~= -1 then
      if client.name ~= "null-ls" then
        table.insert(client_names, client.name)
      end
    end
  end

  vim.list_extend(client_names, M.null_ls_formatters(ft))
  vim.list_extend(client_names, M.null_ls_linters(ft))

  client_names = vim.fn.uniq(client_names)

  return #client_names > 0 and " " .. table.concat(client_names, ", ") or ""
end

--- Reads the contents of a file.
-- @param path The path to the file to be read.
-- @param mode The file opening mode (e.g., "r" for reading).
-- @return The contents of the file as a string, or nil on error.
function M.read_file(path, mode)
  local f = assert(io.open(path, mode or "r"))
  local c = f:read "*a"
  f:close()
  return c
end

--- Writes contents to a file.
-- @param file The path to the file to be written.
-- @param contents The string to be written to the file.
-- @param mode The file opening mode (e.g., "w" for writing).
function M.write_file(path, contents, mode)
  local f = assert(io.open(path, mode or "w+"))
  f:write(contents)
  f:close()
end

--- Generates the lockfile for plugins.
-- This function generates a lockfile containing information about the plugins and their versions/commits.
M.generate_lockfile = function()
  local locklua_path = vim.fn.stdpath "config" .. "/lua/hydravim/core/lockfile.lua"
  local lockjson_path = vim.fn.stdpath "data" .. "/hydravim/lazy/lazy-lock.json"

  M.write_file(locklua_path, "return {}")
  vim.fn.system 'nvim --headless "+Lazy! sync" +qa'

  local lockjson = vim.fn.json_decode(M.read_file(lockjson_path))

  local sorted_keys = {}
  for plugin, _ in pairs(lockjson) do
    table.insert(sorted_keys, plugin)
  end
  table.sort(sorted_keys)

  local locklua = {}
  for _, plugin in ipairs(sorted_keys) do
    local value = lockjson[plugin]
    table.insert(locklua, { plugin, branch = value.branch, commit = value.commit })
  end

  M.write_file(locklua_path, "return " .. vim.inspect(locklua))
  M.notify("Successfully updated lockfile: " .. locklua_path)
end

return M
