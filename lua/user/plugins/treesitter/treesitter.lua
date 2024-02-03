local function ts_options()
    local options = {
        ensure_installed = {
            "bash",
            "dockerfile",
            "go",
            "gomod",
            "gosum",
            "gowork",
            "javascript",
            "json",
            "lua",
            "make",
            "markdown",
            "markdown_inline",
            "php",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
            "yaml",
        },
        sync_install = false,
        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = {
            enablee = true
        },
        -- add incremental selection
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<leader>is", -- set to `false` to disable one of the mappings
                node_incremental = "<leader>ni",
                scope_incremental = false,
                node_decremental = "<leader>nd",
            },
        },
    }

    return options
end

local function ts_config(_, opts)
    local configs = require("nvim-treesitter.configs")
    configs.setup(opts)
end

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = ts_options,
    config = ts_config,
}
