return {
    {
        'mrcjkb/rustaceanvim',
        version = '^6', -- Recommended
        lazy = false, -- This plugin is already lazy
        init = function()
            vim.g.rustaceanvim = {
                tools = {},
                server = {
                    default_settings = {
                        ['rust-analyzer'] = {
                            diagnostics = {
                                enable = true,
                                experimental = {
                                    enable = true,
                                }
                            }
                        }
                    },
                },
            }
        end,
    },
}
