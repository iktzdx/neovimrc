local function luasnip_options()
    local options = {
        history = true,
        update_events = "TextChanged, TextChangedI",
    }
    return options
end

local function luasnip_config(_, opts)
    local luasnip = require("luasnip")
    local vscode_loader = require("luasnip.loaders.from_vscode")
    local snipmate_loader = require("luasnip.loaders.from_snipmate")
    local lua_loader = require("luasnip.loaders.from_lua")

    luasnip.config.set_config(opts)

    -- vscode format
    vscode_loader.lazy_load()
    vscode_loader.lazy_load({
        paths = vim.g.vscode_snippets_path or "",
    })

    -- snipmate format
    snipmate_loader.load()
    snipmate_loader.lazy_load({
        paths = vim.g.snipmate_snippets_path or "",
    })

    -- lua format
    lua_loader.load()
    lua_loader.lazy_load({
        paths = vim.g.lua_snippets_path or "",
    })

    vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
            local current_buf = vim.api.nvim_get_current_buf()
            if
                luasnip.session.current_nodes[current_buf]
                and not luasnip.session.jump_active
            then
                luasnip.unlink_current()
            end
        end,
    })
end

return {
    "L3MON4D3/LuaSnip",
    version = "2.*",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = luasnip_options,
    config = luasnip_config,
}
