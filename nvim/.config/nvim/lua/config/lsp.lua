vim.lsp.enable({
    -- 'ada_ls',
    'clangd',
    'gopls',
    'lua-language-server',
    'pyright',
    'zls',
})

vim.diagnostic.config({
    severity_sort = true,
    virtual_text = true,
    -- underline = false,
    -- float = { border = "rounded" }
})

-- vim.keymap.set('n', 'K', function() vim.lsp.buf.hover({ border = 'single' }) end)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local bufnr = ev.buf
        if client then
            client.server_capabilities.semanticTokensProvider = nil

            -- TODO: Look into this
            -- vim.lsp.completion.enable(true, client.id, bufnr, {
            --     autotrigger = true,
            --     convert = function(item)
            --         return { abbr = item.label:gsub('%b()', '')}
            --     end
            -- })
        end


    end,
})
