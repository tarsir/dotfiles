return {
  -- LSP manager
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents,
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason-lspconfig.nvim",
      "simrat39/rust-tools.nvim",
      "LittleEndianRoot/mason-conform",
    },
    config = function(_, opts)
      require("mason").setup(opts)
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "rust_analyzer", "elixirls" },
      })

      local lspconfig = require("lspconfig")
      lspconfig.zls.setup({
        cmd = { "zls" },
        filetypes = { "zig", "zir", "zon" },
        root_dir = lspconfig.util.root_pattern("zls.json", ".git"),
        single_file_support = true,
      })
    end,
  },
  {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local elixir = require("elixir")
      local elixirls = require("elixir.elixirls")

      elixir.setup({
        nextls = { enable = false },
        elixirls = {
          enable = true,
          settings = elixirls.settings({
            dialyzerEnabled = false,
            enableTestLenses = false,
          }),
          on_attach = function(client, bufnr)
            vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
          end,
        },
        projectionist = {
          enable = true,
        },
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  -- Debugging
  { "nvim-lua/plenary.nvim" },
  {
    "b0o/SchemaStore.nvim",
  },
  {
    "nvim-lua/lsp-status.nvim",
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        cmd = { "LspInstall", "LspUninstall" },
        config = function(_, opts)
          require("lspconfig.ui.windows").default_options = {
            border = "single",
          }
        end,
      },
      -- neovim Lua specific
      {
        "folke/neodev.nvim",
        config = function(_, opts)
          require("neodev").setup({})
        end,
      },
    },
    config = function()
      vim.filetype.add({
        extension = {
          jinja = "jinja",
          jinja2 = "jinja",
          j2 = "jinja",
          py = "python",
        },
        pattern = {
          [".*.bazelrc"] = "bazelrc",
        },
      })

      local servers = {
        jinja_lsp = {
          filetypes = { "jinja", "rust", "python" },
        },
      }
    end,
  },
  -- cmp
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        version = "2.2.0",
        build = "make install_jsregexp",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require("nvim-autopairs.completion.cmp")
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmp sources plugins
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    opts = function()
      return require("plugins.config.cmp")
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
  },
}
