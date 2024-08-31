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

-- toggle inlay hints
map('n', '<leader>h', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end)

-- terminal.nvim
local term_map = require("terminal.mappings")
map('t', '<Esc>', '<C-\\><C-n>')
map({ "n", "x" }, "<leader>ts", term_map.operator_send, { expr = true })
map("n", "<leader>to", term_map.toggle)
map("n", "<leader>tO", term_map.toggle({ open_cmd = "enew" }))
map("n", "<leader>tr", term_map.run)
map("n", "<leader>tR", term_map.run(nil, { layout = { open_cmd = "enew" } }))
map("n", "<leader>tk", term_map.kill)
map("n", "<leader>t]", term_map.cycle_next)
map("n", "<leader>t[", term_map.cycle_prev)
map("n", "<leader>tl", term_map.move({ open_cmd = "belowright vnew" }))
map("n", "<leader>tL", term_map.move({ open_cmd = "botright vnew" }))
map("n", "<leader>th", term_map.move({ open_cmd = "belowright new" }))
map("n", "<leader>tH", term_map.move({ open_cmd = "botright new" }))
map("n", "<leader>tf", term_map.move({ open_cmd = "float" }))


