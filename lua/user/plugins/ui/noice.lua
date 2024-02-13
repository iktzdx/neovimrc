local function noice_options()
    local options = {
        routes = {
            filter = {
                event = 'msg_show',
                any = {
                    { find = '%d+L, %d+B' },
                    { find = '; after #%d+' },
                    { find = '; before #%d+' },
                    { find = '%d fewer lines' },
                    { find = '%d more lines' },
                },
            },
            opts = { skip = true },
        },
        popupmenu = {
            enabled = true,
            backend = "nui",
            kind_icons = {},
        },
        messages = { enabled = false },
        notify = { enabled = false },
        lsp = {
            progress = {
                enabled = false,
            },
            message = {
                enabled = false,
            },
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
            },
            hover = {
                enabled = true,
                silent = false,
                view = nil,
                opts = {},
            },
            signature = {
                enabled = true,
                auto_open = {
                    enabled = true,
                    trigger = true,
                    luasnip = true,
                    throttle = 50,
                },
                view = nil,
                opts = {},
            },
            documentation = {
                view = "hover",
                opts = {
                    lang = "markdown",
                    replace = true,
                    render = "plain",
                    format = { "{message}" },
                    win_options = { concealcursor = "n", conceallevel = 3 },
                },
            },
        },
        markdown = {
            hover = {
                ["|(%S-)|"] = vim.cmd.help,
                ["%[.-%]%((%S-)%)"] = require("noice.util").open,
            },
            highlights = {
                ["|%S-|"] = "@text.reference",
                ["@%S+"] = "@parameter",
                ["^%s*(Parameters:)"] = "@text.title",
                ["^%s*(Return:)"] = "@text.title",
                ["^%s*(See also:)"] = "@text.title",
                ["{%S-}"] = "@parameter",
            },
        },
    }
    return options
end

return {
    "folke/noice.nvim",
    opts = noice_options,
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
    }
}
