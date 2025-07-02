local bufnr = vim.api.nvim_get_current_buf()

vim.opt_local.shiftwidth = 3
vim.opt_local.softtabstop = 3

vim.opt_local.makeprg = 'alr build'

-- leaderkey conflict
vim.keymap.del('i', '<Space>aj', { buffer = bufnr })
vim.keymap.del('i', '<Space>al', { buffer = bufnr })
