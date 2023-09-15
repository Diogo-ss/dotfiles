--- Module containing functions related to HydraVim bootstrapping.
-- @module bootstrap_utils

local M = {}
local notify = require("hydravim.core.utils.api").notify

--- Bootstraps HydraVim by installing the lazy.nvim plugin.
-- @param lazypath The path where the lazy.nvim plugin will be installed.
function M.bootstrap(lazypath)
  vim.cmd "redraw"
  notify " Installing HydraVim..."
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  }
end

return M
