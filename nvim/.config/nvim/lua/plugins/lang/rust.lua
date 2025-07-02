return {
    {
        'mrcjkb/rustaceanvim',
        version = '^6', -- Recommended
        lazy = false,   -- This plugin is already lazy
        init = function()
            vim.g.rustaceanvim = {
                tools = {},
                server = {
                    on_attach = function(_, bufnr)
                        local cmd = vim.cmd
                        local map = vim.keymap.set
                        local function opts(desc)
                            return { noremap = true, silent = true, buffer = bufnr, desc = "Rust " .. desc }
                        end

                        vim.opt_local.makeprg = "cargo build"

                        map("n", "<leader>mc", function() cmd.RustLsp('openCargo') end, opts "Open Cargo")
                        map("n", "god", function() cmd.RustLsp('openDocs') end, opts "Open Docs")
                        map("n", "K", function() cmd.RustLsp({ 'hover', 'actions' }) end, opts "Hover")
                        map("n", "gra", function() cmd.RustLsp('codeAction') end, opts "Code Action")
                        map("n", "gem", function() cmd.RustLsp('expandMacro') end, opts "Expand Macro")
                        map("n", "J", function() cmd.RustLsp('joinLines') end, opts "Join Lines")
                    end,
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
