local Util = require("util")

return {
    {
        'stevearc/oil.nvim',
        lazy = false,
        keys = {
            { "<leader>pv", "<cmd>Oil<cr>", { desc = "Oil" } },
        },
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = function()
            local detail = false -- toggle for file detail view

            return {
                keymaps = {
                    ["gd"] = {
                        desc = "Toggle file detail view",
                        callback = function()
                            detail = not detail
                            if detail then
                                require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
                            else
                                require("oil").set_columns({ "icon" })
                            end
                        end,
                    },
                },
                keymaps_help = {
                    border = "single",
                }
            }
        end,
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                config = function()
                    require('telescope').load_extension('fzf')
                end,
            }
        },
        cmd = "Telescope",
        version = false, -- telescope did only one release, so use HEAD for now
        keys = function()
            local builtin = require("telescope.builtin")
            return {
                --find
                { "<leader>pf", builtin.find_files,                                            { desc = "Find Files" } },
                { "<leader>ps", builtin.live_grep,                                             { desc = "Live Grep" } },
                { "<leader>pb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" }, --lsp
                { '<leader>pd', builtin.diagnostics,                                           { desc = 'Telescope LSP diagnostics' } },
                { '<leader>pr', builtin.oldfiles,                                              { desc = 'Telescope LSP diagnostics' } },
                --help
                { '<leader>ph', builtin.help_tags,                                             { desc = 'Telescope help tags' } },
                { '<leader>pm', builtin.man_pages,                                             { desc = 'Telescope help tags' } },
                -- git
                { "<leader>pg", builtin.git_files,                                             { desc = "Find Files" } },
                { "<leader>gc", "<cmd>Telescope git_commits<CR>",                              desc = "Commits" },
                { "<leader>gs", "<cmd>Telescope git_status<CR>",                               desc = "Status" },
                -- colorschemes
                { "<leader>uC", builtin.colorscheme,                                           { desc = "Colorscheme with Preview" } },

            }
        end,
        opts = function()
            local function find_command()
                if 1 == vim.fn.executable("rg") then
                    return { "rg", "--files", "--color", "never", "-g", "!.git" }
                elseif 1 == vim.fn.executable("fd") then
                    return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
                end
            end

            return {
                defaults = {
                    prompt_prefix = " ",
                    selection_caret = " ",
                    -- open files in the first window that is an actual file.
                    -- use the current window if no other window is available.
                    get_selection_window = function()
                        local wins = vim.api.nvim_list_wins()
                        table.insert(wins, 1, vim.api.nvim_get_current_win())
                        for _, win in ipairs(wins) do
                            local buf = vim.api.nvim_win_get_buf(win)
                            if vim.bo[buf].buftype == "" then
                                return win
                            end
                        end
                        return 0
                    end,
                    pickers = {
                        find_files = {
                            find_command = find_command,
                            hidden = true,
                        }
                    }
                }
            }
        end,
    },

    -- telescope undo
    {
        "debugloop/telescope-undo.nvim",
        dependencies = { -- note how they're inverted to above example
            {
                "nvim-telescope/telescope.nvim",
                dependencies = { "nvim-lua/plenary.nvim" },
            },
        },
        keys = {
            { -- lazy style key map
                "<leader>uu",
                "<cmd>Telescope undo<cr>",
                desc = "undo history",
            },
        },
        opts = {
            extensions = {
                undo = {
                    side_by_side = true,
                },
            },
        },
        config = function(_, opts)
            -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
            -- configs for us. We won't use data, as everything is in it's own namespace (telescope
            -- defaults, as well as each extension).
            require("telescope").setup(opts)
            require("telescope").load_extension("undo")
        end,
    },

    -- better file navigation
    {
        "ThePrimeagen/harpoon",
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
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            bigfile = { enabled = true },
            notifier = {
                enabled = true,
                timeout = 3000,
            },
            quickfile = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = false },
            styles = {
                notification = {
                    wo = { wrap = true } -- Wrap notifications
                }
            }
        },
        keys = {
            { "<leader>un", function() Snacks.notifier.hide() end,           desc = "Dismiss All Notifications" },
            { "<leader>bd", function() Snacks.bufdelete() end,               desc = "Delete Buffer" },
            -- { "<leader>gg", function() Snacks.lazygit() end,                 desc = "Lazygit" },
            { "<leader>gb", function() Snacks.git.blame_line() end,          desc = "Git Blame Line" },
            { "<leader>gB", function() Snacks.gitbrowse() end,               desc = "Git Browse" },
            -- { "<leader>gf", function() Snacks.lazygit.log_file() end,        desc = "Lazygit Current File History" },
            -- { "<leader>gl", function() Snacks.lazygit.log() end,             desc = "Lazygit Log (cwd)" },
            { "<leader>cR", function() Snacks.rename() end,                  desc = "Rename File" },
            { "<c-/>",      function() Snacks.terminal() end,                desc = "Toggle Terminal" },
            { "<c-_>",      function() Snacks.terminal() end,                desc = "which_key_ignore" },
            { "]]",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference" },
            { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference" },
            {
                "<leader>N",
                desc = "Neovim News",
                function()
                    Snacks.win({
                        file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
                        width = 0.6,
                        height = 0.6,
                        wo = {
                            spell = false,
                            wrap = false,
                            signcolumn = "yes",
                            statuscolumn = " ",
                            conceallevel = 3,
                        },
                    })
                end,
            }
        },
        init = function()
            vim.api.nvim_create_autocmd("User", {
                pattern = "VeryLazy",
                callback = function()
                    -- Setup some globals for debugging (lazy-loaded)
                    _G.dd = function(...)
                        Snacks.debug.inspect(...)
                    end
                    _G.bt = function()
                        Snacks.debug.backtrace()
                    end
                    vim.print = _G.dd -- Override print to use snacks for `:=` command

                    -- Create some toggle mappings
                    Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                    Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                    Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
                    Snacks.toggle.diagnostics():map("<leader>ud")
                    Snacks.toggle.line_number():map("<leader>ul")
                    Snacks.toggle.option("conceallevel",
                        { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
                    Snacks.toggle.treesitter():map("<leader>uT")
                    Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map(
                    "<leader>ub")
                    Snacks.toggle.inlay_hints():map("<leader>uh")
                end,
            })
        end,
    },

    -- lsp symbol navigation for statusline
    {
        "SmiteshP/nvim-navic",
        enabled = false,
        lazy = true,
        init = function()
            vim.g.navic_silence = true
            require("util.lsp").on_attach(function(client, buffer)
                if client.supports_method("textDocument/documentSymbol") then
                    require("nvim-navic").attach(client, buffer)
                end
            end)
        end,
        opts = function()
            return {
                separator = " ",
                highlight = true,
                depth_limit = 5,
                icons = require("config").icons.kinds,
                lazy_update_context = true,
            }
        end,
    },

    -- highlights changed text since last commit
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPost", "BufNewFile", "BufWritePre", },
        opts = {
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
                untracked = { text = "▎" },
            },
            signs_staged = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
            },
            signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
            on_attach = function(buffer)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
                end

                -- stylua: ignore start
                map("n", "<leader>ght", "<cmd>Gitsigns toggle_signs<cr>", "Toggle Gitsigns")
                map("n", "]h", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "]c", bang = true })
                    else
                        gs.nav_hunk("next")
                    end
                end, "Next Hunk")
                map("n", "[h", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "[c", bang = true })
                    else
                        gs.nav_hunk("prev")
                    end
                end, "Prev Hunk")
                map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
                map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
                map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
                map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
                map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
                map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
                map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
                map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
                map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
                map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
                map("n", "<leader>ghd", gs.diffthis, "Diff This")
                map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
            end,
        },
    },

    -- Todo comments
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = { "BufReadPost", "BufNewFile", "BufWritePre", },
        opts = {},
        -- stylua: ignore
        keys = {
            { "]t",         function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
            { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
            { "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
            { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",    desc = "Todo/Fix/Fixme" },
        },
    }
}
