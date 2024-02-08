local function fugitive_config()
    local UserGroup_Fugitive =
        vim.api.nvim_create_augroup("UserGroup_Fugitive", {})

    local autocmd = vim.api.nvim_create_autocmd
    autocmd("BufWinEnter", {
        group = UserGroup_Fugitive,
        pattern = "*",
        callback = function()
            if vim.bo.ft ~= "fugitive" then
                return
            end

            local bufnr = vim.api.nvim_get_current_buf()
            local opts = { buffer = bufnr, remap = false }
            vim.keymap.set("n", "<leader>fp", function()
                vim.cmd.Git("push")
            end, opts)

            -- NOTE: It allows me to easily set the branch i am pushing and any tracking
            -- needed if i did not set the branch up correctly
            vim.keymap.set("n", "<leader>ft", ":Git push -u origin ", opts)
        end,
    })

    vim.keymap.set("n", "<leader>fs", vim.cmd.Git, {
        desc = ":Git opens a summary window with dirty files and unpushed and unpulled commits",
    })
    vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")
    vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")
end

return {
    "tpope/vim-fugitive",
    config = fugitive_config,
}
