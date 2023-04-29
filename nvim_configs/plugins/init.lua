require("lazy").setup({
  { import = "lsp",},
  { import = "ui"},
  { import = "telescope"},
  { import = "treesitter"},
})

return {
  -- General vim plugins,
  -- shortcut helper
  {
    'folke/which-key.nvim',
    event = "VeryLazy",
    keys = { "<leader>", '"', "'", "`", "c", "v" },
  },
  -- file tree
  {
    'ms-jpq/chadtree',
    branch = 'chad',
    build = 'python3 -m chadtree deps',
    config = function(_, opts)
      vim.api.nvim_set_keymap('n', '<C-n>', ":CHADopen<cr>", {})
    end
  },
  -- commenting
  {
    "numToStr/Comment.nvim",
    keys = { { "gc", mode = { "n", "v" } }, { "gb", mode = { "n", "v" } } },
    init = function ()
      local mappings = {
	n = {
	  ["<leader>/"] = {
	    function()
	      require("Comment.api").toggle.linewise.current()
	    end,
	    "toggle comment",
	  },
	},

	v = {
	  ["<leader>/"] = {
	    "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
	    "toggle comment",
	  },
	},
      }

      require("utils").set_mapping(mappings)
    end,
    opts = function()
      local commentstring_avail, commentstring = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
      return commentstring_avail and commentstring and { pre_hook = commentstring.create_pre_hook() } or {}
    end,
  },
  -- bracket pairings
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      ts_config = { java = false },
      fast_wrap = {
	map = "<M-e>",
	chars = { "{", "[", "(", '"', "'" },
	pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
	offset = 0,
	end_key = "$",
	keys = "qwertyuiopzxcvbnmasdfghjkl",
	check_comma = true,
	highlight = "PmenuSel",
	highlight_grey = "LineNr",
      },
    },
  },

  -- starting dashboard
  {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    dependencies = { {'nvim-tree/nvim-web-devicons'}},
    config = function ()
      require("dashboard").setup()
    end
  },
  {
    'tiagovla/tokyodark.nvim',
    lazy = false,
    config = function ()
      vim.cmd([[colorscheme tokyodark]])
    end
  },

  -- status line
  {
    'freddiehaddad/feline.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    config = function (_, opts)
      require('plugins.config.feline')
    end
  },
  -- tabline
  {
    'romgrk/barbar.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    init = function() vim.g.barbar_auto_setup = false end,
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
    config = function(_, opts)
      local mappings = {
	n = {
	  ["<leader>bp"] = { "<Cmd>BufferPick<CR>", "buffer pick"},
	  ["<leader>bc"] = { "<Cmd>BufferClose<CR>", "buffer close"},
	  ["<leader>bdd"] = { "<Cmd>BufferCloseAllButCurrentOrPinned<CR>", "clear other buffers"},
	  ["<C-a>"] = { "<Cmd>BufferPrevious<CR>", "move to previous"},
	  ["<C-d>"] = { "<Cmd>BufferNext<CR>", "move to next"},
	}
      }

      require("utils").set_mapping(mappings)
    end
  },
}
