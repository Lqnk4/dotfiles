local M = {
    'neovim/nvim-lspconfig',
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    dependencies = {

        {
            'williamboman/mason-lspconfig.nvim',
            dependencies = { 'williamboman/mason.nvim' },
        },
    }
}

return M
