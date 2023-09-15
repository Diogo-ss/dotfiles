return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    {
      "hrsh7th/cmp-cmdline",
      event = { "CmdlineEnter" },
    },
    {
      "windwp/nvim-autopairs",
      config = function(_, opts)
        require("nvim-autopairs").setup(opts)
      end,
    },
    {
      "L3MON4D3/LuaSnip",
      dependencies = { "rafamadriz/friendly-snippets" },
      opts = { history = true },
      config = function(_, opts)
        require("luasnip").config.set_config(opts)
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_snipmate").lazy_load()
        require("luasnip.loaders.from_lua").lazy_load()
      end,
    },
  },
  event = { "InsertEnter" },
  keys = { ":", "/", "?" },
  opts = function()
    local cmp = require "cmp"
    local kind_icons = require("hydravim.core.ui.icons").icons.kind_icons
    local mapping = cmp.mapping
    local select_insert = cmp.SelectBehavior.Insert

    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "cmp_git" },
      }, {
        { name = "buffer" },
      }),
    })

    cmp.setup.cmdline({ "/", "?" }, {
      mapping = mapping.preset.cmdline {
        ["<Down>"] = { c = mapping.select_next_item { behavior = select_insert } },
        ["<Up>"] = { c = mapping.select_prev_item { behavior = select_insert } },
      },
      sources = {
        { name = "buffer" },
      },
    })

    cmp.setup.cmdline(":", {
      mapping = mapping.preset.cmdline {
        ["<Down>"] = { c = mapping.select_next_item { behavior = select_insert } },
        ["<Up>"] = { c = mapping.select_prev_item { behavior = select_insert } },
      },
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })

    local function border(hl)
      return {
        { "╭", hl },
        { "─", hl },
        { "╮", hl },
        { "│", hl },
        { "╯", hl },
        { "─", hl },
        { "╰", hl },
        { "│", hl },
      }
    end

    return {
      confirmation = { completeopt = "menu, menuone, noinsert" },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },

      mapping = mapping.preset.insert {
        ["<C-u>"] = mapping.scroll_docs(-4),
        ["<C-d>"] = mapping.scroll_docs(4),
        -- ['<C-b>'] = mapping.scroll_docs(-4),
        ["<Esc>"] = mapping.abort(),
        -- ['<C-f>'] = mapping.scroll_docs(4),
        ["<CR>"] = mapping.confirm { select = true },
        ["<Tab>"] = function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end,
        ["<S-Tab>"] = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end,
      },

      formatting = {
        fields = { "kind", "abbr" },
        format = function(_, vim_item)
          vim_item.kind = kind_icons[vim_item.kind]
          return vim_item
        end,
      },

      sources = {
        { name = "nvim_lsp", priority = 100 },
        { name = "luasnip", keyword_length = 1, priority = 75 },
        { name = "nvim_lua", priority = 50 },
        { name = "buffer", keyword_length = 2, priority = 50 },
        { name = "path", priority = 25 },
      },

      window = {
        completion = {
          scrollbar = false,
          border = border "CmpBorder",
          winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
        },
        documentation = {
          winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
          border = border "CmpDocBorder",
          scrollbar = "",
        },
      },
    }
  end,
  config = function(_, opts)
    require("cmp").setup(opts)
  end,
}
