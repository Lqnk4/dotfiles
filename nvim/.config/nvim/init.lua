-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

--source plugins
require("config.lazy")

--set colorscheme
vim.cmd [[colorscheme lackluster]]

--source vim options, keymaps
require("config.options")
require("config.keymaps")
require("config.autocmds")
