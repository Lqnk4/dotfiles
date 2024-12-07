-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

--source plugins
require("config.lazy")

-- setup globals
require("config.options")

--set colorscheme
if vim.g.has_display and not vim.g.vscode then
    vim.cmd [[colorscheme monochrome]]
end

--source vim options, keymaps
require("config.keymaps")
require("config.autocmds")
