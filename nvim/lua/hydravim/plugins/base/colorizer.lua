return {
  "NvChad/nvim-colorizer.lua",
  cmd = { "ColorizerToggle", "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer", "ColorizerReloadAllBuffers" },
  config = function(_, opts)
    require("colorizer").setup(opts)
  end,
}
