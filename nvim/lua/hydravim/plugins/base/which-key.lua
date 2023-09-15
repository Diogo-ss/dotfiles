return {
  "folke/which-key.nvim",
  keys = "<leader>",
  opts = {
    options = {
      plugins = {
        marks = false,
        registers = false,
        spelling = {
          enabled = false,
          suggestions = 20,
        },
        presets = {
          operators = true,
          motions = true,
          text_objects = true,
          windows = true,
          nav = true,
          z = true,
          g = true,
        },
      },
      operators = { gc = "Comments" },
      icons = {
        breadcrumb = "»",
        separator = "",
        group = "",
      },
      window = {
        border = "single",
        position = "bottom",
        margin = { 1, 0, 1, 0 },
        padding = { 2, 2, 2, 2 },
        winblend = 0,
      },
      layout = {
        height = { min = 4, max = 25 },
        width = { min = 20, max = 50 },
        spacing = 3,
        align = "center",
      },
      ignore_missing = true,
      hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
      show_help = false,
      show_keys = false,
      triggers = "<leader>",
      triggers_blacklist = {
        i = { "j", "k" },
        v = { "j", "k" },
      },
      disable = {
        buftypes = {},
        filetypes = { "TelescopePrompt" },
      },
    },
    mappings = {
      u = { ":HydraVimUpdate<CR>", " Update" },
      q = { ":q<cr>", " Quit" },
      w = { ":w<cr>", " Save" },
      e = { ":NvimTreeToggle<cr>", "פּ Tree" },
      r = { ":Telescope live_grep<cr>", " Live Grep" },
      t = {
        name = " Terminal",
        t = { ":ToggleTerm<cr>", "Horizontal" },
        m = { ":ToggleTerm size=45 direction=vertical<CR>", "Vertical" },
        f = { ":ToggleTerm direction=float<cr>", "Floating" },
      },
      g = {
        name = " Git",
        c = { ":Telescope git_commits<cr>", " Commits" },
        b = { ":Telescope git_branches<cr>", " Branches" },
        s = { ":Telescope git_status<cr>", " Status" },
      },
      i = {
        name = " UI",
        i = { "<CMD>IndentBlanklineToggle<CR>", " Indent Line" },
      },
      f = {
        name = " Files",
        n = { ":ene <BAR> startinsert <CR>", " New file" },
        f = { ":Telescope find_files<cr>", " Find Files" },
        r = { ":Telescope oldfiles<CR>", " Recent" },
      },
      l = {
        name = " LSP",
        i = { ":LspInfo<cr>", " LSP Info" },
        r = { ":LspRestart<cr>", "ﰇ LSP Restart" },
        b = { ":LspStop<cr>", " LSP Stop" },
        s = { ":LspStart<cr>", " LSP Start" },
      },
      p = {
        name = " Plugins",
        c = { ":Lazy clean<cr>", "ﮁ Remove Unused Plugins" },
        s = { ":Laz sync<cr>", "痢 Plugins Sync" },
      },
    },
  },
  config = function(_, opts)
    local wk = require "which-key"
    wk.setup(opts.options)
    wk.register(opts.mappings, { prefix = "<leader>" })
  end,
}
