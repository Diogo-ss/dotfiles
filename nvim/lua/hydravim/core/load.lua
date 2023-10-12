local M = {}

M.load_lazy = function()
  require("lazy").setup(vim.g.hydravim.lazy)
end

M.load_theme = function()
  -- Load the theme. Set the variable to `false` to not set it.
  -- If `vim.g.hydravim.ui.theme` is a function, it's executed.
  -- If it's a string, the theme is set using `vim.cmd.colorscheme(theme)`.
  local theme = vim.g.hydravim.ui.theme
  if type(theme) == "function" then
    theme()
  elseif theme then
    vim.cmd.colorscheme(theme)
  end
end

M.load_config = function()
  -- Load settings
  for _, name in pairs { "settings", "autocmds", "mappings", "commands" } do
    require("hydravim.config." .. name)
  end

  M.load_lazy()
  M.load_theme()
end

return M
