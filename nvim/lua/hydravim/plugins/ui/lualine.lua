return {
  "nvim-lualine/lualine.nvim",
  event = "BufEnter",
  opts = function()
    local file_icon = require("lualine.components.filename"):extend()
    file_icon.apply_icon = require("lualine.components.filetype").apply_icon
    local api = require "hydravim.core.utils.api"

    return {
      options = {
        symbols = {
          added = " ",
          modified = " ",
          removed = " ",
          error = " ",
          warn = " ",
          info = " ",
          hint = " ",
        },
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          "alpha",
          "dash",
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { { icon = "", "mode" } },
        lualine_b = { { icon = "", "branch" } },
        lualine_x = { "diagnostics" },
        lualine_y = { { api.get_lsp_clients } },
        lualine_z = { { "progress", icon = "" } },
        lualine_c = {
          { file_icon, symbols = { modified = "", readonly = "", unnamed = "No Name", newfile = "" } },
          "diff",
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    }
  end,
  config = function(_, opts)
    require("lualine").setup(opts)
  end,
}
