local M = {
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        opts = {
            size = function(term)
                if term.direction == "horizontal" then
                    return 15
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.35
                end
            end,
            open_mapping = [[<c-\>]], -- or { [[<c-\>]], [[<c-¥>]] } if you also use a Japanese keyboard.
        },
    }
}

return M
