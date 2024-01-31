-- [[
-- Find, filter, preview, pick
local nav = {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.0', -- works well with neovim v0.9.2
        dependencies = { 'nvim-lua/plenary.nvim' },
    },

    -- Use telescope picker for code actions
    {
        'nvim-telescope/telescope-ui-select.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim' },
    },

    -- Jump between buffers with ez
    'theprimeagen/harpoon',

    -- Navigate  through the undo tree
    'mbbill/undotree',
}
-- ]]

return nav
