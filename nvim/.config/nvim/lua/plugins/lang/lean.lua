return {
    {
        'Julian/lean.nvim',
        event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },

        dependencies = {
            {'neovim/nvim-lspconfig', lazy = true},
            {'nvim-lua/plenary.nvim', lazy = true}

            -- optional dependencies:

            -- a completion engine
            --    hrsh7th/nvim-cmp or Saghen/blink.cmp are popular choices

            -- 'nvim-telescope/telescope.nvim', -- for 2 Lean-specific pickers
            -- 'andymass/vim-matchup',          -- for enhanced % motion behavior
            -- 'andrewradev/switch.vim',        -- for switch support
            -- 'tomtom/tcomment_vim',           -- for commenting
        },

        ---@type lean.Config
        opts = { -- see below for full configuration options
            mappings = true,
            goal_markers = { unsolved = '', accomplished = '✓' },
            lsp = {
                init_options = {
                    editDelay = 500,
                    hasWidgets = true,
                }
            },
        }
    }
}
