-- [[
-- Language support and analysis
local codeanalysis = {
    -- LSP support
    {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
    },

    -- Tree-sitter support
    {
        'nvim-treesitter/nvim-treesitter',
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })()
        end,
    },

    -- Highlight current context using tree-sitter
    {
        'nvim-treesitter/nvim-treesitter-context',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        }
    },

    -- Add text objects via tree-sitter
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = {
            'nvim-treesitter/nvim-treesitter'
        },
    },
}
-- ]]

return codeanalysis
