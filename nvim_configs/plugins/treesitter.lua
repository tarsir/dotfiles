return {
  {
    "nvim-treesitter/nvim-treesitter",
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    config = function(_, opts)
      require("nvim-treesitter").setup({
	ensure_installed = { "lua" },

	highlight = {
	  enable = true,
	  use_languagetree = true,
	},

	indent = { enable = true },
      })
    end,
  },
}