return {
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                icons_enabled = false,
                theme = "zenburn",
                component_separators = "|",
                section_separators = "",
                disabled_filetypes = {
                    statusline = {
                        "undotree",
                        "diff",
                    },
                },
            },
            sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {
                    { "mode" },
                    { "filename",   path = 1, newfile_status = true },
                    { "diagnostics" },
                },
                lualine_x = {
                    { "lsp_status", symbols = { done = '' } },
                    "branch",
                    "location"
                },
                lualine_y = {},
                lualine_z = {},
            },
        }
    },
}
