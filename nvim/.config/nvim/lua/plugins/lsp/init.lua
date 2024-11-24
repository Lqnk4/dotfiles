return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufNewFile", "BufWritePre", },
        dependencies = {
            "mason.nvim",
            { "williamboman/mason-lspconfig.nvim", config = function() end },
        },
        opts = function()
            ---@class PluginLspOpts
            local ret = {
                -- options for vim.diagnostic.config()
                ---@type vim.diagnostic.Opts
                diagnostics = {
                    underline = true,
                    update_in_insert = false,
                    severity_sort = true,
                },
                -- inlay hints from nvim 10.0+
                inlay_hints = {
                    enabled = true,
                    exclude = {}
                },
                -- add any global capabilities here
                capabilities = {
                    workspace = {
                        fileOperations = {
                            didRename = true,
                            willRename = true,
                        },
                    },
                },
                -- LSP Server Settings
                servers = {
                    bashls = {},
                    lua_ls = {
                        -- mason = false, -- set to false if you don't want this server to be installed with mason
                        -- Use this to add any additional keymaps
                        -- for specific lsp servers
                        settings = {
                            Lua = {
                                workspace = {
                                    checkThirdParty = false,
                                },
                                completion = {
                                    callSnippet = "Replace",
                                },
                                doc = {
                                    privateName = { "^_" },
                                },
                                hint = {
                                    enable = true,
                                    setType = false,
                                    paramType = true,
                                    paramName = "Disable",
                                    semicolon = "Disable",
                                    arrayIndex = "Disable",
                                },
                            },
                        },
                    },
                    jsonls = {
                        settings = {
                            json = {
                                format = {
                                    enable = true,
                                },
                                validate = {
                                    enable = true,
                                },
                            }
                        }
                    },
                    zls = {},
                },
                -- you can do any additional lsp server setup here
                -- return true if you don't want this server to be setup with lspconfig
                ---@type table<string, fun(server:string, opts):boolean?>
                setup = {


                },
            }
            return ret
        end,
        ---@param opts PluginLspOpts
        config = function(_, opts)
            local map = vim.keymap.set

            require("util.lsp").on_attach(
                function(client, bufnr)
                    local key_opts = { buffer = bufnr }

                    -- these will be buffer-local keybindings
                    -- because they only work if you have an active language server

                    map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', key_opts)
                    map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', key_opts)
                    map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', key_opts)
                    map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', key_opts)
                    map('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', key_opts)
                    map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', key_opts)
                    map('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', key_opts)
                    -- map('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', key_opts)
                    map("n", "<F2>", require "util.lsp_renamer", key_opts)
                    map({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', key_opts)
                    map('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', key_opts)


                    if vim.fn.has("nvim-0.10") == 1 then
                        --inlay hints
                        if opts.inlay_hints.enabled then
                            if
                            -- vim.ap.nvim_buf_is_valid(bufnr)
                                vim.bo[bufnr].buftype == ""
                                and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[bufnr].filetype)
                                and client and client.server_capabilities.inlayHintProvider
                            then
                                vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                            end
                        end
                    end
                end
            )

            local servers = opts.servers
            local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                has_cmp and cmp_nvim_lsp.default_capabilities() or {},
                opts.capabilities or {}
            )

            local function setup(server)
                local server_opts = vim.tbl_deep_extend("force", {
                    capabilities = vim.deepcopy(capabilities),
                }, servers[server] or {})
                if server_opts.enabled == false then
                    return
                end

                if opts.setup[server] then
                    if opts.setup[server](server, server_opts) then
                        return
                    end
                elseif opts.setup["*"] then
                    if opts.setup["*"](server, server_opts) then
                        return
                    end
                end
                require("lspconfig")[server].setup(server_opts)
            end

            -- get all the servers that are available through mason-lspconfig
            local have_mason, mlsp = pcall(require, "mason-lspconfig")
            local all_mslp_servers = {}
            if have_mason then
                all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
            end

            local ensure_installed = {} ---@type string[]
            for server, server_opts in pairs(servers) do
                if server_opts then
                    server_opts = server_opts == true and {} or server_opts
                    if server_opts.enabled ~= false then
                        -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
                        if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
                            setup(server)
                        else
                            ensure_installed[#ensure_installed + 1] = server
                        end
                    end
                end
            end

            if have_mason then
                mlsp.setup({
                    ensure_installed = vim.tbl_deep_extend(
                        "force",
                        ensure_installed,
                        require("util").opts("mason-lspconfig.nvim").ensure_installed or {}
                    ),
                    -- ensure_installed = ensure_installed,
                    handlers = { setup },
                })
            end
        end,
    },

    -- lsp tool installer
    {

        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
        build = ":MasonUpdate",
        opts_extend = { "ensure_installed" },
        opts = {
            ensure_installed = {
                "stylua",
                "shfmt",
            },
        },
        ---@param opts MasonSettings | {ensure_installed: string[]}
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            mr:on("package:install:success", function()
                vim.defer_fn(function()
                    -- trigger FileType event to possibly load this newly installed LSP server
                    require("lazy.core.handler.event").trigger({
                        event = "FileType",
                        buf = vim.api.nvim_get_current_buf(),
                    })
                end, 100)
            end)

            mr.refresh(function()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end)
        end,
    },
}
