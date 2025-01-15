return {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{
				-- Customize or remove this keymap to your liking
				"<leader>F",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		-- Everything in opts will be passed to setup()
		opts = {
			formatters_by_ft = {
				lua = { "lua_ls", "stylua" },
				elixir = { "elixirls" },
				sh = { "shfmt" },
				python = { "isort", "black" },
				javascript = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier" } },
				markdown = { "prettier" },
			},
			format_on_save = { timeout_ms = 500, lsp_fallback = true },
			formatters = {
				shfmt = {
					prepend_args = { "-i", "2" },
				},
			},
		},
		config = function(_, opts)
			local conform = require("conform").setup(opts)
		end,
	},
	{
		"mfussenegger/nvim-lint",
		event = { "BufWritePost" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				elixir = { "credo" },
			}

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
}
