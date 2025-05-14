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
                ---@class haskell-tools.Config haskell-tools.nvim plugin configuration.
                local ht_opts = {
                    ---@class haskell-tools.tools.Config haskell-tools module config.
                    tools = {
                        ---@class haskell-tools.repl.Config GHCi repl options.
                        repl = {
                            ---@class haskell-tools.repl.builtin.Config Configuration for the builtin repl
                            builtin = {
                                ---@type fun(view:haskell-tools.repl.View):fun(mk_repl_cmd:mk_ht_repl_cmd_fun) How to create the repl window. Should return a function that calls one of the `ReplView`'s functions.
                                -- create_repl_window = function(view)
                                --     return view.create_repl_vsplit({ size = 6})
                                -- end
                            }
                        }
                    }
                }
                return ht_opts
            end
        end,
    },

    {
        "neovimhaskell/haskell-vim",
        enabled = false,
        ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
    }
}
