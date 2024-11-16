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

    -- fzf picker
    {
        "ibhagwan/fzf-lua",
        cmd = "FzfLua",
        opts = function(_, opts)
            local config = require("fzf-lua.config")
            local actions = require("fzf-lua.actions")

            -- Quickfix
            config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
            config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
            config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
            config.defaults.keymap.fzf["ctrl-x"] = "jump"
            config.defaults.keymap.fzf["ctrl-f"] = "preview-page-down"
            config.defaults.keymap.fzf["ctrl-b"] = "preview-page-up"
            config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
            config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"
            return {
                "default-title",
                fzf_colors = true,
                fzf_opts = {
                    -- ["--no-info"] = "",
                    -- ["--info"] = "hidden",
                    -- ["--header"] = " ",
                    -- ["--padding"] = "13%,5%,13%,5%",
                    ["--no-scrollbar"] = true,
                },
                defaults = {
                    formatter = "path.dirname_first",
                },
                -- Custom LazyVim option to configure vim.ui.select
                ui_select = function(fzf_opts, items)
                    return vim.tbl_deep_extend("force", fzf_opts, {
                        prompt = " ",
                        winopts = {
                            title = " " .. vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", "")) .. " ",
                            title_pos = "center",
                        },
                    }, fzf_opts.kind == "codeaction" and {
                        winopts = {
                            layout = "vertical",
                            -- height is number of items minus 15 lines for the preview, with a max of 80% screen height
                            height = math.floor(math.min(vim.o.lines * 0.8 - 16, #items + 2) + 0.5) + 16,
                            width = 0.5,
                            preview = not vim.tbl_isempty(require("util.lsp").get_clients({ bufnr = 0, name = "vtsls" })) and {
                                layout = "vertical",
                                vertical = "down:15,border-top",
                                hidden = "hidden",
                            } or {
                                layout = "vertical",
                                vertical = "down:15,border-top",
                            },
                        },
                    } or {
                        winopts = {
                            width = 0.5,
                            -- height is number of items, with a max of 80% screen height
                            height = math.floor(math.min(vim.o.lines * 0.8, #items + 2) + 0.5),
                        },
                    })
                end,
                winopts = {
                    width = 0.8,
                    height = 0.8,
                    row = 0.5,
                    col = 0.5,
                    preview = {
                        scrollchars = { "┃", "" },
                    },
                },
                files = {
                    cwd_prompt = false,
                    actions = {
                        ["alt-i"] = { actions.toggle_ignore },
                        ["alt-h"] = { actions.toggle_hidden },
                    },
                },
                grep = {
                    actions = {
                        ["alt-i"] = { actions.toggle_ignore },
                        ["alt-h"] = { actions.toggle_hidden },
                    },
                },
                lsp = {
                    symbols = {
                        symbol_hl = function(s)
                            return "TroubleIcon" .. s
                        end,
                        symbol_fmt = function(s)
                            return s:lower() .. "\t"
                        end,
                        child_prefix = false,
                    },
                    code_actions = {
                        previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
                    },
                },
            }
        end,
        config = function(_, opts)
            if opts[1] == "default-title" then
                -- use the same prompt for all pickers for profile `default-title` and
                -- profiles that use `default-title` as base profile
                local function fix(t)
                    t.prompt = t.prompt ~= nil and " " or nil
                    for _, v in pairs(t) do
                        if type(v) == "table" then
                            fix(v)
                        end
                    end
                    return t
                end
                opts = vim.tbl_deep_extend("force", fix(require("fzf-lua.profiles.default-title")), opts)
                opts[1] = nil
            end
            require("fzf-lua").setup(opts)
        end,
        init = function()
            vim.api.nvim_create_autocmd("User", {
                pattern = "VeryLazy",
                callback = function()
                    vim.ui.select = function(...)
                        require("lazy").load({ plugins = { "fzf-lua" } })
                        local opts = require("util").opts("fzf-lua") or {}
                        require("fzf-lua").register_ui_select(opts.ui_select or nil)
                        return vim.ui.select(...)
                    end
                end,
            })
        end,
        keys = function()
            return {
                { "<leader>pp", "<cmd>FzfLua builtin<cr>", desc = "Fzf-Lua Builtin" },
                { "<c-j>",      "<c-j>",                   ft = "fzf",              mode = "t", nowait = true },
                { "<c-k>",      "<c-k>",                   ft = "fzf",              mode = "t", nowait = true },
                {
                    "<leader>,",
                    "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
                    desc = "Switch Buffer",
                },
                -- find
                { "<leader>pb", "<cmd>FzfLua buffers<cr>",                desc = "fzf Buffers " },
                { "<leader>pf", "<cmd>FzfLua files<cr>",                  desc = "fzf Files" },
                { "<leader>pg", "<cmd>FzfLua git_files<cr>",              desc = "Find Files (git-files)" },
                { "<leader>pr", "<cmd>FzfLua oldfiles<cr>",               desc = "Recent" },
                -- git
                { "<leader>gc", "<cmd>FzfLua git_commits<CR>",            desc = "Commits" },
                { "<leader>gs", "<cmd>FzfLua git_status<CR>",             desc = "Status" },
                -- search
                { "<leader>sa", "<cmd>FzfLua autocmds<cr>",               desc = "Auto Commands" },
                { "<leader>sb", "<cmd>FzfLua grep_curbuf<cr>",            desc = "Buffer" },
                { "<leader>sc", "<cmd>FzfLua command_history<cr>",        desc = "Command History" },
                { "<leader>sC", "<cmd>FzfLua commands<cr>",               desc = "Commands" },
                { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>",   desc = "Document Diagnostics" },
                { "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>",  desc = "Workspace Diagnostics" },
                { "<leader>sg", "<cmd>FzfLua live_grep<cr>",              desc = "Grep (Root Dir)" },
                { "<leader>sG", "<cmd>FzfLua live_grep root=false<cr>",   desc = "Grep (cwd)" },
                { "<leader>sh", "<cmd>FzfLua help_tags<cr>",              desc = "Help Pages" },
                { "<leader>sH", "<cmd>FzfLua highlights<cr>",             desc = "Search Highlight Groups" },
                { "<leader>sj", "<cmd>FzfLua jumps<cr>",                  desc = "Jumplist" },
                { "<leader>sk", "<cmd>FzfLua keymaps<cr>",                desc = "Key Maps" },
                { "<leader>sl", "<cmd>FzfLua loclist<cr>",                desc = "Location List" },
                { "<leader>sM", "<cmd>FzfLua man_pages<cr>",              desc = "Man Pages" },
                { "<leader>sm", "<cmd>FzfLua marks<cr>",                  desc = "Jump to Mark" },
                { "<leader>sR", "<cmd>FzfLua resume<cr>",                 desc = "Resume" },
                { "<leader>sq", "<cmd>FzfLua quickfix<cr>",               desc = "Quickfix List" },
                { "<leader>sw", "<cmd>FzfLua grep_cword<cr>",             desc = "Word (Root Dir)" },
                { "<leader>sW", "<cmd>FzfLua grep_cword root=false<cr>",  desc = "Word (cwd)" },
                { "<leader>sw", "<cmd>FzfLua grep_visual<cr>",            mode = "v",                       desc = "Selection (Root Dir)" },
                { "<leader>sW", "<cmd>FzfLua grep_visual root=false<cr>", mode = "v",                       desc = "Selection (cwd)" },
                { "<leader>uC", "<cmd>FzfLua colorschemes<cr>",           desc = "Colorscheme with Preview" },
            }
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
            { "<leader>un", function() Snacks.notifier.hide() end,  desc = "Dismiss All Notifications" },
            { "<leader>bd", function() Snacks.bufdelete() end,      desc = "Delete Buffer" },
            -- { "<leader>gg", function() Snacks.lazygit() end,                 desc = "Lazygit" },
            { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
            { "<leader>gB", function() Snacks.gitbrowse() end,      desc = "Git Browse" },
            -- { "<leader>gf", function() Snacks.lazygit.log_file() end,        desc = "Lazygit Current File History" },
            -- { "<leader>gl", function() Snacks.lazygit.log() end,             desc = "Lazygit Log (cwd)" },
            { "<leader>cR", function() Snacks.rename() end,         desc = "Rename File" },
            { "<c-/>",      function() Snacks.terminal() end,       desc = "Toggle Terminal" },
            { "<c-_>",      function() Snacks.terminal() end,       desc = "which_key_ignore" },
            -- { "]]",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference" },
            -- { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference" },
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
        enabled = true,
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
            { "]t",         function() require("todo-comments").jump_next() end,                                         desc = "Next Todo Comment" },
            { "[t",         function() require("todo-comments").jump_prev() end,                                         desc = "Previous Todo Comment" },
            { "<leader>st", function() require("todo-comments.fzf").todo() end,                                          desc = "Todo" },
            { "<leader>sT", function() require("todo-comments.fzf").todo({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
        },
    }
}
