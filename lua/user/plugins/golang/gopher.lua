local function gopher_config(_, opts)
    require("gopher").setup(opts)
    -- require("gopher.dap").setup()
end

return {
    "olexsmir/gopher.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        -- "mfussenegger/nvim-dap",
    },
    config = gopher_config,
}
