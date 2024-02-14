-- Save cursor last position
-- from :help last-position-jump
vim.api.nvim_create_autocmd("BufRead", {
    pattern = "*",
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
    callback = function()
        vim.cmd([[ setlocal nonumber norelativenumber ]])
    end,
})
