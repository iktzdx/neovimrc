local t_ok, telescope = pcall(require, 'telescope')
if not t_ok then
    return
end

local tb_ok, builtin = pcall(require, 'telescope.builtin')
if not tb_ok then
    return
end

local tt_ok, themes = pcall(require, 'telescope.themes')
if not tt_ok then
    return
end

telescope.setup({
    extensions = {
        ["ui-select"] = {
            themes.get_dropdown({ previewer = false })
        }
    }
})

-- MAPPINGS
local opts = require("user.telescope_opts")

-- Lists available help tags and opens a new window with the relevant help info on <cr>
vim.keymap.set('n', '<leader>vh', function()
    builtin.help_tags(opts.help_tags)
end)

-- Lists files in your current working directory, respects .gitignore
vim.keymap.set('n', '<leader>pf', function()
    builtin.find_files(opts.find_files)
end)

-- Lists open buffers in current neovim instance
vim.keymap.set('n', '<leader>pb', function()
    builtin.buffers(opts.buffers)
end)

-- Search for a string in your current working directory and get results live as you type,
-- respects .gitignore. (Requires ripgrep)
vim.keymap.set('n', '<leader>lg', function()
    builtin.live_grep(opts.live_grep)
end)

-- LSP related
local theme = themes.get_cursor(opts.lsp)

-- Lists LSP references for word under the cursor
vim.keymap.set('n', '<leader>ref', function()
    builtin.lsp_references(theme)
end)

-- Goto the implementation of the word under the cursor if there's only one,
-- otherwise show all options in Telescope
vim.keymap.set('n', '<leader>imp', function()
    builtin.lsp_implementations(theme)
end)

-- Goto the definition of the word under the cursor, if there's only one,
-- otherwise show all options in Telescope
vim.keymap.set('n', '<leader>def', function()
    builtin.lsp_definitions(theme)
end)

-- Goto the definition of the type of the word under the cursor, if there's only one,
-- otherwise show all options in Telescope
vim.keymap.set('n', '<leader>typ', function()
    builtin.lsp_type_definitions(theme)
end)

-- Lists LSP incoming calls for word under the cursor
vim.keymap.set('n', '<leader>inc', function()
    builtin.lsp_incoming_calls(theme)
end)

-- Lists LSP outgoing calls for word under the cursor
vim.keymap.set('n', '<leader>out', function()
    builtin.lsp_outgoing_calls(theme)
end)

-- Lists Diagnostics for all open buffers or a specific buffer.
vim.keymap.set('n', '<leader>fix', function()
    builtin.diagnostics(themes.get_dropdown({ previewer = false }))
end)

-- EXTENSIONS

-- Use a telescope prompt when running any dap command.
-- telescope.load_extension('dap')

-- It sets vim.ui.select to telescope.
require("telescope").load_extension("ui-select")
