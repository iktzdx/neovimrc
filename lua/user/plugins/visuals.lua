-- [[
-- Visuals
local visuals = {
    -- Neovim colorscheme based on Atom's One Dark and Light theme
    {
        'navarasu/onedark.nvim',
        lazy = false,
        priority = 1000,
        opts = {
            style = 'warm',
        }
    },

    -- Fast and easy to configure neovim statusline
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'kyazdani42/nvim-web-devicons',
            enabled = true,
            lazy = true,
        },
    },
}
-- ]]

return visuals
