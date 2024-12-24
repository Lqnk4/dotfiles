local M = {}
local map = vim.keymap.set

M.on_attach = function(_, bufnr)
    local function opts(desc)
        return { buffer = bufnr, desc = "LSP " .. desc }
    end

    map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
    map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
    map("n", "<leader>cd", vim.lsp.buf.definition, opts "Go to definition")
    map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
    map("n", "<leader>ci", vim.lsp.buf.implementation, opts "Go to implementation")
    map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")

    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")
    map("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts "List workspace folders")

    map("n", "<leader>ct", vim.lsp.buf.type_definition, opts "Go to type definition")
    map("n", "<leader>cr", vim.lsp.buf.rename, opts "Go to type definition")

    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")

    map("n", "gr", vim.lsp.buf.references, opts "Show references")
    map("n", "<leader>cD", vim.lsp.buf.references, opts "Show references")

    map({ "n", "x" }, "<leader>cf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts "Format Buffer")
end

M.on_init = function(client, _)

end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    },
}


local lspconfig = require("lspconfig")

M.defaults = function(servers)
    lspconfig.lua_ls.setup {
        on_attach = M.on_attach,
        capabilities = M.capabilities,
        on_init = M.on_init,

        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    library = {
                        vim.env.VIMRUNTIME,
                        "${3rd}/luv/library",
                    },
                    maxPreload = 100000,
                    preloadFileSize = 10000,
                },
            },
        },
    }

    for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
            on_attach = M.on_attach,
            capabilities = M.capabilities,
            on_init = M.on_init,
        }
    end
end


return M
