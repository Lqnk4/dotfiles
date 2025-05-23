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

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client then
            client.server_capabilities.semanticTokensProvider = nil
        end
    end,
})
