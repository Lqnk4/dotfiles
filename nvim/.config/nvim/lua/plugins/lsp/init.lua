return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile", "BufWritePre", },
    opts = {
        servers = {
            "zls",
        },
    },
    config = function(_, opts)
        local conf = require("config.lspconfig")

        -- setup lua_ls and other default config servers
        conf.defaults(opts.servers)
        conf.lua_ls()
        conf.clangd()

    end,
}
