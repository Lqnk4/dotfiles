local M = {
    {
        "zenbones-theme/zenbones.nvim",
        dependencies = "rktjmp/lush.nvim",
    },

    {
        "gmr458/cold.nvim",
    },

    {
        "navarasu/onedark.nvim",
    },

    {
        "slugbyte/lackluster.nvim",
    },

    {
        'deparr/tairiki.nvim',
    },

    {
        'kdheepak/monochrome.nvim',
    },

    {
        'metalelf0/base16-black-metal-scheme',
    },

}

for _, colorscheme_plugin in ipairs(M) do
    colorscheme_plugin["lazy"] = true
end

return M
