return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"folke/lazydev.nvim",
	},
	config = function()
		local cmp = require("cmp")

		local kind_icons = {
			Text = "",
			Method = "󰆧",
			Function = "󰊕",
			Constructor = "",
			Field = "󰇽",
			Variable = "󰂡",
			Class = "󰠱",
			Interface = "",
			Module = "",
			Property = "󰜢",
			Unit = "",
			Value = "󰎠",
			Enum = "",
			Keyword = "󰌋",
			Snippet = "",
			Color = "󰏘",
			File = "󰈙",
			Reference = "",
			Folder = "󰉋",
			EnumMember = "",
			Constant = "󰏿",
			Struct = "",
			Event = "",
			Operator = "󰆕",
			TypeParameter = "󰅲",
		}
		cmp.setup({
			enabled = function()
				local context = require("cmp.config.context")
				-- keep command mode completion enabled when cursor is in a comment
				if vim.api.nvim_get_mode().mode == "c" then
					return true
				else
					return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
				end
			end,
			sources = {
				{ name = "lazydev" },
				{ name = "nvim_lsp" },
				{ name = "nvim_lsp_signature_help" },
				{ name = "path" },
				{ name = "buffer" },
			},
			snippet = {
				expand = function(args)
					vim.snippet.expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({}),
			window = {
				completion = {
					border = "rounded",
					winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None",
				},
				documentation = {
					border = "rounded",
					winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None",
				},
			},
			formatting = {
				format = function(entry, vim_item)
					-- Kind icons
					vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
					-- Source
					vim_item.menu = ({
						buffer = "[Buffer]",
						nvim_lsp = "[LSP]",
						luasnip = "[LuaSnip]",
						nvim_lua = "[Lua]",
						latex_symbols = "[LaTeX]",
					})[entry.source.name]
					return vim_item
				end,
			},
		})
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline({
				["<CR>"] = {
					c = function(default)
						if cmp.visible() and cmp.get_active_entry() then
							return cmp.confirm()
						end
						default()
					end,
				},
			}),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{
					name = "cmdline",
					option = {
						ignore_cmds = { "Man", "!" },
					},
				},
			}),
		})

		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})
	end,
}
