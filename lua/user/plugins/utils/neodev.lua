local function neodev_optioins()
    local options = {
        library = {
            plugins = { "nvim-dap-ui" },
        },
    }

    return options
end

return {
    "folke/neodev.nvim",
    opts = neodev_optioins,
}
