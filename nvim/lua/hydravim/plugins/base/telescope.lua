return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  version = "0.1.0",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>" },
    { "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<cr>" },
    { "<leader>fw", "<cmd>Telescope live_grep<cr>" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>" },
    { "<leader>fo", "<cmd>Telescope oldfiles<cr>" },
    { "<leader>gc", "<cmd>Telescope git_commits<cr>" },
    { "<leader>gt", "<cmd>Telescope git_status<cr>" },
    { "<leader>gb", "<cmd>Telescope git_branches<cr>" },
  },
  cmd = "Telescope",
  opts = function()
    local actions = require "telescope.actions"
    return {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "bottom",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = {},
        winblend = 0,
        color_devicons = true,
        use_less = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.close,
            ["<esc>"] = actions.close,
            ["<CR>"] = actions.select_default + actions.center,
          },
          n = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          },
        },
      },
    }
  end,
  config = function(_, opts)
    require("telescope").setup(opts)
  end,
}
