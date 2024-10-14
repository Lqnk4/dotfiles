-- Set filetype to `bigfile` for files larger than 1.5 MB
-- Only vim syntax will be enabled (with the correct filetype)
-- LSP, treesitter and other ft plugins will be disabled.
vim.g.bigfile_size = 1024 * 1024 * 1.5 -- 1.5 MB

local opt = vim.opt

vim.opt.background = "dark"

opt.number = true         -- Print line number
opt.relativenumber = true -- Relative line numbers

opt.guicursor = "n-v-i-c:block-Cursor"

opt.tabstop = 4      -- Size of a tab
opt.shiftwidth = 4   -- Size of an indent
opt.softtabstop = 4
opt.expandtab = true -- Use spaces instead of tabs
opt.breakindent = true

-- opt.clipboard = "unnamedplus" -- sync system clipboard

opt.completeopt = "menu,menuone,noselect"

opt.conceallevel = 2   -- Hide * markup for bold and italic, but not markers with substitutions
opt.confirm = false   -- Confirm to save changes before exiting modified buffer
opt.cursorline = false -- Highlighting of the current line
opt.fillchars = {
    foldopen = "",
    foldclose = "",
    fold = " ",
    foldsep = " ",
    diff = "╱",
    eob = " ",
}

opt.foldlevel = 99

opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"

opt.ignorecase = true      -- Ignore case
opt.smartcase = true       -- Don't ignore case with capitals

opt.inccommand = "nosplit" -- preview incremental substitute
opt.jumpoptions = "view"

opt.showmode = false -- statusline is configured
opt.laststatus = 3         -- global statusline

opt.wrap = false         -- Disable line wrap
opt.linebreak = true     -- Wrap lines at convenient points

opt.termguicolors = true -- True color support

opt.undofile = true
opt.undolevels = 10000

opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.smoothscroll = true

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
