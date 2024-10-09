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
                        if not ok then
                        end
                    end)
                end,
            },
        },
        keys = function()
            local builtin = require("telescope.builtin")
            return {
                { "<leader>pf", builtin.find_files,  { desc = "Find Files" } },
                { "<leader>pg", builtin.git_files,   { desc = "Find Files" } },
                { "<leader>ps", builtin.live_grep,   { desc = "Live Grep" } },
                { '<leader>pb', builtin.buffers,     { desc = 'Telescope buffers' } },
                { '<leader>ph', builtin.help_tags,   { desc = 'Telescope help tags' } },
                { '<leader>pd', builtin.diagnostics, { desc = 'Telescope LSP diagnostics' } },

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
                    "<leader>a", function()
                        require("harpoon"):list():add()
                    end,
                    desc = "Harpoon File",
                },
                {
                    "<leader>h", function()
                        local harpoon = require("harpoon")
                        harpoon.ui:toggle_quick_menu(harpoon:list())
                    end,
                    desc = "Harpoon Quick Menu",
                },
            }

            for i = 1, 9 do
                table.insert(keys, {
                    "<leader>" .. i, function()
                        require("harpoon"):list():select(i)
                    end,
                    desc = "Harpoon to File " .. i,
                })
            end
            return keys
        end,
    }
}
