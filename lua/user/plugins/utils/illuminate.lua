local function illuminate_options()
    local options = {
        providers = {
            "treesitter",
            "lsp",
        },
        delay = 300,
        filetypes_denylist = {
            "dirbuf",
            "dirvish",
            "fugitive",
            "TelescopePrompt",
        },
        under_cursor = true,
        min_count_to_highlight = 1,
    }

    return options
end

local function illuminate_config(_, opts)
    local ok, illuminate = pcall(require, "illuminate")
    if not ok then
        -- Highlight document under the cursor
        vim.bo.updatetime = 300
        local hl_group = vim.api.nvim_create_augroup("HLUserGroup", {
            clear = true,
        })

        vim.api.nvim_create_autocmd("CursorHold", {
            group = hl_group,
            callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd("CursorMoved", {
            group = hl_group,
            command = vim.lsp.buf.clear_references,
        })
    end

    illuminate.configure(opts)

    vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
    vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
    vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })

    vim.keymap.set("n", "<leader>iht", function()
        illuminate.toggle()
    end, { desc = "Globally toggle the pause/resume for vim-illuminate." })

    vim.keymap.set("n", "<leader>ihn", function(wrap)
        illuminate.goto_next_reference(wrap)
    end, {
        desc = "Move the cursor to the closest references after the cursor which it is not currently on.",
    })

    vim.keymap.set("n", "<leader>ihp", function(wrap)
        illuminate.goto_prev_reference(wrap)
    end, {
        desc = "Move the cursor to the closest references before the cursor which it is not currently on.",
    })
end

return {
    "RRethy/vim-illuminate",
    opts = illuminate_options,
    config = illuminate_config,
}
