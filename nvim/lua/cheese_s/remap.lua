local map = vim.keymap.set

-- VIM
-- normal mode
map("i", "jk", "<esc>")

-- save file
map("n", "<leader>ss", "<cmd>w<cr><esc>")
map("n", "<leader>sa", "<cmd>wa<CR><esc>")

-- search and replace
map("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- jump between windows
-- map({ "n", "v", "i" }, "<c-k>", "<c-w><up>")
-- map({ "n", "v", "i" }, "<c-j>", "<c-w><down>")
-- map({ "n", "v", "i" }, "<c-h>", "<c-w><left>")
-- map({ "n", "v", "i" }, "<c-l>", "<c-w><right>")

-- split windows
map({ "n", "v" }, "<leader>wl", "<cmd>belowright vert sp<cr>")
map({ "n", "v" }, "<leader>wk", "<cmd>leftabove hor sp<cr>")
map({ "n", "v" }, "<leader>wh", "<cmd>leftabove vert sp<cr>")
map({ "n", "v" }, "<leader>wj", "<cmd>belowright hor sp<cr>")

-- resize window
-- map("n", "<C-Up>", "<cmd> resize +5<cr>")
-- map("n", "<C-Down>", "<cmd> resize -5<cr>")
-- map("n", "<C-Right>", "<cmd> vertical resize +5<cr>")
-- map("n", "<C-Left>", "<cmd> vertical resize -5<cr>")

-- jump around and refocus
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")

-- move lines above below
map("n", "<A-j>", ":m+ <cr> ==")
map("n", "<A-k>", ":m-2<cr> ==")
map("v", "<A-j>", ":m '> +1<cr>gv=gv")
map("v", "<A-k>", ":m '< -2<cr>gv=gv")

-- insert blank line
map("n", "<leader>o", 'o<esc>"_S<esc>')

-- remove highlight after search
map("n", "<esc>", "<cmd>noh<cr>")

-- jumplist
map("n", "gp", "<C-o>")
map("n", "gn", "<C-i>")

-- comment
map("n", "<C-_>", "gc_", { remap = true })
map("v", "<C-_>", "gc_`>^", { remap = true })

-- marks
map("n", "<leader>ma", "<cmd>delmarks A-Z0-9")

-- insert semicolon at the end
map({ "n" }, "<leader>;", function()
	local cursor = vim.api.nvim_win_get_cursor(0)
	vim.cmd("norm A;")
	vim.api.nvim_win_set_cursor(0, cursor)
end, { noremap = true, silent = true })

-- plugins
-- fzf keymaps
local fzf = require("fzf-lua")

map("n", "<leader>gf", fzf.files)
map("n", "<leader>gb", fzf.buffers)
map("n", "<leader>gs", fzf.lsp_document_symbols)
map("n", "<leader>gas", fzf.lsp_workspace_symbols)
map("n", "<leader>fs", fzf.blines)
map("n", "<leader>fa", fzf.live_grep)

fzf.setup({
	keymap = {
		builtin = {
			["<S-j>"] = "preview-down",
			["<S-k>"] = "preview-up",
			["<S-down>"] = "preview-page-down",
			["<S-up>"] = "preview-page-up",
		},
	},
})
-- oil keymaps
local oil = require("oil")
-- open current file's directory
map("n", "<leader>e", oil.toggle_float)

-- harpoon keymaps
local harpoon = require("harpoon")
map("n", "<leader>ha", function()
	harpoon:list():add()
end)
map("n", "<leader>hl", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)
map("n", "<leader>1", function()
	harpoon:list():select(1)
end)
map("n", "<leader>2", function()
	harpoon:list():select(2)
end)
map("n", "<leader>3", function()
	harpoon:list():select(3)
end)
map("n", "<leader>4", function()
	harpoon:list():select(4)
end)
map("n", "<leader>5", function()
	harpoon:list():select(5)
end)

-- undotree keymaps
map("n", "<leader>u", "<cmd>UndotreeToggle<cr>")

-- lsp
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(e)
		local opts = { buffer = e.buf }
		map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
		map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
		map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
		map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
		map("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
		map("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
		map("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
		map("n", "<leader>R", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
		map({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
		map("n", "<leader>.", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
		map("n", "<leader>se", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>", opts)
	end,
})

-- smart-splits. This needs to be kept the same in wezterm.lua
local splits = require("smart-splits")
map("n", "<c-Up>", splits.resize_up)
map("n", "<c-Down>", splits.resize_down)
map("n", "<c-Left>", splits.resize_left)
map("n", "<c-Right>", splits.resize_right)

map({ "n", "v", "i" }, "<c-h>", splits.move_cursor_left)
map({ "n", "v", "i" }, "<c-j>", splits.move_cursor_down)
map({ "n", "v", "i" }, "<c-k>", splits.move_cursor_up)
map({ "n", "v", "i" }, "<c-l>", splits.move_cursor_right)

-- cmp
local cmp = require("cmp")
cmp.setup({
	mapping = {
		["<A-j>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { "i", "c" }),
		["<A-k>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { "i", "c" }),
		["<S-j>"] = cmp.mapping.scroll_docs(4),
		["<S-k>"] = cmp.mapping.scroll_docs(-4),
		["<CR>"] = function(fallback)
			if cmp.visible() and cmp.get_active_entry() then
				cmp.confirm()
			else
				fallback()
			end
		end,
	},
})

-- gitsigns
local gitsigns = require("gitsigns")

map("n", "]c", function()
	if vim.wo.diff then
		vim.cmd.normal({ "]c", bang = true })
	else
		gitsigns.nav_hunk("next")
	end
end)

map("n", "[c", function()
	if vim.wo.diff then
		vim.cmd.normal({ "[c", bang = true })
	else
		gitsigns.nav_hunk("prev")
	end
end)

map("n", "<leader>hs", gitsigns.stage_hunk)
map("n", "<leader>hr", gitsigns.reset_hunk)
map("n", "<leader>hp", gitsigns.preview_hunk_inline)

-- markdown preview
map("n", "<leader>mp", function()
	vim.cmd("MarkdownPreview")
end)
