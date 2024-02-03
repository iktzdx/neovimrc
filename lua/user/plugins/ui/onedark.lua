-- [[
-- Neovim colorscheme based on Atom's One Dark and Light theme
-- ]]
local function onedark_options()
    local options = {
        -- Choose between { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }
        -- Default 'dark'
        style = "warm",
        toggle_style_key = "<leader>ts",
        toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" },
        transparent = true,
        -- TODO: highlight syntax tokens with different colors
        -- in order to distinguish, for example, local variables from function arguments.
        -- https://github.com/navarasu/onedark.nvim?tab=readme-ov-file#customization
        -- highlights = {}
    }
    return options
end

local function onedark_config(_, opts)
    local colors = require("onedark")

    colors.setup(opts)
    colors.load()
end

return {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    opts = onedark_options,
    config = onedark_config,
}
