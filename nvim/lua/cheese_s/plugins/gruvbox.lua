return {
	"sainnhe/gruvbox-material",
	lazy = false,
	priority = 1000,
	config = function()
		-- Optionally configure and load the colorscheme
		-- directly inside the plugin declaration.
		vim.g.gruvbox_material_transparent_background = "2"
		vim.g.gruvbox_material_foreground = "mix"
		vim.g.gruvbox_material_enable_bold = true
		-- vim.api.nvim_set_hl(0, "Normal", { link = "DiffAdd" })
		vim.cmd.colorscheme("gruvbox-material")
		vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
		vim.cmd([[highlight FloatBorder guibg=None]])
		vim.cmd([[highlight FloatTitle guibg=None]])
		vim.cmd([[highlight Pmenu guibg=None]])
	end,
}
