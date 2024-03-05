return {
  {
    "nvim-tree/nvim-web-devicons",
    enabled = vim.g.icons_enabled,
    opts = {
      deb = { icon = "", name = "Deb" },
      lock = { icon = "", name = "Lock" },
      mp3 = { icon = "", name = "Mp3" },
      mp4 = { icon = "", name = "Mp4" },
      out = { icon = "", name = "Out" },
      ["robots.txt"] = { icon = "ﮧ", name = "Robots" },
      ttf = { icon = "", name = "TrueTypeFont" },
      rpm = { icon = "", name = "Rpm" },
      woff = { icon = "", name = "WebOpenFontFormat" },
      woff2 = { icon = "", name = "WebOpenFontFormat2" },
      xz = { icon = "", name = "Xz" },
      zip = { icon = "", name = "Zip" },
    },
  },
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
  },
  -- notification window
  {
    "rcarriga/nvim-notify",
    event = "VimEnter",
    keys = {
      { "<leader>nc", function() require("notify").dismiss() end, desc = "Dismiss notifications",   mode = "n" },
      { "<leader>nh", "<cmd>Telescope notify<CR>",                desc = "Telescope notifications", mode = "n" },
    },
    opts = {
      on_open = function(win) vim.api.nvim_win_set_config(win, { zindex = 1000 }) end,
      stages = "fade_in_slide_out",
      background_colour = "#111111",
    },
    config = function(_, opts)
      vim.notify = require("notify")
      require("notify").setup(opts)
    end
  },
  -- upgrade the default menus
  {
    "stevearc/dressing.nvim",
    opts = {
      input = {
        default_prompt = "➤ ",
        win_options = { winhighlight = "Normal:Normal,NormalNC:Normal" },
      },
      select = {
        backend = { "telescope", "builtin" },
        builtin = { win_options = { winhighlight = "Normal:Normal,NormalNC:Normal" } },
      },
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
    cmd = { "ColorizerToggle", "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer", "ColorizerReloadAllBuffers" },
    opts = { user_default_options = { names = false } },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
  },
  {
    "lewis6991/gitsigns.nvim",
  },
  {
    'folke/noice.nvim',
    opts = {
      views = {
        notify = {
          replace = true,
        },
        hover = {
          border = {
            style = "rounded",
            padding = {},
          }
        },
      },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        progress = {
          view = "notify",
        }
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true,        -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim"
    },
    config = function(_, opts)
      require("noice").setup(opts)
    end
  }
}
