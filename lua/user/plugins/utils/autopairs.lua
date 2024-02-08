local function autopairs_options()
    local options = {
        fast_warp = {},
        disable_filetype = {
            "TelescopePrompt",
            "vim",
        },
        enable_check_bracket_line = false,
    }
    return options
end

local function autopairs_config(_, opts)
    local npairs = require("nvim-autopairs")

    npairs.setup(opts)

    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())

    -- Not sure if I really need this plugin.
    -- npairs.disable()
end

return {
    {
        "windwp/nvim-autopairs",
        lazy = true,
        event = "InsertEnter",
        opts = autopairs_options,
        config = autopairs_config,
    },
}
