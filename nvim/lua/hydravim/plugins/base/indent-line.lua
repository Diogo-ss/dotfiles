return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufRead" },
  opts = {
    indent = { char = "│" },
    scope = { show_start = false, show_end = false },
    exclude = {
      filetypes = {
        "help",
        "startify",
        "dashboard",
        "alpha",
        "dash",
        "lazy",
        "NvimTree",
        "neo-tree",
        "Trouble",
        "terminal",
        "lspinfo",
        "help",
        "mason",
        "checkhealth",
        "man",
        "gitcommit",
        "TelescopePrompt",
        "TelescopeResults",
        "",
      },
      buftypes = {
        "terminal",
        "nofile",
        "quickfix",
        "prompt",
      },
    },
  },
  config = function(_, opts)
    require("ibl").setup(opts)
  end,
}
