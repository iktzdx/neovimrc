local function conform_options()
    local options = {
        formatters_by_ft = {
            lua = { "stylua" },
            go = { "gci", "golines", { "gofumpt", "gofmt" } },
            json = { "fixjson" },
            yaml = { "prettier" },
            markdown = { "prettier" },
            c = { "clang-format" },
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
    conform.formatters = {
        ["clang-format"] = {
            prepend_args = { "--style=LLVM", "--fallback-style=Microsoft" },
        },
    }

    conform.formatters.golines = {
        prepend_args = { "-m", "140" },
    }

    conform.formatters.gci = {
        inherit = false,
        command = "gci",
        args = {
            "write",
            "--skip-generated",
            "--skip-vendor",
            "--custom-order",
            "-s",
            "standard",
            "-s",
            "default",
            -- "-s",
            -- "blank",
            -- "-s",
            -- "dot",
            -- "-s",
            -- "alias",
            "-s",
            "localmodule",
            "$FILENAME",
        },
        stdin = false,
    }

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
