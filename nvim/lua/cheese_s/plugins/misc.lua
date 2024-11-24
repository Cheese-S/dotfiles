return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local gitsigns = require("gitsigns")
			gitsigns.setup({})

			vim.api.nvim_set_hl(0, "GitsignsAddInline", { link = "DiffAdd" })
			vim.api.nvim_set_hl(0, "GitsignsDeleteInline", { link = "DiffDelete" })
			vim.api.nvim_set_hl(0, "GitsignsChangeInline", { link = "DiffChange" })
		end,
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		opts = {},
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			statuscolumn = { enabled = true },
			lazygit = { enabled = true },
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {},
		},
	},
}
