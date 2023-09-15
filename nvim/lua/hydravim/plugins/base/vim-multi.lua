return {
  "mg979/vim-visual-multi",
  keys = { { "<C-n>", mode = { "v", "n" } }, { "<C-A-Down>" }, { "<C-A-Up>" } },
  init = function()
    vim.g.VM_default_mappings = 0
    vim.g.VM_silent_exit = 1
    vim.g.VM_set_statusline = 0

    vim.g.VM_maps = {
      ["Find Under"] = "<C-n>",
      ["Find Subword Under"] = "<C-n>",
      ["Select Cursor Down"] = "<C-A-Down>",
      ["Select Cursor Up"] = "<C-A-Up>",
      ["Find Next"] = "]",
      ["Find Prev"] = "[",
      ["Goto Next"] = "}",
      ["Goto Prev"] = "{",
    }
  end,
}
