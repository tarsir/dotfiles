return {
  -- LSP manager
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents,
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function(_, opts)
      require("mason").setup(opts)
      require("mason-lspconfig").setup({
	  ensure_installed = { "lua_ls", "rust_analyzer", "elixirls"},
	  automatic_installation = { exclude = { "zls"} }
	})
      require("mason-lspconfig").setup_handlers {
	function (server_name)
	  require("lspconfig")[server_name].setup {}
	end,
      }
      local lspconfig = require("lspconfig")
      lspconfig.zls.setup({
	cmd = {"zls"},
	filetypes = { "zig", "zir", "zon" },
	root_dir = lspconfig.util.root_pattern("zls.json", ".git"),
	single_file_support = true
      })

    end,
  },
  {
    "b0o/SchemaStore.nvim"
  },
  {
    "ziglang/zig.vim"
  },
  {
    "folke/neodev.nvim",
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        cmd = { "LspInstall", "LspUninstall" },
	config = function(_, opts)

	end
      },
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      {
        "jay-babu/mason-null-ls.nvim",
        cmd = { "NullLsInstall", "NullLsUninstall" },
        opts = { handlers = {} },
      },
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
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
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
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    opts = function()
      return require "plugins.config.cmp"
    end,
  },
}
