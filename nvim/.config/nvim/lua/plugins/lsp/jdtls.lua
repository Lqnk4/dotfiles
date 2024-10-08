local home = vim.fn.getenv("HOME")
local java_filetypes = { "java" }



-- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local workspace_dir = home .. '/.local/share/nvim/mason/packages/jdtls/workspace/' .. project_name
--                                               ^^
--                                               string concattenation in Lua
--


-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {

        '/usr/lib/jvm/java-17-openjdk/bin/java', -- or '/path/to/java17_or_newer/bin/java'
        -- depends on if `java` is in your $PATH env variable and if it points to the right version.

        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

        '-jar', home .. '/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar',
        -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
        -- Must point to the                                                     Change this to
        -- eclipse.jdt.ls installation                                           the actual version


        '-configuration', home .. '/.local/share/nvim/mason/packages/jdtls/config_linux',
        -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
        -- Must point to the                      Change to one of `linux`, `win` or `mac`
        -- eclipse.jdt.ls installation            Depending on your system.


        -- See `data directory configuration` section in the README
        '-data', workspace_dir,
    },

    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    --
    -- vim.fs.root requires Neovim 0.10.
    -- If you're using an earlier version, use: require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
    root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew" }),

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
        java = {
            configuration = {
                -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
                -- And search for `interface RuntimeOption`
                -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
                runtimes = {
                    {
                        name = "JavaSE-17",
                        path = "/usr/lib/jvm/java-17-openjdk/"
                    }
                }
            }
        }
    },

    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    init_options = {
        bundles = {}
    },
}

return {
    {
        "mfussenegger/nvim-jdtls",
        ft = java_filetypes,
        config = function()
            local function attach_jdtls()
                require("jdtls").start_or_attach(config)
            end

            -- plugin loads on filename, so this wont trigger on the first file loaded. instead, it is called after the plugin is loaded.
            vim.api.nvim_create_autocmd("FileType", {
                pattern = java_filetypes,
                callback = attach_jdtls,
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client and client.name == "jdtls" then
                        -- keybindings here
                        local map = function (mode, lhs, rhs, opts)
                            vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("keep", opts, { buffer = args.buf }))
                        end

                        map("n", "<leader>co", require("jdtls").organize_imports, { desc = "Organize Imports" })
                        map("n", "gs", require("jdtls").super_implementation, { desc = "Goto Super" })
                        map("n", "<leader>cxv", require("jdtls").extract_variable_all, { desc = "Extract Variable" })
                        map("n", "<leader>cxc", require("jdtls").extract_constant, { desc = "Extract Constant" })

                        map("v", "<leader>cxv", [[<ESC><CMD>lua require('jdtls').extract_variable_all(true)<CR>]], { desc = "Extract Variable" })
                        map("v", "<leader>cxc", [[<ESC><CMD>lua require('jdtls').extract_constant(true)<CR>]], { desc = "Extract Variable" })
                    end
                end,
            })

            attach_jdtls()
        end,
    }

}
