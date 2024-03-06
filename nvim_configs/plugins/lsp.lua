return {
  -- LSP manager
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents,
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason-lspconfig.nvim",
      'simrat39/rust-tools.nvim',
    },
    config = function(_, opts)
      require("mason").setup(opts)
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "rust_analyzer", "elixirls" },
        automatic_installation = { exclude = { "zls" } }
      })
      require("mason-lspconfig").setup_handlers {
        function(server_name)
          require("lspconfig")[server_name].setup {}
        end,
        ["rust_analyzer"] = function()
        end,
        ["elixirls"] = function()
          local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())


          require("lspconfig").elixirls.setup({
            cmd = { "elixir-ls" },
            capabilities = capabilities,
          })
        end,
        ["tailwindcss"] = function()
          local capabilities = vim.lsp.protocol.make_client_capabilities()

          require("lspconfig").tailwindcss.setup({
            capabilities = capabilities,
            filetypes = { "html", "elixir", "eelixir", "heex" },
            init_options = {
              userLanguages = {
                elixir = "html-eex",
                eelixir = "html-eex",
                heex = "html-eex",
              },
            },
            settings = {
              tailwindCSS = {
                experimental = {
                  classRegex = {
                    'class[:]\\s*"([^"]*)"',
                  },
                },
              },
            },
          })
        end
      }
      local lspconfig = require("lspconfig")
      lspconfig.zls.setup({
        cmd = { "zls" },
        filetypes = { "zig", "zir", "zon" },
        root_dir = lspconfig.util.root_pattern("zls.json", ".git"),
        single_file_support = true
      })
    end,
  },
  -- Debugging
  { 'nvim-lua/plenary.nvim' },
  {
    "b0o/SchemaStore.nvim"
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
            border = "single"
          }
        end
      },
      -- neovim Lua specific
      {
        "folke/neodev.nvim",
        config = function(_, opts)
          require("neodev").setup({})
        end
      }
    },
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
        end
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
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
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
      return require "plugins.config.cmp"
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end
  },
}
