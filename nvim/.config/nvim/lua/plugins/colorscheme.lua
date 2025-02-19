local M = {
    {
        "zenbones-theme/zenbones.nvim",
        dependencies = "rktjmp/lush.nvim",
    },

    { "gmr458/cold.nvim", },

    { "navarasu/onedark.nvim", },

    { "slugbyte/lackluster.nvim", },

    { 'deparr/tairiki.nvim', },

    { 'kdheepak/monochrome.nvim' },

    { "blazkowolf/gruber-darker.nvim" },

}

for _, scheme in ipairs(M) do
    scheme["lazy"] = true
end

return M
