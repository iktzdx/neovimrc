-- [[
-- Autocompletion and snippets
local autocmp = {
    -- Completion
    {
        'hrsh7th/nvim-cmp',
        event = { 'InsertEnter', 'CmdlineEnter' },
    },
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lsp',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',

    -- Snippets
    {
        'L3MON4D3/LuaSnip',
        version = "v2.*", -- follow latest release
        opts = { update_events = { 'TextChanged', 'TextChangedI' } },
        config = function(_, opts)
            require('user.luasnip').luasnip(opts)
        end,
    },
    'rafamadriz/friendly-snippets',
}
-- ]]

return autocmp
