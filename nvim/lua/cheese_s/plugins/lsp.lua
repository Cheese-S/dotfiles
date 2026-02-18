return {
	"mason-org/mason.nvim",
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		-- "hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		-- mason setup
		local mason = require("mason")
		local mason_opts = {
			-- formatters
			ensure_installed = {
				"stylua",
				"clang-format",
				"yapf",
				"mdformat",
				"clangd",
				"pyright",
			},
		}
		vim.api.nvim_create_user_command("MasonInstallAll", function()
			local packages = table.concat(mason_opts.ensure_installed, " ")
			vim.cmd("MasonInstall " .. packages)
		end, {})
		mason.setup()
	end,
}
