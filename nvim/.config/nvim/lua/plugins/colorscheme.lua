local M = {
    {
        "zenbones-theme/zenbones.nvim",
        dependencies = "rktjmp/lush.nvim",
    },

    { 'kdheepak/monochrome.nvim' },

    { "blazkowolf/gruber-darker.nvim" },

    { "pgdouyon/vim-yin-yang" },

    { "ronisbr/nano-theme.nvim" },
}

for _, scheme in ipairs(M) do
    scheme["lazy"] = true
end

return M
