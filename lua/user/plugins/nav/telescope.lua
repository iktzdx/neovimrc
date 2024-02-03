-- Highly extendable fuzzy finder over lists.
local function telescope_options()
    local themes = require("telescope.themes")

    local options = {
        defaults = {
            vimgrep_arguments = {
                "rg",
                "-L",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
            },
            selection_caret = "  ",
            entry_prefix = "  ",
            initial_mode = "insert",
            selection_strategy = "reset",
            sorting_strategy = "ascending",
            file_sorter = require("telescope.sorters").get_fuzzy_file,
            generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
            path_display = {
                "truncate",
            },
            winblend = 0,
            border = {},
            color_devicons = true,
            set_env = {
                ["COLORTERM"] = "truecolor",
            },
            file_previewer = require("telescope.previewers").vim_buffer_cat.new,
            grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
            qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        },
        extensions = {
            ["ui-select"] = {
                themes.get_dropdown({ previewer = false }),
            },
            ["fzf"] = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            },
        },
    }

    return options
end

local function telescope_config(_, opts)
    local telescope = require("telescope")

    telescope.setup(opts)

    local builtin = require("telescope.builtin")
    local themes = require("telescope.themes")
    local custom_opts = require("user.config.telescope_opts")

    -- [[
    -- MAPPINGS
    local keymap = vim.keymap

    -- Lists available help tags and opens a new window with the relevant help info on <cr>
    keymap.set("n", "<leader>vh", function()
        builtin.help_tags(custom_opts.help_tags)
    end)

    -- Lists files in your current working directory, respects .gitignore
    keymap.set("n", "<leader>pf", function()
        builtin.find_files(custom_opts.find_files)
    end)

    -- Lists open buffers in current neovim instance
    keymap.set("n", "<leader>pb", function()
        builtin.buffers(custom_opts.buffers)
    end)

    -- Search for a string in your current working directory and get results live as you type,
    -- respects .gitignore. (Requires ripgrep)
    keymap.set("n", "<leader>lg", function()
        builtin.live_grep(custom_opts.live_grep)
    end)

    -- LSP related
    local theme = themes.get_cursor(custom_opts.lsp)

    -- Lists LSP references for word under the cursor
    keymap.set("n", "<leader>ref", function()
        builtin.lsp_references(theme)
    end)

    -- Goto the implementation of the word under the cursor if there's only one,
    -- otherwise show all options in Telescope
    keymap.set("n", "<leader>imp", function()
        builtin.lsp_implementations(theme)
    end)

    -- Goto the definition of the word under the cursor, if there's only one,
    -- otherwise show all options in Telescope
    keymap.set("n", "<leader>def", function()
        builtin.lsp_definitions(theme)
    end)

    -- Goto the definition of the type of the word under the cursor, if there's only one,
    -- otherwise show all options in Telescope
    keymap.set("n", "<leader>typ", function()
        builtin.lsp_type_definitions(theme)
    end)

    -- Lists LSP incoming calls for word under the cursor
    keymap.set("n", "<leader>inc", function()
        builtin.lsp_incoming_calls(theme)
    end)

    -- Lists LSP outgoing calls for word under the cursor
    keymap.set("n", "<leader>out", function()
        builtin.lsp_outgoing_calls(theme)
    end)

    -- Lists Diagnostics for all open buffers or a specific buffer.
    keymap.set("n", "<leader>fix", function()
        builtin.diagnostics(themes.get_dropdown({ previewer = false }))
    end)
    -- ]]

    -- EXTENSIONS
    for k, _ in pairs(opts.extensions) do
        telescope.load_extension(k)
    end
end
-- ]]

return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-telescope/telescope-ui-select.nvim",
    },
    opts = telescope_options,
    config = telescope_config,
}
