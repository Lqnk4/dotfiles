local M = {
    'neovim/nvim-lspconfig',
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    dependencies = {

        {
            'williamboman/mason.nvim',
            dependencies = {
                { 
                    'williamboman/mason-lspconfig.nvim',
                    lazy = true,
                    event = { "VeryLazy" }
                },
            },
            lazy = true,
            build = ":MasonUpdate",
            cmd = { "Mason", "MasonLog" },
            event = { "VeryLazy" },
        },
    }
}

return M
