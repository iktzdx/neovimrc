local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { import = "user.plugins.ui" },
    { import = "user.plugins.nav" },
    { import = "user.plugins.treesitter" },
    { import = "user.plugins.cmp" },
    { import = "user.plugins.lsp" },
    { import = "user.plugins.vcs" },
    { import = "user.plugins.dap" },
    { import = "user.plugins.golang" },
    { import = "user.plugins.utils" },
    { import = "user.plugins.test" },
}, {
    install = {
        colorscheme = { "onedark" },
    },
    checker = {
        enabled = false,
        notify = true,
    },
    change_detection = {
        notify = false,
    },
})
