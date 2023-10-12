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
        -- Path to user configuration directory.
        user = vim.fn.stdpath "config" .. "/lua/user",
        -- Path to Hydravim data directory.
        data = data,
      },
      ui = {
        -- Theme configuration. Supports function, string or 'false' to disable themes.
        theme = "catppuccin-mocha",
      },
      repository = {
        -- Branch for the base configuration.
        branch = "main",
        -- Remote repository for the base configuration (user/repo).
        remote = "HydraVim/HydraVim",
        user_config = {
          -- Branch for user configuration.
          branch = "1.5",
          -- Remote repository for user configuration (user/repo).
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
          -- Verify the existence of the 'user.plugins' folder and load it if present.
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
