return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        opts = {
            ensure_installed = {
                "ada",
                "agda",
                "asm",
                "bash",
                "c",
                "c_sharp",
                "clojure",
                "cmake",
                "cpp",
                "css",
                "git_config",
                "git_ignore",
                "glsl",
                "go",
                "haskell",
                "html",
                "java",
                "javadoc",
                "javascript",
                "json",
                "kotlin",
                "latex",
                "lua",
                "make",
                "markdown",
                "markdown_inline",
                "nasm",
                "ocaml",
                "perl",
                "php",
                "python",
                "query",
                "r",
                "rust",
                "vim",
                "vimdoc",
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
                additional_vim_regex_highlighting = false,
            }
        }
    }
}
