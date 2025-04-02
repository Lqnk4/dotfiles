return {
    {
        'stevearc/oil.nvim',
        lazy = false,
        keys = {
            { "<leader>pv", "<cmd>Oil<cr>", desc = "Oil" },
            { "<leader>o-", "<cmd>Oil<cr>", desc = "Oil" },
        },
        opts = function()
            -- local permission_hlgroups = {
            --     ['-'] = 'NonText',
            --     ['r'] = 'DiagnosticSignWarn',
            --     ['w'] = 'DiagnosticSignError',
            --     ['x'] = 'DiagnosticSignOk',
            -- }

            local permission_hlgroups_muted = {
                ['-'] = 'Normal',
                ['r'] = 'Normal',
                ['w'] = 'Normal',
                ['x'] = 'Normal',
            }

            local columns = {
                {
                    'permissions',
                    highlight = function(permission_str)
                        local hls = {}
                        for i = 1, #permission_str do
                            local char = permission_str:sub(i, i)
                            table.insert(hls, { permission_hlgroups_muted[char], i - 1, i })
                        end
                        return hls
                    end,
                },
                { 'size',  highlight = 'Special' },
                { 'mtime', highlight = 'Number' },
            }

            local detail = true

            local ret = {
                default_file_explorer = true,

                win_options = {
                    number = false,
                    relativenumber = false,
                    signcolumn = 'no',
                    foldcolumn = '0',
                    statuscolumn = '',
                },

                constrain_cursor = "name",
                use_default_keymaps = false,
                keymaps = {
                    ["g?"] = { "actions.show_help", mode = "n" },
                    ["g."] = { "actions.toggle_hidden", mode = "n" },
                    ["<CR>"] = "actions.select",
                    ["e"] = "actions.select",
                    ["-"] = { "actions.parent", mode = "n" },
                    ["^"] = { "actions.parent", mode = "n" },
                    ["<C-l>"] = "actions.refresh",


                },
                view_options = {
                    show_hidden = true,
                },
            }

            ret.columns = columns

            ret.keymaps["("] = {
                desc = "Toggle file detail view",
                callback = function()
                    detail = not detail
                    if detail then
                        require("oil").set_columns(columns)
                    else
                        require("oil").set_columns({})
                    end
                end,
            }

            return ret
        end,

    },

    {
        'mbbill/undotree',
        lazy = true,
        keys = {
            { '<leader>su', vim.cmd.UndotreeToggle, desc = "Undo Tree Toggle" }
        },
    },

    {
        "ThePrimeagen/harpoon",
        dependencies = { "nvim-lua/plenary.nvim" },
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
            file_icons = false,
            buffers = {
                sort_mru = true,
                sort_lastused = true,
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
        keys = {
            { "<leader>gg", function() require("neogit").open({ kind = "tab" }) end, desc = "Neogit" }
        },
        dependencies = {
            "nvim-lua/plenary.nvim", -- required
            -- "sindrets/diffview.nvim", -- optional - Diff integration
            "ibhagwan/fzf-lua",      -- optional
        },
    },

    {
        "lewis6991/gitsigns.nvim",
        opts = {
            auto_attach = true
        },
    },


    {
        "stevearc/overseer.nvim",
        lazy = false,
        enabled = true,
        cmd = {
            "OverseerOpen",
            "OverseerClose",
            "OverseerToggle",
            "OverseerSaveBundle",
            "OverseerLoadBundle",
            "OverseerDeleteBundle",
            "OverseerRunCmd",
            "OverseerRun",
            "OverseerInfo",
            "OverseerBuild",
            "OverseerQuickAction",
            "OverseerTaskAction",
            "OverseerClearCache",
        },
        opts = function()

            local overseer = require("overseer")

            -- Restart last task
            vim.api.nvim_create_user_command("OverseerRestartLast", function()
                local tasks = overseer.list_tasks({ recent_first = true })
                if (vim.tbl_isempty(tasks)) then
                    vim.notify("Not tasks found", vim.log.levels.WARN)
                else
                    overseer.run_action(tasks[1], "restart")
                end
            end, {})

            return {
                dap = false,
                task_list = {
                    bindings = {
                        ["<C-h>"] = false,
                        ["<C-j>"] = false,
                        ["<C-k>"] = false,
                        ["<C-l>"] = false,
                    },
                },
                form = {
                    win_opts = {
                        winblend = 0,
                    },
                },
                confirm = {
                    win_opts = {
                        winblend = 0,
                    },
                },
                task_win = {
                    win_opts = {
                        winblend = 0,
                    },
                },
            }
        end,
        -- stylua: ignore
        keys = {
            { "<leader>ow", "<cmd>OverseerToggle<cr>",       desc = "Task list" },
            { "<leader>oo", "<cmd>OverseerRun<cr>",          desc = "Run task" },
            { "<leader>or", "<cmd> OverseerRestartLast<cr>", desc = "Restart Last Task" },
            { "<leader>oq", "<cmd>OverseerQuickAction<cr>",  desc = "Action recent task" },
            { "<leader>oi", "<cmd>OverseerInfo<cr>",         desc = "Overseer Info" },
            { "<leader>ob", "<cmd>OverseerBuild<cr>",        desc = "Task builder" },
            { "<leader>ot", "<cmd>OverseerTaskAction<cr>",   desc = "Task action" },
            { "<leader>oc", "<cmd>OverseerClearCache<cr>",   desc = "Clear cache" },
        },
    },
}
