local function autopairs_options()
    local options = {
        fast_warp = {},
        disable_filetype = {
            "TelescopePrompt",
            "vim"
        }
    }
    return options
end

local function autopairs_config(_, opts)
    require("nvim-autopairs").setup(opts)
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return {
    {
        "windwp/nvim-autopairs",
        lazy = true,
        event = "InsertEnter",
        opts = autopairs_options,
        config = autopairs_config
    }
}

