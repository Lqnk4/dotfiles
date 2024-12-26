-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

--source plugins
require("config.lazy")

require("config.options")
require("config.keymaps")

if vim.g.is_tty then
    vim.cmd [[colorscheme lackluster]]
else
    vim.cmd [[colorscheme cold]]
end


