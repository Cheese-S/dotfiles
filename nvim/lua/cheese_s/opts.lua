vim.g.termguicolors = true

-- use system clipboard

local opt = vim.opt

opt.clipboard = "unnamedplus"

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

-- indentation becomes context aware
opt.smartindent = true
opt.autoindent = true

opt.updatetime = 200

-- try to always center
opt.scrolloff = 999

opt.signcolumn = 'yes'



-- enable persistent undo tree
vim.o.undofile = true



