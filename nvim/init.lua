vim.opt.shortmess:append "I"

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  require("hydravim.core.utils.strap").bootstrap(lazypath)
end
vim.opt.rtp:prepend(lazypath)

require("hydravim.core.load").load_config()
