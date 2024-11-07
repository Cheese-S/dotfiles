vim.g.termguicolors = true

-- use system clipboard
vim.api.nvim_set_option("clipboard", "unnamedplus")

local opt = vim.opt

opt.autowrite = true

-- highlight current line
opt.cursorline = true

-- line numbering
opt.number = true

-- Make tab 4 spaces
opt.tabstop = 4
opt.expandtab = true
opt.softtabstop = 4
opt.shiftwidth = 4

opt.smartindent = true
opt.autoindent = true


