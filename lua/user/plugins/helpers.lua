local helpers = {
    {
        -- Add/change/delete surrounding delimiter pairs with ease
        -- https://github.com/kylechui/nvim-surround/blob/main/doc/nvim-surround.txt
        'kylechui/nvim-surround',
        version = '*', -- Use for stability; omit to use `main` branch for the latest features
        event = 'VeryLazy',
        config = function()
            require('nvim-surround').setup({})
        end,
    },

    -- Auto-pair brackets
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        disable_filetype = { 'TelescopePrompt', 'vim' },
    },

    -- Treat indentation as a text object
    -- https://github.com/michaeljsmith/vim-indent-object#usage
    -- 'michaeljsmith/vim-indent-object',
}

return helpers
