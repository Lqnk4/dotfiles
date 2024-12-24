return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile", "BufWritePre", },
    config = function()
        local conf = require("config.lspconfig")

        -- setup lua_ls and other default config servers
        local servers = { "zls", }
        conf.defaults(servers)
    end,
}
