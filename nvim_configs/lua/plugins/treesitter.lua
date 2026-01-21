return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function(_, opts)
      require("nvim-treesitter.config").setup({
        ensure_installed = {
          "lua",
          "vim",
          "rust",
          "elixir",
          "heex",
          "eex",
          "markdown",
          "bash",
          "markdown_inline",
          "vimdoc",
          "c3"
        },
        highlight = {
          enable = true,
          use_languagetree = true,
          disable = {},
        },
        indent = { enable = true },
      })
    end,
  },
}
