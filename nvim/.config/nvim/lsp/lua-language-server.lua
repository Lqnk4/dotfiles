return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc', ".luacheckrc", ".stylua.toml", "selene.toml", "selene.yml", ".git", },
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim", },
            },
            workspace = {
                library = {
                    vim.env.VIMRUNTIME,
                    "${3rd}/luv/library",
                },
            },
            runtime = {
                version = 'LuaJIT',
            }
        }
    }
}
