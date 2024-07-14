local M = {
    {
    'hrsh7th/nvim-cmp',
    lazy = true,
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        lazy = true,
    },
    event = { "InsertEnter" },

    },
}

return M
