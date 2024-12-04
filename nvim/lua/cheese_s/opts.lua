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

opt.signcolumn = "yes"

opt.showmode = false

opt.wrap = false

opt.relativenumber = true

-- enable persistent undo tree
vim.o.undofile = true

-- change lsp icons
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "󰌵",
        },
    },
})

-- make help always open window horizontally
vim.api.nvim_create_autocmd("FileType", {
    pattern = "help",
    command = "wincmd L",
})
