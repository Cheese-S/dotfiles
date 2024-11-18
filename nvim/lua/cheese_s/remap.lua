local map = vim.keymap.set

-- VIM
-- normal mode
map("i", "jk", "<esc>")

-- save file
map("n", "<leader>ss", "<cmd>w<cr><esc>")

-- jump between windows
map({"n", "v", "i"}, "<c-k>", "<c-w><up>")
map({"n", "v", "i"}, "<c-j>", "<c-w><down>")
map({"n", "v", "i"}, "<c-h>", "<c-w><left>")
map({"n", "v", "i"}, "<c-l>", "<c-w><right>")

-- split windows
map({"n", "v"}, "<leader>wl", "<cmd>belowright vert sp<cr>")
map({"n", "v"}, "<leader>wk", "<cmd>leftabove hor sp<cr>")
map({"n", "v"}, "<leader>wh", "<cmd>leftabove vert sp<cr>")
map({"n", "v"}, "<leader>wj", "<cmd>belowright hor sp<cr>")

-- resize window
map("n", "<C-Up>",    "<cmd> resize +5<cr>")
map("n", "<C-Down>",  "<cmd> resize -5<cr>")
map("n", "<C-Right>", "<cmd> vertical resize +5<cr>")
map("n", "<C-Left>",  "<cmd> vertical resize -5<cr>")

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

-- PLUGINS
-- fzf keymaps
local fzf = require("fzf-lua")
map("n", "<leader>gf", fzf.files)
map("n", "<leader>gb", fzf.buffers)
map("n", "<leader>l", fzf.blines)
map("n", "/", fzf.live_grep)

fzf.setup({
    keymap = {
              builtin = {
                  ["<S-j>"] = "preview-down",
                  ["<S-k>"] = "preview-up",
                  ["<S-down>"]    = "preview-page-down",
                  ["<S-up>"]      = "preview-page-up",
              }
          }
      })
-- oil keymaps
local oil = require("oil")
-- open current file's directory
map("n", "<leader>e", oil.open)

-- harpoon keymaps
local harpoon = require("harpoon")
map("n", "<leader>ha", function() harpoon:list():add() end)
map("n", "<leader>hl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
map("n", "<leader>1", function() harpoon:list():select(1) end)
map("n", "<leader>2", function() harpoon:list():select(2) end)
map("n", "<leader>3", function() harpoon:list():select(3) end)
map("n", "<leader>4", function() harpoon:list():select(4) end)

-- undotree keymaps
map("n", "<leader>u", "<cmd>UndotreeToggle<cr>")

-- lsp
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(e)
        local opts = {buffer = e.buf}
        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    end,
})
