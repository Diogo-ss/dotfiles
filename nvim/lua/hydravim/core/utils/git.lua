--- Module containing functions related to Git operations.
-- @module git_utils

local M = {}

--- Executes a Git command with the given arguments.
-- @param arg The Git command and its arguments as a string.
-- @param dir (optional) The directory where the command should be executed.
-- @return The output of the Git command as a string.
function M.cmd(arg, dir)
  dir = dir or vim.fn.stdpath "config"
  return vim.fn.system("git -C " .. dir .. " " .. arg)
end

--- Checks if Git is available in the system.
-- @param dir (optional) The directory where the command should be executed.
-- @return A boolean indicating if Git is available.
function M.git_available()
  return vim.fn.executable "git" == 1
end

--- Get Git version.
-- @return The version of Git, or nil if Git is not available.
function M.version()
  if M.git_available() then
    return vim.version.parse(M.cmd "--version")
  end
  return nil
end

--- Checks if the Git repository has a remote with the specified URL.
-- @param remote The remote URL to check.
-- @param dir (optional) The directory where the command should be executed.
-- @return A boolean indicating if the remote URL exists in the Git repository.
function M.is_remote(remote, dir)
  local remote_url = M.cmd("config --get remote.origin.url", dir):gsub("\n", "")
  return string.find(remote_url, remote, 1, true) ~= nil
end

--- Checks if the current directory is a Git repository.
-- @param dir (optional) The directory where the command should be executed.
-- @return A boolean indicating if the current directory is a Git repository.
function M.is_repo(dir)
  dir = dir or vim.fn.stdpath "config"
  local git_dir = dir .. "/.git"
  return vim.fn.isdirectory(git_dir) == 1
end

--- Retrieves the name of the current Git branch.
-- @param dir (optional) The directory where the command should be executed.
-- @return The name of the current branch as a string.
function M.get_current_branch(dir)
  return M.cmd("rev-parse --abbrev-ref HEAD", dir):gsub("\n", "")
end

--- Checks out the specified Git branch.
-- @param branch The branch to check out.
-- @param dir (optional) The directory where the command should be executed.
-- @return A boolean indicating if the branch was successfully checked out.
function M.checkout(branch, dir)
  if M.get_current_branch(dir) == branch then
    return true
  end

  M.cmd("checkout -q " .. branch, dir)
  return M.get_current_branch(dir) == branch
end

--- Fetches the latest changes from the remote repository.
-- Performs a fetch and pull to retrieve the latest changes from the remote repository.
-- @param dir (optional) The directory where the command should be executed.
-- @return A boolean indicating if the fetch and pull were successful.
function M.fetch(dir)
  local fetch_commands = {
    "fetch -q",
    "pull -q",
  }

  for _, cmd in ipairs(fetch_commands) do
    M.cmd(cmd, dir)
    if vim.v.shell_error ~= 0 then
      return false
    end
  end

  return true
end

--- Cleans the local repository.
-- Performs a series of cleanup operations on the local repository,
-- including status check, clean, and hard reset.
-- @param dir (optional) The directory where the command should be executed.
-- @return A boolean indicating if the cleanup was successful.
function M.clean(dir)
  local clean_commands = {
    "status -s -b",
    "clean -q -f -d",
    "reset -q --hard HEAD",
  }

  for _, cmd in ipairs(clean_commands) do
    M.cmd(cmd, dir)
    if vim.v.shell_error ~= 0 then
      return false
    end
  end

  return true
end

return M
