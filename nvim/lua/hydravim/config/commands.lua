local api = require "hydravim.core.utils.api"
local session = require "hydravim.core.utils.session"
local buffer = require "hydravim.core.utils.buffer"

local command = vim.api.nvim_create_user_command

command("HydraVimUpdate", function()
  require("hydravim.core.updater").update()
end, { nargs = "*", desc = "HydraVim update" })

command("HydraVimCustomConfig", function(args)
  local config = vim.g.hydravim.repository.user_config
  local remote, branch = args.fargs[1], args.fargs[2]

  if not remote then
    remote, branch = config.remote, config.branch
  end

  api.install_user_config(remote, branch)
end, { nargs = "*", desc = "Generate custom config or install an existing one" })

command("HydraVimSaveSession", function()
  session.save_session()
end, { nargs = "*", desc = "Save session" })

command("HydraVimLoadSession", function()
  session.load_session()
end, { nargs = "*", desc = "Load session" })

command("HydraVimCloseBuffer", function()
  buffer.delete_current()
end, { nargs = "*", desc = "Close buffer" })

command("HydraVimCloseEmptyBuffers", function()
  buffer.delete_all_empty_buffers()
end, { nargs = "*", desc = "Close empty buffers" })

command("HydraVimFormat", function()
  buffer.format()
end, { nargs = "*", desc = "Code format" })

command("HydraVimSaveAllBuffers", function()
  buffer.save_all()
end, { nargs = "*", desc = "Save all modified buffers" })

local file_path = vim.api.nvim_get_runtime_file("lua/user/config/commands.lua", false)[1]
if file_path then
  dofile(file_path)
end
