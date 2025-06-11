local M = {

    { 'huyvohcmc/atlas.vim', },

    -- { "ribru17/bamboo.nvim" },

    -- { "gmr458/cold.nvim", },

    { "archseer/colibri.vim", },

    -- { "alexxGmZ/e-ink.nvim", },

    -- {
    --     "amedoeyes/eyes.nvim"
    -- },

    -- { "yorickpeterse/nvim-grey", },

    {
        -- Custom fork
        "Lqnk4/gruber-darker.nvim",
        enabled = true,
        opts = {
            italic = {
                strings = false,
                comments = false,
            },
        }
    },

    -- { "morhetz/gruvbox" },

    -- { "sainnhe/gruvbox-material" },

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

    -- { "grosheth/kaolin.nvim" },

    { "slugbyte/lackluster.nvim" },

    -- { "ronisbr/nano-theme.nvim" },

    { "EdenEast/nightfox.nvim" },

    -- { "savq/melange-nvim" },

    {
        "miikanissi/modus-themes.nvim",
        opts = {
            variant = "tinted",
            -- line_nr_column_background = false,
            -- sign_column_background = true,
            styles = {
                comments = { italic = false },
                keywords = { italic = false },
            },
        }
    },

    -- {
    --     "navarasu/onedark.nvim",
    --     opts = {
    --         style = 'warmer',
    --     }
    -- },

    -- { "nyoom-engineering/oxocarbon.nvim" },

    -- { "rose-pine/neovim" },

    -- { "armannikoyan/rusty" },

    {
        "ishan9299/nvim-solarized-lua",
        init = function()
            vim.g.solarized_statusline = 'flat'
        end,
    },

    -- { "maxmx03/solarized.nvim", },

    -- { "craftzdog/solarized-osaka.nvim", },

    {
        "sainnhe/sonokai"
    },

    -- { "deparr/tairiki.nvim", },

    -- { "folke/tokyonight.nvim" },

    -- { "vague2k/vague.nvim" },

    -- { "bluz71/vim-moonfly-colors" },

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

    -- {
    --     "zenbones-theme/zenbones.nvim",
    --     dependencies = { "rktjmp/lush.nvim", lazy = true },
    -- },
}

for _, scheme in ipairs(M) do
    scheme["lazy"] = true
end

return M
