-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

--source plugins
require("config.lazy")

require("config.options")
require("config.keymaps")

if not vim.g.is_tty then
    vim.cmd [[colorscheme cold]]
else
    vim.cmd [[colorscheme lackluster]]
end


