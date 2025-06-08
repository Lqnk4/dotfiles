return {
    {
        'saghen/blink.cmp',
        enabled = true,
        event = "InsertEnter",
        dependencies = {'rafamadriz/friendly-snippets', lazy = true},
        version = '*',
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = 'default',
            },
            appearance = {
                -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                -- Useful for when your theme doesn't support blink.cmp
                -- Will be removed in a future release
                use_nvim_cmp_as_default = false,
                -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'normal'
            },
            completion = {
                accept = {
                    auto_brackets = {
                        enabled = false,
                    },
                },
                list = {
                    selection = {
                        preselect = false,
                        auto_insert = false,
                    },
                },
                menu = {
                    auto_show = true, -- show the completion menu automatically
                    draw = {
                        columns = { { "label", "label_description", gap = 2 }, { "kind" } },
                        treesitter = { "lsp" },
                    },
                    -- border = "single",
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                    update_delay_ms = 50,
                    window = {
                        -- border = "single",
                    },
                },
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },

            cmdline = {
                enabled = false,
            },
            snippets = { preset = 'default' },
            signature = { enabled = true },
        },
    },

    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {
            disable_filetype = { "lean" }
        }
    },

    -- {
    --     "echasnovski/mini.pairs",
    --     event = "VeryLazy",
    --     opts = {
    --         modes = { insert = true, command = true, terminal = false },
    --         -- skip autopair when next character is one of these
    --         skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
    --         -- skip autopair when the cursor is inside these treesitter nodes
    --         skip_ts = { "string" },
    --         -- skip autopair when next character is closing pair
    --         -- and there are more closing pairs than opening pairs
    --         skip_unbalanced = true,
    --         -- better deal with markdown code blocks
    --         markdown = true,
    --     },
    -- },

    {
        "echasnovski/mini.ai",
        event = "VeryLazy",
        opts = {},
    },

    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        opts = {},
    }

}
