local bufnr = vim.api.nvim_get_current_buf()

-- leaderkey conflict
vim.keymap.del('i', '<Space>aj', { buffer = bufnr })
vim.keymap.del('i', '<Space>al', { buffer = bufnr })
