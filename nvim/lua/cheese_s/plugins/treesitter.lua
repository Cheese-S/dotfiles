return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	main = "nvim-treesitter.configs",
	opts = {
		ensure_installed = {
			"c",
			"lua",
			"vim",
			"markdown",
			"powershell",
			"objc",
		},
		auto_install = true,
		highlight = {
			enable = true,
		},
		indent = { enable = false, disable = { "python" } },
	},
}
