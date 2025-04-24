return {
    {
        "rebelot/heirline.nvim",
        enabled = false,
    },

    {
        "bluz71/nvim-linefly",
        enabled = false,
        init = function()
            vim.g.linefly_options = {
                progress_symbol = "↓ "
            }
        end,
    },

}
