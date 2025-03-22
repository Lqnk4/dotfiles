local map = vim.keymap.set

return {
    "neovim/nvim-lspconfig",
    dependencies = { 'saghen/blink.cmp' },
    event = { "BufReadPost", "BufNewFile", "BufWritePre", },
    opts = {
        servers = {
            clangd = {
                keys = function(_, bufnr)
                    local function opts(desc)
                        return { buffer = bufnr, desc = "Clangd " .. desc }
                    end
                    map("n", "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", opts "Switch Source/Header (C/C++)")
                    map("n", "<leader>si", "<cmd>ClangdShowSymbolInfo<cr>", opts "Show Symbol Info")
                end
            },
            lua_ls = {
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
            },
            zls = {},
        },
    },
    config = function(_, opts)
        local lspconfig = require('lspconfig')


        for server, config in pairs(opts.servers) do

            config.on_attach = function(_, bufnr)
                require("config.lspkeymaps").default_on_attach(_, bufnr)
                if config.keys ~= nil then
                    config.keys(_, bufnr)
                end
            end

            config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
            lspconfig[server].setup(config)
        end

    end
}
