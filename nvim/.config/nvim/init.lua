-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

--source plugins
require("config.lazy")

require("config.options")
require("config.keymaps")
-- require("config.statusline")

if vim.g.is_tty then
    vim.cmd [[colorscheme quiet]]
else
    vim.cmd [[colorscheme gruber-darker]]
    -- vim.api.nvim_set_hl(0, "SignColumn", { bg = vim.api.nvim_get_hl(0, { name = "LineNr" }).bg })
end


