-- [[
-- Golang integration
local golang = {
    {
        "olexsmir/gopher.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
    },

    -- Debugging
    'mfussenegger/nvim-dap',
    'leoluz/nvim-dap-go',
    'rcarriga/nvim-dap-ui',
    { "folke/neodev.nvim", opts = {} },
    -- 'nvim-telescope/telescope-dap.nvim',
    'theHamsta/nvim-dap-virtual-text',
}
-- ]]

return golang
