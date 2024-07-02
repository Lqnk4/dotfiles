local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

local default_setup = function(server)
    require('lspconfig')[server].setup({
        capabilities = lsp_capabilities,
    })
end

local lua_ls = function()
    require('lspconfig').lua_ls.setup({
        capabilities = lsp_capabilities,
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT'
                },
                diagnostics = {
                    globals = { 'vim' },
                },
                workspace = {
                    library = {
                        vim.env.VIMRUNTIME,
                    }
                }
            }
        }
    })
end

local M = {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'neovim/nvim-lspconfig', 'williamboman/mason.nvim', },
    opts = {
        ensure_installed = { "lua_ls", "rust_analyzer", "clangd", "jedi_language_server", },
        handlers = {
            default_setup,
            ["lua_ls"] = lua_ls,
        },
    },
}

return M
