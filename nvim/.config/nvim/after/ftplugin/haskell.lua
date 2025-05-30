vim.opt_local.makeprg = "cabal"
vim.cmd('compiler ghc')

local ht = require('haskell-tools')
local bufnr = vim.api.nvim_get_current_buf()

local map = vim.keymap.set

local function opts(desc)
    return { noremap = true, silent = true, buffer = bufnr, desc = "Haskell " .. desc }
end

--| hls
map('n', '<space>cl', vim.lsp.codelens.run, opts "Codelens")
-- Hoogle search for the type signature of the definition under the cursor
map('n', '<leader>Hs', ht.hoogle.hoogle_signature, opts "[H]oogle [s]ignature")
-- Evaluate all code snippets
map('n', '<leader>ea', ht.lsp.buf_eval_all, opts "[e]val [a]ll")

--| GHCi
map('n', '<leader>rr', ht.repl.toggle, opts "toggle [r]epl")
map('n', '<leader>rf', function()
    ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, opts "[r]epl toggle with [f]ile")
map('n', '<leader>rl', ht.repl.reload, opts "[r]epl [r]eload")
map('n', '<leader>rq', ht.repl.quit, opts "[r]epl [q]uit")
map('n', '<leader>rp', ht.repl.paste, opts "[r]epl [p]aste")
map('n', '<leader>rt', ht.repl.paste_type, opts "[r]epl paste [t]ype from <register>")
map('n', '<leader>rw', ht.repl.paste_type, opts "[r]epl type of <c[w]ord>")

--| Build
map('n', '<leader>mc', ht.project.open_project_file, opts "Open project file")
