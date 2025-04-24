local bufnr = vim.api.nvim_get_current_buf()
local cmd = vim.cmd

local map = vim.keymap.set

local function opts(desc)
    return { noremap = true, silent = true, buffer = bufnr, desc = "Rust " .. desc }
end

map("n", "K", function() cmd.RustLsp({ 'hover', 'actions' }) end, opts "Hover")
map("n", "gra", function() cmd.RustLsp('codeAction') end, opts "Code Action")
-- map("n", "gem", function() cmd.RustLsp('expandMacro') end, opts "Expand Macro")
map("n", "J", function() cmd.RustLsp('joinLines') end, opts "Join Lines")
