return {
  "terrortylor/nvim-comment",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    marker_padding = true,
    comment_empty = false,
    comment_empty_trim_whitespace = false,
    create_mappings = true,
    line_mapping = ";",
    operator_mapping = ";",
    comment_chunk_text_object = "<leader>;",
    hook = nil,
  },
  config = function(_, opts)
    require("nvim_comment").setup(opts)
  end,
}
