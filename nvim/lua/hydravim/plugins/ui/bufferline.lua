return {
  "akinsho/bufferline.nvim",
  version = "v3.*",
  keys = {
    { "<C-A-PageUp>", "<cmd>BufferLineMoveNext<cr>" },
    { "<C-A-PageDown>", "<cmd>BufferLineMovePrev<cr>" },
    { "<TAB>", "<cmd>bnext<cr>" },
    { "<S-TAB>", "<cmd>bprev<cr>" },
    { "<C-w>", "<cmd>HydraVimCloseBuffer<cr>" },
    { "<leader>p", "<cmd>BufferLineTogglePin<cr>" },
  },
  event = "VeryLazy",
  opts = function()
    return {
      options = {
        buffer_close_icon = "",
        modified_icon = "●",
        left_trunc_marker = "",
        right_trunc_marker = "",
        offsets = {
          {
            filetype = "NvimTree",
            text = "Files",
            text_align = "center",
            separator = false,
          },
        },
        indicator = {
          style = "none",
        },
        show_buffer_close_icons = true,
        show_close_icon = false,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = true,
        always_show_bufferline = false,
        groups = {
          items = {
            require("bufferline.groups").builtin.pinned:with { icon = "" },
          },
        },
        diagnostics_indicator = function(count, level)
          local icon = level:match "error" and "" or ""
          return icon .. " " .. count
        end,
      },
      highlights = {
        buffer_selected = {
          italic = false,
        },
        numbers_selected = {
          italic = false,
        },
        diagnostic_selected = {
          italic = false,
        },
        hint_selected = {
          italic = false,
        },
        hint_diagnostic_selected = {
          italic = false,
        },
        info_selected = {
          italic = false,
        },
        info_diagnostic_selected = {
          italic = false,
        },
        warning_selected = {
          italic = false,
        },
        warning_diagnostic_selected = {
          italic = false,
        },
        error_selected = {
          italic = false,
        },
        error_diagnostic_selected = {
          italic = false,
        },
        duplicate_selected = {
          italic = false,
        },
        duplicate_visible = {
          italic = false,
        },
        duplicate = {
          italic = false,
        },
        pick_selected = {
          italic = false,
        },
        pick_visible = {
          italic = false,
        },
        pick = {
          italic = false,
        },
      },
    }
  end,
  config = function(_, opts)
    require("bufferline").setup(opts)
  end,
}
