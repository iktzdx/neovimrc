local function leap_options()
    local options = {
        case_sensitive = false,
        equivalence_classes = { " \t\r\n" },
        max_phase_one_targets = nil,
        highlight_unlabeled_phase_one_targets = false,
        max_highlighted_traversal_targets = 10,
        substitute_chars = {},
        safe_labels = "sfnut/SFNLHMUGTZ?",
        labels = "sfnjklhodweimbuyvrgtaqpcxz/SFNJKLHODWEIMBUYVRGTAQPCXZ?",
        special_keys = {
            next_target = "<enter>",
            prev_target = "<tab>",
            next_group = "<space>",
            prev_group = "<tab>",
        },
    }
    return options
end

local function leap_config(_, opts)
    local leap = require("leap")

    leap.setup(opts)
    leap.create_default_mappings()

    -- Hide the (real) cursor when leaping, and restore it afterwards.
    vim.api.nvim_create_autocmd("User", {
        pattern = "LeapEnter",
        callback = function()
            vim.cmd.hi("Cursor", "blend=100")
            vim.opt.guicursor:append({ "a:Cursor/lCursor" })
        end,
    })
    vim.api.nvim_create_autocmd("User", {
        pattern = "LeapLeave",
        callback = function()
            vim.cmd.hi("Cursor", "blend=0")
            vim.opt.guicursor:remove({ "a:Cursor/lCursor" })
        end,
    })
end

return {
    "ggandor/leap.nvim",
    lazy = false,
    dependencies = {
        "tpope/vim-repeat",
    },
    opts = leap_options,
    config = leap_config,
}
