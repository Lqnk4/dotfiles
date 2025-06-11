local g = vim.g
local opt = vim.opt
local env = vim.env

g.is_tty = env.TERM == 'linux'

opt.background = "dark"

opt.number = true         -- Print line number
opt.relativenumber = true -- Relative line numbers
opt.signcolumn = "yes"    -- When and how to draw the signcolumn.
opt.cursorline = true
opt.cursorlineopt = "number"     -- Highlighting of the current line

vim.o.cmdheight = 1       -- Size of commands line

-- vim.o.winborder = "single" -- global floatborder

opt.guicursor = "n-v-i-c:block-Cursor"

opt.mouse = ""

opt.tabstop = 4      -- Size of a tab
opt.shiftwidth = 4   -- Size of an indent
opt.softtabstop = 4
opt.expandtab = true -- Use spaces instead of tabs
opt.breakindent = true

-- opt.clipboard = "unnamedplus" -- sync system clipboard

opt.completeopt = "menu,menuone,noselect,popup,fuzzy"

opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
opt.confirm = false  -- Confirm to save changes before exiting modified buffer
-- opt.fillchars = {
--     foldopen = "",
--     foldclose = "",
--     fold = " ",
--     foldsep = " ",
--     diff = "╱",
--     eob = " ",
-- }

opt.foldlevel = 99

opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"

opt.ignorecase = true      -- Ignore case
opt.smartcase = true       -- Don't ignore case with capitals

opt.inccommand = "nosplit" -- preview incremental substitute
opt.jumpoptions = "view"

opt.showmode = true
opt.laststatus = 2       -- global statusline

opt.wrap = false         -- Disable line wrap
opt.linebreak = true     -- Wrap lines at convenient points

opt.termguicolors = true -- True color support

opt.undofile = true
opt.undolevels = 10000

opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.smoothscroll = true

-- Fix markdown indentation settings
-- vim.g.markdown_recommended_style = 0

-- Prevent LSP from overwriting treesitter color settings
-- https://github.com/NvChad/NvChad/issues/1907
--vim.highlight.priorities.semantic_tokens = 95
