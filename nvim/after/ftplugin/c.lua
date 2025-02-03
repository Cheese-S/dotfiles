local map = vim.keymap.set
local opt = vim.opt

opt.commentstring = "// %s"
map("n", "gh", "<cmd>ClangdSwitchSourceHeader<CR>")
