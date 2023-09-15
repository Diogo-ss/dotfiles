return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  cmd = {
    "TSBufDisable",
    "TSBufEnable",
    "TSBufToggle",
    "TSDisable",
    "TSEnable",
    "TSToggle",
    "TSInstall",
    "TSInstallInfo",
    "TSInstallSync",
    "TSModuleInfo",
    "TSUninstall",
    "TSUpdate",
    "TSUpdateSync",
  },
  opts = {
    sync_install = true,
    auto_install = true,
    ensure_installed = { "lua" },
    highlight = {
      enable = true,
      use_languagetree = true,
      additional_vim_regex_highlighting = true,
    },
    indent = {
      enable = true,
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
  build = function()
    require("nvim-treesitter.install").update { with_sync = true }
    vim.cmd "redraw"
  end,
}
