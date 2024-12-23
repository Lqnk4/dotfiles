-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

--source plugins
require("config.lazy")

vim.cmd [[colorscheme cold]]


require("config.options")
require("config.keymaps")
