return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
        ensure_installed = {
            "c",
            "lua",
            "vim",
            "markdown",
            "powershell"
        },
        auto_install = true,
        highlight = {
            enable = true
        },
    }
}
