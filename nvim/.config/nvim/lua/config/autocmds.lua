local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd


-----------------------------------------------------------
-- General settings
-----------------------------------------------------------

-- Highlight on yank
augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
    group = 'YankHighlight',
    callback = function()
        vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '1000' })
    end
})

-----------------------------------------------------------
-- Settings for filetypes
-----------------------------------------------------------

-- Set indentation to 2 spaces
augroup('setIndent', { clear = true })
autocmd('Filetype', {
    group = 'setIndent',
    -- filetypes
    pattern = {},
    command = 'setlocal shiftwidth=2 tabstop=2'
})

-----------------------------------------------------------
-- Terminal settings
-----------------------------------------------------------
