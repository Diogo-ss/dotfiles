--- Module containing functions related to session management.
-- @module session_utils

local M = {}
local api = require "hydravim.core.utils.api"

-- Get the session file path.
-- @return The full path to the session file.
local function get_session_file()
  local current_dir = vim.fs.normalize(vim.fn.getcwd())
  local session_dir = vim.fs.normalize(vim.g.hydravim.dirs.data .. "/session")
  local session_file = session_dir .. "/" .. current_dir:gsub("/", "%%") .. ".vim"
  return session_file
end

-- Save the current session to a file.
-- @param file_dir (Optional) The custom file path of the session file.
function M.save_session(file_dir)
  local session_file = file_dir or get_session_file()

  vim.fn.mkdir(vim.fn.fnamemodify(session_file, ":h"), "p")
  vim.cmd("silent mksession! " .. vim.fn.fnameescape(session_file))

  api.notify("Saved Session", vim.log.levels.INFO, { title = "Session" })
end

-- Load a previously saved session.
-- @param file_dir (Optional) The custom file path of the session file.
function M.load_session(file_dir)
  local session_file = file_dir or get_session_file()

  if vim.fn.filereadable(session_file) == 1 then
    vim.cmd("silent so " .. vim.fn.fnameescape(session_file))
    api.notify("Session loaded", vim.log.levels.INFO, { title = "Session" })
  else
    api.notify("No session was found", vim.log.levels.ERROR, { title = "Session" })
  end
end

--- Delete all existing sessions.
function M.delete_all_sessions()
  local session_dir = vim.fs.normalize(vim.g.hydravim.dirs.data .. "/session")
  vim.fn.delete(session_dir, "rf")
  api.notify("All sessions deleted", vim.log.levels.INFO, { title = "Session" })
end

--- Delete the current session or a specific session based on the file path.
-- @param file_dir (Optional) The custom file path of the session to delete.
function M.delete_session(file_dir)
  local session_file = file_dir or get_session_file()

  if vim.fn.filereadable(session_file) == 1 then
    vim.fn.delete(session_file, "rf")
    api.notify("Session deleted", vim.log.levels.INFO, { title = "Session" })
  else
    api.notify("No session was found", vim.log.levels.ERROR, { title = "Session" })
  end
end

--- Get the list of available session files.
-- @return A table containing the list of session file paths.
function M.list_all_sessions()
  local session_dir = vim.fs.normalize(vim.g.hydravim.dirs.data .. "/session")
  return vim.fn.glob(session_dir .. "/*.vim", true, true)
end

return M
