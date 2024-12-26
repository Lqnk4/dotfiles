return {
    {
        "windwp/windline.nvim",
        enabled = false,
        cond = vim.g.is_tty,
        event = "VeryLazy",
        config = function()
            require("wlsample.evil_line")
        end,
    },
}
