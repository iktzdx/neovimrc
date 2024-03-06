local function lint_config()
    local nvim_lint = require("lint")

    nvim_lint.linters_by_ft = {
        go = { "golangcilint" },
        lua = { "luacheck" },
        json = { "jsonlint" },
        sh = { "shellcheck" },
        yaml = { "yamllint" },
    }

    local golangcilint = require("lint.linters.golangcilint")
    golangcilint.args = {
        "run",
        "-j",
        "$(nproc)",
        "--out-format",
        "json",
        "--allow-parallel-runners",
        "--fix",
        "--issues-exit-code=1",
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
            nvim_lint.try_lint()
        end,
    })

    vim.keymap.set("n", "<leader>ll", function()
        nvim_lint.try_lint()
    end, { desc = "Trigger linting for the current file" })
end

return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = lint_config,
}
