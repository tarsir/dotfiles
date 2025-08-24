return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "rcarriga/nvim-notify",
  },
  opts = function()
    return {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "-L",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = { "node_modules" },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        mappings = {
          n = {
            ["q"] = require("telescope.actions").close,
          },
        },
      },
      extensions_list = { "notify", "noice", "gitui" },
    }
  end,
  keys = {
    -- find
    { "<leader>ff", "<cmd> Telescope find_files <CR>",                desc = "find files",             mode = "n" },
    { "<leader>fg", "<cmd> Telescope live_grep <CR>",                 desc = "live grep",              mode = "n" },
    { "<leader>fb", "<cmd> Telescope buffers <CR>",                   desc = "find buffers",           mode = "n" },
    { "<leader>fh", "<cmd> Telescope help_tags <CR>",                 desc = "help page",              mode = "n" },
    { "<leader>fo", "<cmd> Telescope oldfiles <CR>",                  desc = "find oldfiles",          mode = "n" },
    { "<leader>fz", "<cmd> Telescope current_buffer_fuzzy_find <CR>", desc = "find in current buffer", mode = "n" },

    -- git
    { "<leader>cm", "<cmd> Telescope git_commits <CR>",               desc = "git commits",            mode = "n" },
    { "<leader>gs", "<cmd> Telescope git_status <CR>",                desc = "git status",             mode = "n" },

    -- pick a hidden term
    { "<leader>pt", "<cmd> Telescope terms <CR>",                     desc = "pick hidden term",       mode = "n" },
  },
  config = function(_, opts)
    require("which-key").add({
      { "<leader>f", group = "Find (Telescope)" },
    })
    local telescope = require("telescope")
    telescope.setup(opts)

    -- load extensions
    for _, ext in ipairs(opts.extensions_list) do
      telescope.load_extension(ext)
    end
  end,
}
