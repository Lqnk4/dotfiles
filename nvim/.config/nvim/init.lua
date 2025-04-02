-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

--source plugins
require("config.lazy")

require("config.options")
require("config.keymaps")
require("config.statusline")

if vim.g.is_tty then
    vim.cmd [[colorscheme quiet]]
else
    vim.cmd [[colorscheme zenwritten]]
end


