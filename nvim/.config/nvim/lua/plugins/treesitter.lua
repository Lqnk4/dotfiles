return {
    {
        'nvim-treesitter/nvim-treesitter',
        enabled = false,
        build = ':TSUpdate',
        event = { "VeryLazy", "BufReadPost", "BufWritePost", "BufNewFile" },
        lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
        init = function()
            require("nvim-treesitter.query_predicates")
        end,
        cmd = {
            "TSUpdateSync",
            "TSUpdate",
            "TSInstall",
            "TSInstallSync",
            "TSBufEnable",
            "TSBufDisable",
            "TSBufToggle",
            "TSInstallInfo",
            "TSConfigInfo",
        },
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
                "diff",
                "git_config",
                "glsl",
                "go",
                "haskell",
                "html",
                "java",
                "javadoc",
                "javascript",
                "json",
                "jsonc",
                "kotlin",
                "latex",
                "lua",
                "luadoc",
                "luap",
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
                "regex",
                "rust",
                "toml",
                "typescript",
                "vim",
                "vimdoc",
                "xml",
                "yaml",
                "zig",
            },
            auto_install = true,
            highlight = {
                enable = true,
                disable = function(lang, buf)
                    local disabled_langs = { "latex" }
                    for _, l in ipairs(disabled_langs) do
                        if l == lang then
                            return true
                        end
                    end

                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true, },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    }
}
