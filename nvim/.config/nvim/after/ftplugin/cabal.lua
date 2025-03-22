local ht = require("haskell-tools")
local bufnr = vim.api.nvim_get_current_buf()

local function opts(desc)
    return { noremap = true, silent = true, buffer = bufnr, desc = "Haskell " .. desc }
end

--| GHCi
-- Toggle a GHCi repl for the current package
vim.keymap.set('n', '<leader>rr', ht.repl.toggle, opts "Toggle repl package")
-- Toggle a GHCi repl for the current buffer
vim.keymap.set('n', '<leader>rf', function()
    ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, opts "Toggle repl buffer")
-- Reload a GHCi repl for the current buffer
vim.keymap.set('n', '<leader>rl', ht.repl.reload, opts "Reload repl modules")
-- Quit the GHCi repl
vim.keymap.set('n', '<leader>rq', ht.repl.quit, opts "Repl quit")
