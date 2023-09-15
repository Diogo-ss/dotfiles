local M = {}
local git = require "hydravim.core.utils.git"
local api = require "hydravim.core.utils.api"

M.update = function()
  if not git.is_repo() then
    vim.schedule(function()
      api.notify("Not a git repository. Aborting update.", vim.log.levels.WARN)
    end)
    return
  end

  if not git.is_remote(vim.g.hydravim.repository.remote) then
    vim.schedule(function()
      api.notify("Not a HydraVim repository. Aborting update.", vim.log.levels.WARN)
    end)
    return
  end

  local response = vim.fn.input "Continue with the update? [y/N]: "
  if response:lower() ~= "y" then
    vim.schedule(function()
      api.notify("Update was cancelled.", vim.log.levels.WARN)
    end)
    return
  end

  api.notify "Looking for updates..."

  if not git.checkout(vim.g.hydravim.repository.branch) then
    api.notify(
      "Aborting update. Could not switch to branch: "
        .. git.get_current_branch()
        .. " ->! "
        .. vim.g.hydravim.repository.branch,
      vim.log.levels.WARN
    )
    return
  end

  if not git.clean() then
    api.notify(
      "Aborting update. Could not clean the repository for branch: " .. git.get_current_branch(),
      vim.log.levels.WARN
    )
    return
  end

  if git.fetch() then
    api.notify "Repository updated successfully!"
    vim.cmd "Lazy sync"
  else
    api.notify("Could not update HydraVim from remote repository.", vim.log.levels.WARN)
  end
end

return M
