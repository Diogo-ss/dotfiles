local default_mappings = {
  n = {
    ["<C-Q>"] = { "<esc><cmd>q!<cr>" },
    ["<C-s>"] = { "<cmd>w<cr>" },
    ["<A-S-s>"] = { "<cmd>HydraVimSaveSession<cr>" },
    ["<A-S-l>"] = { "<cmd>HydraVimLoadSession<cr>" },
    ["<A-j>"] = { "<cmd>m .+1<cr>==" },
    ["<A-k>"] = { "<cmd>m .-2<cr>==" },
    ["<A-n>"] = { "<cmd>vsplit<cr>" },
    ["<A-b>"] = { "<cmd>split<cr>" },
    ["<C-h>"] = { "<C-w>h" },
    ["<C-l>"] = { "<C-w>l" },
    ["<C-k>"] = { "<C-w>k" },
    ["<C-j>"] = { "<C-w>j" },
    ["<C-z>"] = { "u" },
    ["<C-v>"] = { "p<esc>" },
    ["<C-a>"] = { "ggVG" },
    ["<C-A-h>"] = { "<cmd>vertical resize +3<cr>" },
    ["<C-A-l>"] = { "<cmd>vertical resize -3<cr>" },
    ["<C-A-j>"] = { "<cmd>resize -3<cr>" },
    ["<C-A-k>"] = { "<cmd>resize +3<cr>" },
    ["<S-j>"] = { "yyp" },
    ["<leader>F"] = { "<cmd>HydraVimFormat<cr>" },
    ["<esc>"] = { "<cmd>noh<return><esc>" },
  },
  v = {
    ["<C-Q>"] = { "<esc><cmd>q!<cr>" },
    ["<C-z>"] = { "<esc>u<esc>gv=gv" },
    ["<C-c>"] = { "y<esc>" },
    ["<C-v>"] = { "p<esc>gv=gv" },
    ["<C-a>"] = { "ggVG" },
    ["<A-j>"] = { "<cmd>m '>+1<cr>gv-gv" },
    ["<A-k>"] = { "<cmd>m '<-2<cr>gv-gv" },
    ["<"] = { "<gv" },
    [">"] = { ">gv" },
  },
  i = {
    ["<C-Q>"] = { "<esc><cmd>q!<cr>" },
    ["<C-h>"] = { "<Left>" },
    ["<C-j>"] = { "<Down>" },
    ["<C-k>"] = { "<Up>" },
    ["<C-l>"] = { "<Right>" },
  },
  t = {
    ["<A-h>"] = { "<cmd>ToggleTerm<cr>" },
    ["<A-m>"] = { "<cmd>ToggleTerm<cr>" },
    ["<A-i>"] = { "<cmd>ToggleTerm<cr>" },
  },
  x = {
    ["<F4>"] = { "<cmd>lua vim.lsp.buf.range_code_action()<cr>" },
  },
}

local file_path = vim.api.nvim_get_runtime_file("lua/user/config/mappings.lua", false)[1]
if file_path then
  default_mappings = vim.tbl_deep_extend("force", default_mappings, dofile(file_path))
end

for mode, mappings in pairs(default_mappings) do
  for key, action in pairs(mappings) do
    local options = action[2] or { noremap = true, silent = true }
    vim.api.nvim_set_keymap(mode, key, action[1], options)
  end
end
