local custom_catppuccin = require("lualine.themes.catppuccin")

custom_catppuccin.normal.c.bg = "#282c34"
custom_catppuccin.inactive.c.bg = "#2c323c"

require("lualine").setup({
	options = {
		theme = custom_catppuccin,
	},
	sections = {
		lualine_a = {
			"mode",
		},
		lualine_b = {
			{
				"filename",
				file_status = true,
				path = 1,
			},
			{ "filesize" },
		},
		lualine_c = {
			{
				"filetype",
				colored = true,
				icon_only = false,
				icon = { align = "left" },
			},
		},
		lualine_x = {

			"branch",
			"diff",
			"diagnostics",
		},
		lualine_y = {
			"progress",
		},
		lualine_z = {
			"location",
		},
	},
	inactive_sections = {
		lualine_a = {
			"filename",
			file_status = true,
			path = 1,
		},
		lualine_z = {
			"location",
		},
	},
})
