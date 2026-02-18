return {
	"igorlfs/nvim-dap-view",
	---@module 'dap-view'
	---@type dapview.Config
	dependencies = {
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
		"mfussenegger/nvim-dap",
	},
	config = function()
		require("mason-nvim-dap").setup({
			ensure_installed = { "codelldb" },
		})

		require("dap-view").setup({
			auto_toggle = true,
		})
	end,
}
