return {
    'neovim/nvim-lspconfig',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    -- mason responsible for downloading lsps
    'williamboman/mason.nvim',
    -- hackyway to do this
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            local cmp_nvim_lsp = require("cmp_nvim_lsp")
            local lspconfig_default = require("lspconfig").util.default_config
            local mason = require('mason')
            local mason_lspconfig = require("mason-lspconfig")
            lspconfig_default.capabilities = vim.tbl_deep_extend(
                'force',
                lspconfig_default.capabilities,
                cmp_nvim_lsp.default_capabilities()
            )
            mason.setup()
            mason_lspconfig.setup({
                ensure_installed = {
                    "lua_ls",
                    "clangd",
                    "pyright",
                    "marksman"
                },
                handlers = {
                    function(server_name)
                        require("lspconfig")[server_name].setup({})
                    end,
                },
            })
        end
    },
}
