return {
	{ import = "plugins.groups" },
	ui = {
		border = "single",
	},
	-- General vim plugins,
	-- shortcut helper
	{
		"folke/which-key.nvim",
		keys = { "<leader>", '"', "'", "`", "c", "v" },
		config = function(_, opts)
			vim.o.timeout = true
			vim.o.timeoutlen = 200
			require("which-key").setup({
				window = {
					border = "single",
				},
			})
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{
				"<leader>xx",
				function()
					require("trouble").toggle()
				end,
				desc = "Trouble toggle",
			},
			{
				"<leader>xw",
				function()
					require("trouble").toggle("workspace_diagnostics")
				end,
				desc = "Trouble workspace diagnostics",
			},
			{
				"<leader>xd",
				function()
					require("trouble").toggle("document_diagnostics")
				end,
				desc = "Trouble document diagnostics",
			},
			{
				"<leader>xq",
				function()
					require("trouble").toggle("quickfix")
				end,
				desc = "Trouble quickfix",
			},
			{
				"<leader>xl",
				function()
					require("trouble").toggle("loclist")
				end,
				desc = "Trouble loclist",
			},
			{
				"<leader>gR",
				function()
					require("trouble").toggle("lsp_references")
				end,
				mode = "n",
				desc = "LSP references",
			},
		},
		opts = {},
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-neotest/neotest-python",
			"nvim-neotest/neotest-plenary",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"jfpedroza/neotest-elixir",
			"mrcjkb/rustaceanvim",
		},
		keys = {
			{
				"<leader>tt",
				function()
					require("neotest").run.run()
				end,
				desc = "Run nearest test",
				mode = "n",
			},
			{
				"<leader>tf",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				desc = "Run test file",
				mode = "n",
			},
			{
				"<leader>td",
				function()
					require("neotest").run.run({ strategy = "dap" })
				end,
				desc = "Debug nearest test",
				mode = "n",
			},
			{
				"<leader>ts",
				function()
					require("neotest").run.stop()
				end,
				desc = "Stop nearest test",
				mode = "n",
			},
			{
				"<leader>wt",
				function()
					require("neotest").watch.toggle()
				end,
				desc = "Toggle watching nearest test",
				mode = "n",
			},
			{
				"<leader>wf",
				function()
					require("neotest").watch.toggle()
				end,
				desc = "Toggle watching test files",
				mode = "n",
			},
			{
				"<leader>to",
				function()
					require("neotest").output_panel.toggle()
				end,
				desc = "Toggle test output panel",
				mode = "n",
			},
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-elixir"),
					require("rustaceanvim.neotest"),
					require("neotest-plenary"),
					require("neotest-python"),
				},
			})
		end,
	},
	-- file tree
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		config = function(_, opts)
			local mappings = {
				n = {
					["<C-n>"] = { "<cmd>Neotree<CR>", "open neotree" },
					["<leader>bl"] = { "<cmd>Neotree buffers<CR>", "open buffer list" },
				},
			}
			require("utils").set_mapping(mappings)
		end,
	},
	-- snapshots
	{
		"michaelrommel/nvim-silicon",
		lazy = true,
		cmd = "Silicon",
		config = function()
			require("silicon").setup({
				-- Configuration here, or leave empty to use defaults
				font = "VictorMono NF=34",
			})
		end,
	},
	-- commenting
	{
		"numToStr/Comment.nvim",
		keys = { { "gc", mode = { "n", "v" } }, { "gb", mode = { "n", "v" } } },
		init = function()
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
			local commentstring_avail, commentstring =
				pcall(require, "ts_context_commentstring.integrations.comment_nvim")
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
		"glepnir/dashboard-nvim",
		event = "VimEnter",
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
		config = function()
			require("dashboard").setup()
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup()

			function _G.set_terminal_keymaps()
				local opts = { buffer = 0 }
				vim.keymap.set("t", "<esc><esc>", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
				vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
				vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
				vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
				vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
			end

			-- if you only want these mappings for toggle term use term://*toggleterm#* instead
			vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
		end,
		keys = {
			{
				"<leader>tl",
				":ToggleTerm direction=float dir=git_dir<cr>",
				desc = "Toggle floating terminal",
				mode = "n",
			},
			{
				"<leader>tv",
				":ToggleTerm size=70 direction=vertical dir=git_dir<cr>",
				desc = "Toggle vertical terminal",
				mode = "n",
			},
			{
				"<leader>th",
				":ToggleTerm direction=horizontal dir=git_dir<cr>",
				desc = "Toggle horizontal terminal",
				mode = "n",
			},
		},
	},
	-- zen mode
	{
		"folke/zen-mode.nvim",
		opts = {},
		keys = {
			{
				"<leader>z",
				function()
					require("zen-mode").toggle()
				end,
				desc = "toggle Zen mode",
				mode = "n",
			},
		},
	},
	{
		"folke/twilight.nvim",
		opts = {},
	},
	-- theme
	{
		"catppuccin/nvim",
		lazy = false,
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
				integrations = {
					noice = true,
					mason = true,
					telescope = true,
					barbar = true,
				},
			})

			vim.cmd([[colorscheme catppuccin-frappe]])
		end,
	},
	{
		"brneor/gitui.nvim",
		keys = {
			{ "<leader>gg", "<cmd>GitUi<CR>", desc = "open gitui", mode = "n" },
			{ "<leader>gf", "<cmd>GitUiFilter<CR>", desc = "open project commits", mode = "n" },
			{ "<leader>guc", "<cmd>GitUiConfig<CR>", desc = "open gitui config", mode = "n" },
		},
	},
	-- status line
	{
		"nvim-lualine/lualine.nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function(_, opts)
			require("plugins.config.lualine")
		end,
	},
	-- tabline
	{
		"romgrk/barbar.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", "lewis6991/gitsigns.nvim" },
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		version = "^1.0.0", -- optional: only update when a new 1.x version is released
		opts = {},
		keys = {
			{ "<leader>bp", "<Cmd>BufferPick<CR>", desc = "buffer pick", mode = "n" },
			{ "<leader>ba", "<Cmd>BufferPin<CR>", desc = "buffer pin/unpin", mode = "n" },
			{ "<leader>bc", "<Cmd>BufferClose<CR>", desc = "buffer close", mode = "n" },
			{ "<leader>bdd", "<Cmd>BufferCloseAllButCurrentOrPinned<CR>", desc = "clear other buffers", mode = "n" },
			{ "<C-a>", "<Cmd>BufferPrevious<CR>", desc = "move to previous", mode = "n" },
			{ "<C-d>", "<Cmd>BufferNext<CR>", desc = "move to next", mode = "n" },
		},
	},
}
