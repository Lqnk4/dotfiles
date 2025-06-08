return {

    {
        'mbbill/undotree',
        lazy = true,
        keys = {
            { '<leader>su', vim.cmd.UndotreeToggle, desc = "Undo Tree Toggle" }
        },
    },

    {
        "ThePrimeagen/harpoon",
        dependencies = { "nvim-lua/plenary.nvim", lazy = true },
        branch = "harpoon2",
        opts = {
            menu = {
                width = vim.api.nvim_win_get_width(0) - 4,
            },
            settings = {
                save_on_toggle = true,
            },
        },
        keys = function()
            local keys = {
                {
                    "<leader>a",
                    function()
                        require("harpoon"):list():add()
                    end,
                    desc = "Harpoon File",
                },
                {
                    "<leader>h",
                    function()
                        local harpoon = require("harpoon")
                        harpoon.ui:toggle_quick_menu(harpoon:list())
                    end,
                    desc = "Harpoon Quick Menu",
                },
            }

            for i = 1, 9 do
                table.insert(keys, {
                    "<leader>" .. i,
                    function()
                        require("harpoon"):list():select(i)
                    end,
                    desc = "Harpoon to File " .. i,
                })
            end
            return keys
        end,

    },

    {
        "ibhagwan/fzf-lua",
        cmd = "FzfLua",
        opts = {
            files = {
                file_icons = false,
                git_icons = false,
                color_icons = false,
            },
            buffers = {
                sort_mru = true,
                sort_lastused = true,
            },
            keymap = {
                builtin = {
                    true,
                    ["<C-f>"] = "preview-page-down",
                    ["<C-b>"] = "preview-page-up",
                },
                fzf = {
                    true,
                    ["ctrl-d"] = "half-page-down",
                    ["ctrl-u"] = "half-page-up",
                    ["ctrl-f"] = "preview-page-down",
                    ["ctrl-b"] = "preview-page-up",
                    ["ctrl-q"] = "select-all+accept",
                },
            },
        },
        keys = function()
            -- template for doom style popup
            local bottom_window =
            [[ winopts={row=1,col=0,height=0.3,width=1,backdrop=100,border="none"} winopts.preview={hidden="hidden"} hls={normal="FzfLuaPreviewNormal",border="FzfLuaPreviewBorder"} ]]

            return {

                { "<leader>,",       "<cmd>FzfLua buffers " .. bottom_window .. "<cr>",      desc = "Switch Buffer" },
                { "<leader><",       "<cmd>FzfLua buffers " .. bottom_window .. "<cr>",      desc = "Switch Buffer" },
                { "<leader>pb",      "<cmd>FzfLua buffers<cr>",                              desc = "Switch Buffer" },

                { "<leader>/",       "<cmd>FzfLua live_grep<cr>",                            desc = "Grep (Root Dir)" },

                { "<leader>:",       "<cmd>FzfLua command_history<cr>",                      desc = "Command History" },

                { "<leader><space>", "<cmd>FzfLua files " .. bottom_window .. "<cr>",        desc = "Find Files (Root Dir)" },
                { "<leader>.",       "<cmd>FzfLua files " .. bottom_window .. "<cr>",        desc = "Find Files (Root Dir)" },
                { "<leader>pf",      "<cmd>FzfLua files<cr>",                                desc = "Find Project Files (Root Dir)" },

                { "<leader>pm",      "<cmd>FzfLua manpages<cr>",                             desc = "Find Man Pages" },

                { "<leader>sc",      "<cmd>FzfLua colorschemes " .. bottom_window .. "<cr>", desc = "Colorschemes" },
                { "<leader>sC",      "<cmd>FzfLua awesome_colorschemes<cr>",                 desc = "Awesome Colorschemes" },
            }
        end
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "classic",
            delay = 600,
            icons = {
                separator = " ",
                mappings = false,
            },
        },
        keys = {
            { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer Local Keymaps (which-key)" },
        },
    },

    {
        "NeogitOrg/neogit",
        cmd = { "Neogit" },
        dependencies = {
            { "nvim-lua/plenary.nvim", lazy = true }, -- required
            {
                "sindrets/diffview.nvim",
                lazy = true,
                opts = { use_icons = false, },
            },
            { "ibhagwan/fzf-lua",      lazy = true },
        },
        keys = {
            { "<leader>gg", function() require("neogit").open({ kind = "tab" }) end, desc = "Neogit" }
        },
    },

    -- {
    --     "lewis6991/gitsigns.nvim",
    --     enabled = false,
    --     opts = {
    --         auto_attach = true
    --     },
    -- },

    {
        "tpope/vim-dispatch",
    },
}
