return {
    {
        'isovector/cornelis',
        enabled = false,
        name = 'cornelis',
        ft = 'agda',
        build = 'stack install',
        dependencies = { 'neovimhaskell/nvim-hs.vim', 'kana/vim-textobj-user' },
        version = '*',
    }
}
