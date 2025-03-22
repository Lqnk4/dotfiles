return {
    {
        "mrcjkb/haskell-tools.nvim",
        version = "^4",
        ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
        dependencies = {
            -- { "nvim-telescope/telescope.nvim", optional = true },
        },
        init = function()
            local ht = require("haskell-tools")
            vim.g.haskell_tools = function()
                local ht_opts = {
                    hls = {
                        on_attach = function(client, bufnr, _)
                            require("config.lspkeymaps").default_on_attach(client, bufnr)
                        end
                    },
                    tools = {
                        repl = {
                            builtin = {
                                -- create_repl_window = ht.repl.View.create_repl_tabnew
                            }
                        },
                    }
                }
                return ht_opts
            end
        end,
        config = function()
            local ok, telescope = pcall(require, "telescope")
            if ok then
                telescope.load_extension("ht")
            end
        end,
    },

    {
        "mrcjkb/haskell-snippets.nvim",
        -- dependencies = { "L3MON4D3/LuaSnip" },
        ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
        config = function()
            local ok, haskell_snippets = pcall(require, "haskell-snippets")
            if ok then
                require("luasnip").add_snippets("haskell", haskell_snippets.all, { key = "haskell" })
            end
        end,
    },
}
