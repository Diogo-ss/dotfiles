local data = vim.fn.stdpath "data" .. "/hydravim"

local default_options = {
  opt = {
    mouse = "a",
    tabstop = 2,
    number = true,
    clipboard = "unnamedplus",
    shiftwidth = 2,
    softtabstop = 2,
    cursorline = true,
    smartindent = true,
    termguicolors = true,
    showmode = false,
    fillchars = { eob = " ", fold = " ", vert = "│" },
    list = true,
    expandtab = true,
    autowrite = true,
    scrolloff = 4,
  },
  o = {
    syntax = "on",
    updatetime = 250,
    undofile = true,
    smartcase = true,
    ignorecase = true,
    splitright = true,
    splitbelow = true,
  },
  wo = {
    wrap = false,
  },
  g = {
    mapleader = " ",
    maplocalleader = " ",
    loaded_netrw = 1,
    loaded_netrwPlugin = 1,
    hydravim = {
      dirs = {
        user = vim.fn.stdpath "config" .. "/lua/user",
        data = data,
      },
      ui = {
        theme = "catppuccin-mocha",
        dash = true,
      },
      repository = {
        branch = "main",
        remote = "HydraVim/HydraVim",
        user_config = {
          branch = "1.5",
          remote = "HydraVim/user-config",
        },
      },
      lazy = {
        defaults = { lazy = true },
        spec = {
          { import = "hydravim.core.lockfile" },
          { import = "hydravim.plugins.base" },
          { import = "hydravim.plugins.git" },
          { import = "hydravim.plugins.lsp" },
          { import = "hydravim.plugins.ui" },
          vim.api.nvim_get_runtime_file("lua/user/plugins/", false)[1] and { import = "user.plugins" },
        },
        ui = {
          icons = {
            lazy = "鈴 ",
          },
        },
        lockfile = data .. "/lazy/lazy-lock.json",
        performance = {
          rtp = {
            disabled_plugins = {
              "getscript",
              "getscriptPlugin",
              "gzip",
              "ftplugin",
              "logipat",
              "netrw",
              "netrwPlugin",
              "rrhelper",
              "netrwSettings",
              "2html_plugin",
              "netrwFileHandlers",
              "tohtml",
              "matchit",
              "tar",
              "tutor",
              "syntax",
              "tarPlugin",
              "spellfile_plugin",
              "vimball",
              "vimballPlugin",
              "zip",
              "zipPlugin",
              "rplugin",
              "synmenu",
              "optwin",
              "compiler",
              "bugreport",
            },
          },
        },
      },
    },
  },
}

local file_path = vim.api.nvim_get_runtime_file("lua/user/config/settings.lua", false)[1]
if file_path then
  default_options = vim.tbl_deep_extend("force", default_options, dofile(file_path))
end

for type, table in pairs(default_options) do
  for option, value in pairs(table) do
    vim[type][option] = value
  end
end
