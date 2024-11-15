local lsp = "pyright"
local ruff = "ruff"

return {

    -- add to treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "ninja", "rst" } },
    },

    -- setup with lspconfig
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                ruff = {
                    cmd_env = { RUFF_TRACE = "messages" },
                    init_options = {
                        settings = {
                            logLevel = "error",
                        },
                    },
                    -- FIX: make this keybind actually do something, don't just leave the table here
                    keys = {
                        {
                            "<leader>co",
                            require("util.lsp").action["source.organizeImports"],
                            desc = "Organize Imports",
                        },
                    },
                },
                ruff_lsp = {
                    keys = {
                        {
                            "<leader>co",
                            require("util.lsp").action["source.organizeImports"],
                            desc = "Organize Imports",
                        },
                    },
                },
            },
            setup = {
                [ruff] = function()
                    require("util.lsp").on_attach(function(client, _)
                        -- Disable hover in favor of Pyright
                        client.server_capabilities.hoverProvider = false
                    end, ruff)
                end,
            },
        },
    },

    -- remove from default setup
    {
        "neovim/nvim-lspconfig",
        opts = function(_, opts)
            local servers = { "pyright", "basedpyright", "ruff", "ruff_lsp", ruff, lsp }
            for _, server in ipairs(servers) do
                opts.servers[server] = opts.servers[server] or {}
                opts.servers[server].enabled = server == lsp or server == ruff
            end
        end,
    },

    {
        "linux-cultist/venv-selector.nvim",
        branch = "regexp", -- Use this branch for the new version
        cmd = "VenvSelect",
        enabled = function()
            -- TODO: replace with fzf-lua later
            return require("util").has_plugin("telescope.nvim")
        end,
        opts = {
            settings = {
                options = {
                    notify_user_on_venv_activation = true,
                },
            },
        },
        --  Call config for python files and load the cached venv automatically
        ft = "python",
        keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" } },
    },

    {
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
            opts.auto_brackets = opts.auto_brackets or {}
            table.insert(opts.auto_brackets, "python")
        end,
    },
}
