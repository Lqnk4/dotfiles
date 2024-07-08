local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        if opts.desc then
            opts.desc = "keymaps.lua: " .. opts.desc
        end
        options = vim.tbl_extend('force', options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- Oil file manager
map("n", "<leader>pv", '<cmd>lua vim.cmd.Oil()<cr>')

-- buffers
map("n", "[b", ":bp<cr>", {})
map("n", "]b", ":bn<cr>", {})

-- move lines up or down
map( {'n', 'i', 'v' }, '<A-j>', '<cmd>:m .+1<CR>')
map( {'n', 'i', 'v' }, '<A-k>', '<cmd>:m .-2<CR>')
