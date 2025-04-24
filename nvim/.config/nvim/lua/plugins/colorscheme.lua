local M = {
    {
        "zenbones-theme/zenbones.nvim",
        dependencies = "rktjmp/lush.nvim",
    },

    { "blazkowolf/gruber-darker.nvim" },

    {
        "ishan9299/nvim-solarized-lua",
        init = function()
            vim.g.solarized_statusline = 'flat'
        end,
    },

    -- { "maxmx03/solarized.nvim", },

    -- { "craftzdog/solarized-osaka.nvim", },

    -- { "folke/tokyonight.nvim" },

    -- { "rose-pine/neovim" },

    -- { "rebelot/kanagawa.nvim" },

    -- { "alexxGmZ/e-ink.nvim", },

    -- { "armannikoyan/rusty" },

    -- { "vague2k/vague.nvim" },

    { 'Mofiqul/vscode.nvim', },

    { "EdenEast/nightfox.nvim" },

    { "yorickpeterse/nvim-grey", },

    { "ronisbr/nano-theme.nvim" },

}

for _, scheme in ipairs(M) do
    scheme["lazy"] = true
end

return M
