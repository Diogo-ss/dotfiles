return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufRead" },
  opts = {
    filetype_exclude = {
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
      "TelescopePrompt",
      "help",
      "TelescopeResults",
      "mason",
      "",
    },
    buftype_exclude = { "terminal" },
    use_treesitter = true,
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = false,
    show_trailing_blankline_indent = false,
  },
  config = function(_, opts)
    require("indent_blankline").setup(opts)
  end,
}
