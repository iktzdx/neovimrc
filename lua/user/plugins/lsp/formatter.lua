local function conform_options()
    local options = {
        formatters_by_ft = {
            lua = { "stylua" },
            go = { { "gofumpt", "gofmt" }, "goimports", "golines" },
            json = { "fixjson" },
            yaml = { "prettier" },
            markdown = { "prettier" },
            ["*"] = { "codespell" },
        },
        format_on_save = {
            lsp_fallback = true,
            timeout_ms = 200,
        },
        log_level = vim.log.levels.ERROR,
        notify_on_error = true,
    }

    return options
end

local function conform_config(_, opts)
    local conform = require("conform")

    conform.setup(opts)

    -- 140 is the preferred line length for go code
    conform.formatters.golines = {
        prepend_args = { "-m", "140" },
    }

    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
            require("conform").format({ bufnr = args.buf })
        end,
    })

    vim.keymap.set({ "n", "v" }, "<leader>fm", function()
        conform.format({ lsp_fallback = true, timeout_ms = 200 })
    end, { desc = "Format file or range via conform.nvim" })
end

return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "ConformInfo" },
    opts = conform_options,
    config = conform_config,
}
