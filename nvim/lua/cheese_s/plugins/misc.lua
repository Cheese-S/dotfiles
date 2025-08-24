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
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {},
	},
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"ggandor/leap.nvim",
		enabled = true,
		config = function()
			local leap = require("leap")
			leap.opts.equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" }
			leap.opts.preview_filter = function(ch0, ch1, ch2)
				return not (ch1:match("%s") or ch0:match("%w") and ch1:match("%w") and ch2:match("%w"))
			end
		end,
	},
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
}
