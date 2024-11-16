-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

--source plugins
require("config.lazy")

if vim.g.vscode then
    goto colorschemedone
end

--set colorscheme
vim.cmd [[colorscheme melange]]

::colorschemedone::

--source vim options, keymaps
require("config.options")
require("config.keymaps")
require("config.autocmds")
