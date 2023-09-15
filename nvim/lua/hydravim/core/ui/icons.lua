local M = {}

M.icons = {
  kind_icons = {
    Class = " ﴯ",
    Color = " ",
    Constant = " ",
    Constructor = " ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = " ",
    Folder = " ",
    Function = " ",
    Interface = " ﰮ",
    Keyword = " ",
    Method = " ",
    Module = " ",
    Operator = " ",
    Property = " ﰠ",
    Reference = " ",
    Snippet = " ",
    Struct = " ",
    Text = " ",
    TypeParameter = " ",
    Unit = " 塞",
    Value = " ",
    Variable = "[]",
  },
  git = {
    Git = "",
    Commit = "",
    Branch = "",
    Status = "",
    Unstaged = "",
    Staged = "",
    Unmerged = "",
    Renamed = "➜",
    Untracked = "★",
    Deleted = "",
    Ignored = "◌",
    Sings = {
      Add_line = "│",
      Change_line = "│",
      Add_new_line = "¦",
      Delete_icon = "",
      Added_icon = " ",
      Change_icon = "",
    },
  },
  ui = {
    Default_file = "",
    Symlink = "",
    Bookmark = "",
    Package_status = {
      Pending = " ",
      Installed = " ",
      Uninstalled = " ",
    },
    Buffer_close_icon = "",
    Modified_icon = "●",
    Trunc_marker = {
      Left = "",
      Right = "",
    },
  },
  signs = {
    Error = "",
    Warn = "",
    Hint = "",
    Info = "",
  },
}

return M
