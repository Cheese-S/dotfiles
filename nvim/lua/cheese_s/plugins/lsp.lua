return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		-- mason setup
		local mason = require("mason")
		local mason_opts = {
			ensure_installed = {
				-- formatters
				"stylua",
				"clang-format",
				"yapf",
				"mdformat",
			},
		}
		vim.api.nvim_create_user_command("MasonInstallAll", function()
			local packages = table.concat(mason_opts.ensure_installed, " ")
			vim.cmd("MasonInstall " .. packages)
		end, {})
		mason.setup()

		-- mason lspconfig setup
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local lspconfig = require("lspconfig")
		local lspconfig_default = require("lspconfig").util.default_config
		local mason_lspconfig = require("mason-lspconfig")
		lspconfig_default.capabilities =
			vim.tbl_deep_extend("force", lspconfig_default.capabilities, cmp_nvim_lsp.default_capabilities())
		mason_lspconfig.setup({
			ensure_installed = {
				-- lsps
				"lua_ls",
				"clangd",
				"pyright",
				"marksman",
				"rust_analyzer",
			},
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end,
			},
		})

		lspconfig.clangd.setup({
			cmd = { "clangd", "--function-arg-placeholders=0" },
		})

		lspconfig.rust_analyzer.setup({})
	end,
}
