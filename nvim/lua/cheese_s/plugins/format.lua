return {
    'stevearc/conform.nvim',
    dependencies = {
        'williamboman/mason.nvim',
    },
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            c = { "clang_format" },
            python = { "yapf" },
            markdonw = { "mdformat" }
        },
        format_on_save = {
            async = false,
            quiet = false,
            lsp_format = "fallback"
        }
    }
}
