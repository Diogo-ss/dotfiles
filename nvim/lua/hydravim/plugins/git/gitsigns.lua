return {
  "lewis6991/gitsigns.nvim",
  ft = "gitcommit",
  opts = {
    signs = {
      add = { text = "│" },
      change = { text = "│" },
      topdelete = { text = "" },
      delete = { text = "_" },
      untracked = { text = "¦" },
      changedelete = { text = "" },
    },
  },
  event = { "BufRead" },
  config = function(_, opts)
    require("gitsigns").setup(opts)
  end,
}
