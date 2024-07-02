-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

--source plugins
require("config.lazy")

--source vim options, keymaps 
require("config.options")
require("config.keymaps")
require("config.autocmds")

