return {

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        version = false, -- last release is way too old and doesn't work on Windows
        opts = {
            ensure_installed = {
                "bash",
                "c",
                "haskell",
                "html",
                "java",
                "javascript",
                "json",
                "latex",
                "lua",
                "luadoc",
                "python",
                "rust",
                "toml",
                "typescript",
                "vim",
                "vimdoc",
                "xml",
                "yaml",
                "zig",
            },
            highlight = {
                enable = true,
                disable = function(lang, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
            }

        }

    },
}
