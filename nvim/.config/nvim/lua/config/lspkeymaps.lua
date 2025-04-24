local map = vim.keymap.set

local M = {}

---@param bufnr number
---@return nil
M.default_on_attach = function(_, bufnr)
    local function opts(desc)
        return { buffer = bufnr, desc = "LSP " .. desc }
    end

    map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
    map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
    map("n", "<leader>cd", vim.lsp.buf.definition, opts "Go to definition")
    -- map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation") -- builtin "gri"
    -- map("n", "<leader>ci", vim.lsp.buf.implementation, opts "Go to implementation")
    map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help") -- builtin {i, s}, "<C-s>"

    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")
    map("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts "List workspace folders")

    map("n", "<leader>ct", vim.lsp.buf.type_definition, opts "Go to type definition")
    map("n", "<leader>cr", vim.lsp.buf.rename, opts "Rename symbol") -- builtin "grn"

    -- map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action") -- builtin "gra"

    -- map("n", "gr", vim.lsp.buf.references, opts "Show references") -- builtin "grr"
    map("n", "<leader>cD", vim.lsp.buf.references, opts "Show references")

    map({ "n", "x" }, "<leader>cf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts "Format Buffer")
    map({ "n", "x" }, "grf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts "Format Buffer")
end

return M
