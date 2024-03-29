local options = {
    autoread = true,
    backup = false, -- creates a backup file
    cmdheight = 1, -- more space in the neovim command line for displaying messages
    completeopt = { "menu", "menuone", "noselect" }, -- mostly just for cmp
    conceallevel = 0, -- so that `` is visible in markdown files
    cursorline = true, -- highlight the current line
    expandtab = true, -- convert tabs to spaces
    exrc = true, -- Automatically execute .nvim.lua, .nvimrc, and .exrc files in the current directory
    fileencoding = "utf-8", -- the encoding written to a file
    -- foldcolumn = "1",
    -- foldenable = true,
    -- foldlevel = 99, -- Using ufo provider need a large value, feel free to decrease the value
    -- foldlevelstart = -1,
    hlsearch = false, -- highlight all matches on previous search pattern
    ignorecase = true, -- ignore case in search patterns
    laststatus = 3,
    number = true, -- set numbered lines
    numberwidth = 4, -- set number column width to 4 {default 4}
    pumheight = 5, -- Determines the maximum number of items to show in the popup menu
    relativenumber = true, -- set relative numbered lines
    ruler = false,
    scrolloff = 8, -- Minimal number of screen lines to keep above and below the cursor.
    shiftwidth = 4, -- the number of spaces inserted for each indentation
    showmode = false, -- we don't need to see things like -- INSERT -- anymore
    showtabline = 0, -- never show tabs
    sidescrolloff = 8,
    signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
    smartcase = true, -- smart case
    smartindent = true, -- make indenting smarter again
    spell = true, -- enable spellchecker
    spelllang = "en,ru", -- specify languages for spellchecking
    splitbelow = true, -- force all horizontal splits to go below current window
    splitright = true, -- force all vertical splits to go to the right of current window
    swapfile = false, -- creates a swapfile
    tabstop = 4, -- insert 4 spaces for a tab
    softtabstop = 4,
    termguicolors = true, -- set term gui colors (most terminals support this)
    timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
    ttimeoutlen = 100,
    undofile = true, -- enable persistent undo
    updatetime = 1000, -- faster completion (4000ms default)
    wrap = false, -- display lines as one long line
    writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

--  SETTINGS  ---
vim.opt.list = false
vim.opt.shortmess:append("c") -- don't show redundant messages from ins-completion-menu
vim.opt.shortmess:append("I") -- don't show the default intro message
vim.opt.whichwrap:append("<,>,[,],h,l")
-- https://github.com/kevinhwang91/nvim-ufo/issues/4
-- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- [[
-- netwr customization
local netwr_options = {
    netrw_banner = 0,
    netrw_liststyle = 0,
    netrw_winsize = 75,
}

for k, v in pairs(netwr_options) do
    vim.g[k] = v
end
-- ]]

for k, v in pairs(options) do
    vim.opt[k] = v
end
