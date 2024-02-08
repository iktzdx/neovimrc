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
            prompt_prefix = "   ",
            selection_caret = "  ",
            entry_prefix = "  ",
            initial_mode = "insert",
            selection_strategy = "reset",
            sorting_strategy = "ascending",
            layout_strategy = "horizontal",
            layout_config = {
                horizontal = {
                    prompt_position = "top",
                    preview_width = 0.55,
                    results_width = 0.8,
                },
                vertical = {
                    prompt_position = "top",
                    mirror = false,
                },
                width = 0.87,
                height = 0.80,
                preview_cutoff = 120,
            },
            file_sorter = require("telescope.sorters").get_fuzzy_file,
            generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
            dynamic_preview_title = true,
            path_display = {
                -- see :h telescope.defaults.path_display
                -- shorten = { len = 1, exclude = { -1, -2 } },
                "truncate",
            },
            winblend = 0,
            border = {},
            borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            color_devicons = true,
            set_env = {
                ["COLORTERM"] = "truecolor",
            },
            file_previewer = require("telescope.previewers").vim_buffer_cat.new,
            grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
            qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
            buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
            mappings = {
                n = { ["q"] = require("telescope.actions").close },
            },
        },
        extensions = {
            ["ui-select"] = {
                themes.get_dropdown({ previewer = false }),
            },
            ["fzf"] = {
                fuzzy = true,                   -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true,    -- override the file sorter
                case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            },
        },
    }

    return options
end

local function telescope_config(_, opts)
    local telescope = require("telescope")

    telescope.setup(opts)

    local builtin = require("telescope.builtin")

    local file_pickers_defaults = {
        file_ignore_patterns = { "^.git/" },
        follow = true,
        hidden = true,
        no_ignore = true,
        results_title = false,
        previewer = false,
        layout_strategy = "vertical",
        layout_config = {
            mirror = true,
            anchor = "N",
            prompt_position = "top",
            height = 0.50,
            width = 0.50,
        },
    }

    -- [[
    -- MAPPINGS

    -- Lists available help tags and opens a new window with the relevant help info on <cr>
    vim.keymap.set("n", "<leader>vh", builtin.help_tags, { desc = ":Telescope help_tags" })

    -- Lists normal mode keymappings, runs the selected keymap on `<cr>`
    vim.keymap.set("n", "<leader>vk", builtin.keymaps, { desc = ":Telescope keymaps" })

    -- [[
    -- Search for files and open buffers

    -- Lists files in your current working directory, respects .gitignore
    vim.keymap.set("n", "<leader>pf", function()
        builtin.find_files(file_pickers_defaults)
    end, { desc = ":Telescope find_files" })

    -- Fuzzy search through the output of git ls-files command, respects .gitignore
    vim.keymap.set("n", "<C-p>", function()
        builtin.git_files(file_pickers_defaults)
    end, { desc = ":Telescope git_files" })

    -- Lists git status for current directory
    vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = ":Telescope git_status" })

    -- Lists commits for current directory with diff preview
    vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = ":Telescope git_commits" })

    -- Lists open buffers in current neovim instance
    vim.keymap.set("n", "<leader>pb", function()
        builtin.buffers(file_pickers_defaults)
    end, { desc = ":Telescope buffers" })
    -- ]]

    -- [[
    -- Search for an entry that matches patterns

    -- Search for a string in your current working directory and get results live as you type,
    -- respects .gitignore. (Requires ripgrep)
    vim.keymap.set("n", "<leader>lg", builtin.live_grep, { desc = ":Telescope live_grep" })

    -- Searches for the string under your cursor or selection in your current working directory
    vim.keymap.set("n", "<leader>pws", function()
        builtin.grep_string({ search = vim.fn.expand("<cword>") })
    end, { desc = ":Telescope grep_string <cword>" })

    vim.keymap.set("n", "<leader>pWs", function()
        builtin.grep_string({ search = vim.fn.expand("<cWORD>") })
    end, { desc = ":Telescope grep_string <cWORD>" })
    -- ]]

    -- [[
    -- LSP related

    -- [[
    -- Set custom theme options
    local themes = require("telescope.themes")
    -- local dropdown_theme = themes.get_dropdown({ previewer = false })
    local cursor_theme = themes.get_cursor({
        path_display = { "tail" },
        layout_config = {
            width = 0.70,
            height = 0.50,
        },
    })

    local bottom_pane_theme = themes.get_ivy({
        path_display = { "tail" },
        layout_config = {
            height = 0.5,
        },
    })
    -- ]]

    -- Lists LSP references for word under the cursor
    vim.keymap.set("n", "<leader>ref", function()
        builtin.lsp_references(cursor_theme)
    end, { desc = ":Telescope lsp_references" })

    -- Goto the implementation of the word under the cursor if there's only one,
    -- otherwise show all options in Telescope
    vim.keymap.set("n", "<leader>imp", function()
        builtin.lsp_implementations(cursor_theme)
    end, { desc = ":Telescope lsp_implementations" })

    -- Goto the definition of the word under the cursor, if there's only one,
    -- otherwise show all options in Telescope
    vim.keymap.set("n", "<leader>def", function()
        builtin.lsp_definitions(cursor_theme)
    end, { desc = ":Telescope lsp_definitions" })

    -- Goto the definition of the type of the word under the cursor, if there's only one,
    -- otherwise show all options in Telescope
    vim.keymap.set("n", "<leader>typ", function()
        builtin.lsp_type_definitions(cursor_theme)
    end, { desc = ":Telescope lsp_type_definitions" })

    -- Lists LSP incoming calls for word under the cursor
    vim.keymap.set("n", "<leader>inc", function()
        builtin.lsp_incoming_calls(cursor_theme)
    end, { desc = ":Telescope lsp_incoming_calls" })

    -- Lists LSP outgoing calls for word under the cursor
    vim.keymap.set("n", "<leader>out", function()
        builtin.lsp_outgoing_calls(cursor_theme)
    end, { desc = ":Telescope lsp_outgoing_calls" })

    -- Lists Diagnostics for all open buffers or a specific buffer.
    vim.keymap.set("n", "<leader>dx", function()
        -- builtin.diagnostics(dropdown_theme)
        builtin.diagnostics(bottom_pane_theme)
    end, { desc = ":Telescope diagnostics" })
    -- ]]

    -- EXTENSIONS
    for k, _ in pairs(opts.extensions) do
        telescope.load_extension(k)
    end

    -- Change border colors
    vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = "none" })
end

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
