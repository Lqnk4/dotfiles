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
        conf.default_setup(opts.servers)
        for setup_func in pairs(conf.setup) do
            conf.setup[setup_func]()
        end

    end,
}
