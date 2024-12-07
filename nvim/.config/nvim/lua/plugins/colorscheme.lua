return {

    -- tokyonight
    -- {
    --     "folke/tokyonight.nvim",
    --     enabled = true,
    --     lazy = true,
    --     opts = {
    --         style = "moon",
    --     },
    -- },

    -- catppuccin
    -- { "catppuccin/nvim",
    --     enabled = true,
    --     lazy = true,
    --     name = "catppuccin",
    --     opts = {
    --         integrations = {
    --             aerial = true,
    --             alpha = true,
    --             cmp = true,
    --             dashboard = true,
    --             flash = true,
    --             grug_far = true,
    --             gitsigns = true,
    --             headlines = true,
    --             illuminate = true,
    --             indent_blankline = { enabled = true },
    --             leap = true,
    --             lsp_trouble = true,
    --             mason = true,
    --             markdown = true,
    --             mini = true,
    --             native_lsp = {
    --                 enabled = true,
    --                 underlines = {
    --                     errors = { "undercurl" },
    --                     hints = { "undercurl" },
    --                     warnings = { "undercurl" },
    --                     information = { "undercurl" },
    --                 },
    --             },
    --             navic = { enabled = true, custom_bg = "lualine" },
    --             neotest = true,
    --             neotree = true,
    --             noice = true,
    --             notify = true,
    --             semantic_tokens = true,
    --             telescope = true,
    --             treesitter = true,
    --             treesitter_context = true,
    --             which_key = true,
    --         },
    --     },
    -- },

    -- kanagawa
    {
        "rebelot/kanagawa.nvim",
        enabled = true,
        name = "kanagawa",
        lazy = true,
        opts = {
            colors = {
                theme = {
                    all = {
                        ui = {
                            bg_gutter = "none"
                        }
                    }
                }
            },
            overrides = function(colors) -- add/modify highlights
                local theme = colors.theme
                return {
                    -- better cmp menu colors
                    Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
                    PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                    PmenuSbar = { bg = theme.ui.bg_m1 },
                    PmenuThumb = { bg = theme.ui.bg_p2 },

                    -- transparent floating windows
                    NormalFloat = { bg = "none" },
                    FloatBorder = { bg = "none" },
                    FloatTitle = { bg = "none" },

                    -- Save an hlgroup with dark background and dimmed foreground
                    -- so that you can use it where your still want darker windows.
                    -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
                    NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

                    -- Popular plugins that open floats will link to NormalFloat by default;
                    -- set their background accordingly if you wish to keep them dark and borderless
                    LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                    MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                }
            end,
            theme = "wave",      -- Load "wave" theme when 'background' option is not set
            background = {       -- map the value of 'background' option to a theme
                dark = "dragon", -- try "dragon" !
                light = "lotus"
            },
        }
    },

    -- {
    --     "sho-87/kanagawa-paper.nvim",
    --     lazy = true,
    -- },

    -- {
    --     "rose-pine/neovim",
    --     name = "rose-pine",
    --     lazy = true,
    --     opts = {
    --         styles = {
    --             transparency = true,
    --         },
    --     },
    -- },

    -- lackluster
    -- {
    --     "slugbyte/lackluster.nvim",
    --     lazy = true,
    --     opts = function()
    --         local lackluster = require("lackluster")
    --         return {
    --             tweak_syntax = {
    --                 comment = lackluster.color.gray5,
    --             },
    --             tweak_background = {
    --                 normal = "default", -- main background
    --                 -- normal = "none", -- transparent
    --             },
    --             tweak_highlight = {
    --                 FloatBorder = {
    --                     overwrite = true,
    --                     fg = lackluster.color.gray5,
    --                     bg = "NONE",
    --                 },
    --                 ["@keyword"] = {
    --                     overwrite = true,
    --                     bold = false,
    --                     italic = true,
    --                     fg = lackluster.color.gray6,
    --                 },
    --                 ["@keyword.return"] = {
    --                     overwrite = true,
    --                     bold = false,
    --                     italic = true,
    --                     fg = lackluster.color.green,
    --                 },
    --             },
    --         }
    --     end,
    -- },

    {
        "zenbones-theme/zenbones.nvim",
        dependencies = "rktjmp/lush.nvim",
        lazy = true,
    },

    {
        'kdheepak/monochrome.nvim',
        lazy = true,
    },

    {
        'sainnhe/sonokai',
        lazy = true,
        config = function()
        end,
    },

    -- {
    --     "ronisbr/nano-theme.nvim",
    --     lazy = true,
    -- },

    {
        "EdenEast/nightfox.nvim",
        lazy = true,
        opts = {
            options = {
                transparent = false,
            },
        }
    },


    {
        'ishan9299/nvim-solarized-lua',
        lazy = true,
    },

    {
        'mhartington/oceanic-next',
        lazy = true,
    },

    {
        'Shatur/neovim-ayu',
        lazy = true,
    },

    {
        'sainnhe/gruvbox-material',
        lazy = true,
    },

    -- { "ellisonleao/gruvbox.nvim", lazy = true, },

    -- {
    --     "savq/melange-nvim",
    --     lazy = true
    -- },

    {
        'navarasu/onedark.nvim',
        lazy = true,
        opts = {
            style = "darker"
        }
    },

    {
        'deparr/tairiki.nvim',
        lazy = true,
    },

    -- {
    --     "vague2k/vague.nvim",
    --     lazy = true
    -- },

}
