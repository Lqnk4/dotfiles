local M = {
    {
        "zenbones-theme/zenbones.nvim",
        dependencies = "rktjmp/lush.nvim",
    },

    { "archseer/colibri.vim", },

    { "blazkowolf/gruber-darker.nvim" },

    -- {
    --     "ishan9299/nvim-solarized-lua",
    --     init = function()
    --         vim.g.solarized_statusline = 'flat'
    --     end,
    -- },

    -- { "maxmx03/solarized.nvim", },

    -- { "craftzdog/solarized-osaka.nvim", },

    -- { "folke/tokyonight.nvim" },

    -- { "rose-pine/neovim" },

    -- {
    --     "rebelot/kanagawa.nvim",
    --     opts = {
    --         background = {
    --             dark = "dragon",
    --             light = "lotus"
    --         },
    --         colors = {
    --             theme = {
    --                 all = {
    --                     ui = {
    --                         bg_gutter = "none"
    --                     }
    --                 }
    --             }
    --         },
    --         overrides = function(colors)
    --             local theme = colors.theme
    --             return {
    --                 Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
    --                 PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
    --                 PmenuSbar = { bg = theme.ui.bg_m1 },
    --                 PmenuThumb = { bg = theme.ui.bg_p2 },
    --             }
    --         end,
    --     },
    --
    -- },

    -- { "alexxGmZ/e-ink.nvim", },

    -- { "armannikoyan/rusty" },

    -- { "vague2k/vague.nvim" },

    {
        'Mofiqul/vscode.nvim',
        opts = function()
            local c = require('vscode.colors').get_colors()
            local darkbg = "#191919"
            local ret = {
                group_overrides = {
                    NormalFloat = { fg = "NONE", bg = darkbg },
                    BlinkCmpMenu = { fg = "NONE", bg = darkbg },
                    BlinkCmpDoc = { fg = "NONE", bg = darkbg },
                    BlinkCmpMenuBorder = { fg = c.vscGray },
                    BlinkCmpDocBorder = { fg = c.vscGray },
                }
            }

            return ret
        end
    },

    -- { "EdenEast/nightfox.nvim" },

    -- { "yorickpeterse/nvim-grey", },

    -- { "ronisbr/nano-theme.nvim" },

    {
        "miikanissi/modus-themes.nvim",
        opts = {
            line_nr_column_background = false,
            sign_column_background = true,
        }
    },

    -- { "bluz71/vim-moonfly-colors" },

    -- { "sainnhe/gruvbox-material" },

    -- { "deparr/tairiki.nvim", },

    -- {
    --     "psliwka/termcolors.nvim",
    --     cmd = "TermcolorsShow"
    -- },
}

for _, scheme in ipairs(M) do
    scheme["lazy"] = true
end

return M
