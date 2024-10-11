local Util = require("util")

return {
    -- search/replace in multiple files
    {
        "MagicDuck/grug-far.nvim",
        opts = { headerMaxWidth = 80 },
        cmd = "GrugFar",
        keys = {
            {
                "<leader>sr",
                function()
                    local grug = require("grug-far")
                    local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
                    grug.open({
                        transient = true,
                        prefills = {
                            filesFilter = ext and ext ~= "" and "*." .. ext or nil,
                        },
                    })
                end,
                mode = { "n", "v" },
                desc = "Search and Replace",
            },
        },
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        version = false, -- telescope did only one release, so use HEAD for now
        dependencies = {
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                config = function(plugin)
                    Util.on_load("telescope.nvim", function()
                        local ok, err = pcall(require("telescope").load_extension, "fzf")
                    end)
                end,
            },
        },
        keys = function()
            local builtin = require("telescope.builtin")
            return {
                --find
                { "<leader>pf", builtin.find_files,               { desc = "Find Files" } },
                { "<leader>ps", builtin.live_grep,                { desc = "Live Grep" } },
                { '<leader>pb', builtin.buffers,                  { desc = 'Telescope buffers' } },
                --lsp
                { '<leader>pd', builtin.diagnostics,              { desc = 'Telescope LSP diagnostics' } },
                --help
                { '<leader>ph', builtin.help_tags,                { desc = 'Telescope help tags' } },
                -- git
                { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
                { "<leader>gs", "<cmd>Telescope git_status<CR>",  desc = "Status" },

            }
        end,
        opts = function()
            local function find_command()
                if 1 == vim.fn.executable("rg") then
                    return { "rg", "--files", "--color", "never", "-g", "!.git" }
                elseif 1 == vim.fn.executable("fd") then
                    return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
                elseif 1 == vim.fn.executable("fdfind") then
                    return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
                elseif 1 == vim.fn.executable("find") and vim.fn.has("win32") == 0 then
                    return { "find", ".", "-type", "f" }
                elseif 1 == vim.fn.executable("where") then
                    return { "where", "/r", ".", "*" }
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
    }
}
