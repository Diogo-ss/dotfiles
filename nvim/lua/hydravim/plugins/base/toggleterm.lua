return {
  "akinsho/toggleterm.nvim",
  cmd = { "ToggleTerm" },
  keys = {
    { "<A-h>", "<cmd>ToggleTerm size=15 direction=horizontal<cr>" },
    { "<A-m>", "<cmd>ToggleTerm size=45 direction=vertical<cr>" },
    { "<A-i>", "<cmd>ToggleTerm direction=float<cr>" },
    { "<leader>i", "<cmd>ToggleTerm direction=float<cr>" },
  },
  opts = {
    direction = "float",
    float_opts = {
      border = "curved",
      width = function()
        return math.ceil(vim.o.columns * 0.7)
      end,
      height = function()
        return math.ceil(vim.o.lines * 0.7)
      end,
    },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)
  end,
}
