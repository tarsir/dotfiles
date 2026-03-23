return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      -- require("nvim-treesitter.config").setup({
      --   ensure_installed = {
      --     "lua",
      --     "vim",
      --     "rust",
      --     "elixir",
      --     "heex",
      --     "eex",
      --     "markdown",
      --     "bash",
      --     "markdown_inline",
      --     "vimdoc",
      --     "c3"
      --   },
      --   highlight = {
      --     enable = true,
      --     -- use_languagetree = true,
      --   },
      --   indent = { enable = true },
      -- })
      local treesitter = require('nvim-treesitter')
      local filetypes = {
        "bash",
        "c",
        "c3",
        "cpp",
        "eex",
        "elixir",
        "heex",
        "lua",
        "markdown",
        "markdown_inline",
        "nu",
        "powershell",
        "rust",
        "vim",
        "vimdoc",
      }
      treesitter.setup()
      treesitter.install(filetypes)

      local function treesitter_try_attach(buf, language)
        do
          if not vim.treesitter.language.add(language) then return end
          vim.treesitter.start(buf, language)
        end
      end

      local available_parsers = treesitter.get_available()
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local buf, filetype = args.buf, args.match
          local language = vim.treesitter.language.get_lang(filetype)
          if not language then return end

          local installed_parsers = treesitter.get_installed 'parsers'

          if vim.tbl_contains(installed_parsers, language) then
            treesitter_try_attach(buf, language)
          elseif vim.tbl_contains(available_parsers, language) then
            treesitter.install(language):await(function()
              treesitter_try_attach(buf, language)
            end)
          else
            treesitter_try_attach(buf, language)
          end
        end,
      })

      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  },
}
