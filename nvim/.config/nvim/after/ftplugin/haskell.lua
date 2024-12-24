-- ~/.config/nvim/after/ftplugin/haskell.lua
local ht = require('haskell-tools')
local bufnr = vim.api.nvim_get_current_buf()

local function opts(desc)
    return { noremap = true, silent = true, buffer = bufnr, desc = "Haskell " .. desc }
end

require("config.lspconfig").on_attach({}, bufnr)

vim.keymap.set('n', '<space>cl', vim.lsp.codelens.run, opts "Codelens")
-- Hoogle search for the type signature of the definition under the cursor
vim.keymap.set('n', '<leader>hs', ht.hoogle.hoogle_signature, opts "Hoogle signature")
-- Evaluate all code snippets
vim.keymap.set('n', '<leader>ea', ht.lsp.buf_eval_all, opts "Eval all")
-- Toggle a GHCi repl for the current package
vim.keymap.set('n', '<leader>rr', ht.repl.toggle, opts "Toggle repl package")
-- Toggle a GHCi repl for the current buffer
vim.keymap.set('n', '<leader>rf', function()
    ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, opts "Toggle repl buffer")
vim.keymap.set('n', '<leader>rq', ht.repl.quit, opts "Repl quit")
