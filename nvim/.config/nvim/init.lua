-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.lazy")
require("config.options")


if vim.g.is_tty then
    vim.cmd [[colorscheme modus_vivendi]]
else
    vim.cmd [[colorscheme atlas]]
end

require("config.keymaps")
require("config.lsp")



