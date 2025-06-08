local map = vim.keymap.set

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- move to window using the <ctrl> hjkl keys
-- map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
-- map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
-- map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
-- map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- transpose
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Transpose Line Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Transpose Line Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Transpose Line Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Transpose Line Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Transpose Line Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Transpose Line Up" })

-- buffers
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })

map("n", "<leader>br", "<cmd>earlier 1f<cr>", { desc = "Revert Buffer" })

map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Kill Buffer" })
map("n", "<leader>bk", "<cmd>bdelete<cr>", { desc = "Kill Buffer" })
map("n", "<leader>bK", "<cmd>%bd<cr>", { desc = "Kill All Buffers" })
map("n", "<leader>bO", "<cmd>%bd|e#<cr>", { desc = "Kill All Other Buffers" })

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- file manager
map("n", "<leader>pv", "<cmd>Ex<cr>", { desc = "Netrw" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
    "n",
    "<leader>ur",
    "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
    { desc = "Redraw / Clear hlsearch / Diff Update" }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

--keywordprg
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- commenting
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- quickfix
map('n', "<leader>q", "<cmd>copen<cr>", { desc = "Open Quickfix" })
map('n', "<leader>Q", "<cmd>cclose<cr>", { desc = "Close Quickfix" })

-- lsp
map("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
map({ "n", "x" }, "<leader>cf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", { desc = "Format Buffer" })
map({ "n", "x" }, "grf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", { desc = "Format Buffer" })

-- diagnostic
map("n", "]e", function() vim.diagnostic.jump({ count = 1, severity = "ERROR" }) end, { desc = "Next Diagnostic" })
map("n", "[e", function() vim.diagnostic.jump({ count = -1, severity = "ERROR" }) end, { desc = "Next Diagnostic" })
map("n", "]w", function() vim.diagnostic.jump({ count = 1, severity = "WARN" }) end, { desc = "Next Diagnostic" })
map("n", "[w", function() vim.diagnostic.jump({ count = -1, severity = "WARN" }) end, { desc = "Next Diagnostic" })
map('n', 'gK', function()
    local virtual_lines = not vim.diagnostic.config().virtual_lines
    local virtual_text = not vim.diagnostic.config().virtual_text
    vim.diagnostic.config({ virtual_lines = virtual_lines, virtual_text = virtual_text })
end, { desc = 'Toggle diagnostic virtual lines and text' })

-- highlights under cursor
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
map("n", "<leader>uI", "<cmd>InspectTree<cr>", { desc = "Inspect Tree" })

-- command line
map("c", "<C-a>", "<Home>", { desc = "Goto beginning of line" })
map("c", "<C-e>", "<End>", { desc = "Goto end of line" })
map("c", "<C-f>", "<Right>", { desc = "Forward one character" })
map("c", "<C-b>", "<Left>", { desc = "Backward one character" })
map("c", "<M-f>", "<S-Right>", { desc = "Forward one word" })
map("c", "<M-b>", "<S-Left>", { desc = "Backward one word" })
map("c", "<C-d>", "<Del>", { desc = "Delete character in front of cursor" })

-- terminal
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
-- map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to Left Window" })
-- map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to Lower Window" })
-- map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to Upper Window" })
-- map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to Right Window" })
