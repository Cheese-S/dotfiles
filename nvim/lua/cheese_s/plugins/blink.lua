return {
	"saghen/blink.cmp",
	version = "v1.6.0",
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
		-- 'super-tab' for mappings similar to vscode (tab to accept)
		-- 'enter' for enter to accept
		-- 'none' for no mappings
		-- See :h blink-cmp-config-keymap for defining your own keymap
		keymap = {
			preset = "enter",
			["<A-j>"] = { "select_next", "fallback" },
			["<A-k>"] = { "select_prev", "fallback" },
			["<S-j>"] = { "scroll_documentation_up", "fallback" },
			["<S-k>"] = { "scroll_documentation_down", "fallback" },
		},

		signature = { enabled = true, window = { border = "rounded" } },

		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},

		-- (Default) Only show the documentation popup when manually triggered
		completion = {
			documentation = { auto_show = true, window = { border = "rounded" } },
			menu = {
				draw = {
					treesitter = { "lsp" },
					columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
				},
				border = "rounded",
			},
			list = { selection = { preselect = false } },
		},

		cmdline = {
			keymap = { preset = "inherit" },
			completion = { menu = { auto_show = true }, list = { selection = { preselect = false } } },
		},

		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { "lsp", "path", "buffer" },
		},
		-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
		-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
		-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
		--
		-- See the fuzzy documentation for more information
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
	config = function(_, opts)
		require("blink.cmp").setup(opts)
		local priority = { "lsp", "buffer" }
		local original = require("blink.cmp.completion.list").show
		---@diagnostic disable-next-line: duplicate-set-field
		require("blink.cmp.completion.list").show = function(ctx, items_by_source)
			local seen = {}
			local function filter(item)
				if seen[item.label] then
					return false
				end
				seen[item.label] = true
				return true
			end
			for id in vim.iter(priority) do
				items_by_source[id] = items_by_source[id] and vim.iter(items_by_source[id]):filter(filter):totable()
			end
			return original(ctx, items_by_source)
		end
	end,
}
