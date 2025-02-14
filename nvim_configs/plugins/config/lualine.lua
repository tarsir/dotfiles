require("lualine").setup({
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
})
