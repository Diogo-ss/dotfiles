return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    { "K", "<cmd>lua vim.lsp.buf.hover()<cr>" },
    { "gd", "<cmd>lua vim.lsp.buf.definition()<cr>" },
    { "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>" },
    { "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>" },
    { "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>" },
    { "gr", "<cmd>lua vim.lsp.buf.references()<cr>" },
    { "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>" },
    { "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>" },
    { "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>" },
    { "gl", "<cmd>lua vim.diagnostic.open_float()<cr>" },
    { "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>" },
    { "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>" },
  },
  opts = {
    signs = true,
    underline = true,
    update_in_insert = true,
    severity_sort = false,
    virtual_text = true,
    float = {
      header = "",
      border = "rounded",
      format = function(diagnostic)
        return string.format("%s", diagnostic.message)
      end,
    },
  },
  config = function(_, opts)
    local lspconfig = require "lspconfig"
    local lsp = vim.lsp
    local default_config = lspconfig.util.default_config
    local capabilities = lspconfig.util.default_config.capabilities
    local handlers = vim.lsp.handlers
    local merge = vim.tbl_deep_extend
    local signs = require("hydravim.core.ui.icons").icons.signs

    handlers["textDocument/hover"] = lsp.with(handlers.hover, {
      border = "rounded",
    })

    handlers["textDocument/signatureHelp"] = lsp.with(handlers.signature_help, {
      border = "rounded",
    })

    vim.diagnostic.config(opts)

    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    default_config.capabilities = merge("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
  end,
}
