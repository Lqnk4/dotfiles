return {
    {
        "mrcjkb/haskell-tools.nvim",
        version = "^4",
        ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
        dependencies = {
            { "nvim-telescope/telescope.nvim", optional = true },
        },
        config = function()
            local ok, telescope = pcall(require, "telescope")
            if ok then
                telescope.load_extension("ht")
            end
        end,
    },

    {
        "mrcjkb/haskell-snippets.nvim",
        dependencies = { "L3MON4D3/LuaSnip" },
        ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
        config = function()
            local haskell_snippets = require("haskell-snippets").all
            require("luasnip").add_snippets("haskell", haskell_snippets, { key = "haskell" })
        end,
    },
}
