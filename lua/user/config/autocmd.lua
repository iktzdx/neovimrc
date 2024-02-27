local user_group = vim.api.nvim_create_augroup("UserGroup", {
    clear = true,
})
-- Save cursor last position
-- from :help last-position-jump
vim.api.nvim_create_autocmd("BufRead", {
    pattern = "*",
    group = user_group,
    callback = function()
        vim.cmd([[
      autocmd FileType <buffer> ++once
        \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif
    ]])
    end,
})

-- Disable line numbers for terminal buftype
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    group = user_group,
    callback = function()
        vim.cmd([[ setlocal nonumber norelativenumber ]])
    end,
})

-- Use JSONToStruct command only for Go files
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    pattern = "*.go",
    group = user_group,
    callback = function()
        require("user.local.jsontostruct")
    end,
})

-- Set indentation to 2 spaces for JSON files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "json",
    group = user_group,
    command = "setlocal ts=2 sw=2 expandtab",
})
