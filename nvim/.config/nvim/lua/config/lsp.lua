vim.lsp.enable({
    -- 'ada_ls',
    'clangd',
    'lua-language-server',
    'pyright',
    'zls',
})

vim.diagnostic.config({
    virtual_text = true,
})
