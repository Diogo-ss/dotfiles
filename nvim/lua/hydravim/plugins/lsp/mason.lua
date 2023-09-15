return {
  {
    "williamboman/mason-lspconfig.nvim",
    cmd = {
      "LspInstall",
      "LspUninstall",
      "LpsStart",
      "LspRestart",
    },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      ensure_installed = { "lua_ls" },
      automatic_installation = true,
    },
    config = function(_, opts)
      local mason = require "mason-lspconfig"
      mason.setup(opts)
      mason.setup_handlers {
        function(server)
          require("lspconfig")[server].setup {}
        end,
      }
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
      "MasonUpdate",
    },
    opts = {
      ensure_installed = { "lua_ls" },
      ui = {
        icons = {
          package_pending = " ",
          package_installed = " ",
          package_uninstalled = " ",
        },
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
    end,
  },
}
