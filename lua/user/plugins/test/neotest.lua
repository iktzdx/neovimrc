local function neotest_config()
    local neotest_ns = vim.api.nvim_create_namespace("neotest")
    vim.diagnostic.config({
        virtual_text = {
            format = function(diagnostic)
                -- Replace newline and tab characters with space for more compact diagnostics
                local message = diagnostic.message
                    :gsub("\n", " ")
                    :gsub("\t", " ")
                    :gsub("%s+", " ")
                    :gsub("^%s+", "")
                return message
            end,
        },
    }, neotest_ns)
    local neotest = require("neotest")

    neotest.setup({
        status = { virtual_text = true, signs = false },
        output = { open_on_run = true },
        diagnostic = {
            enabled = true,
            severity = vim.diagnostic.severity.ERROR,
        },
        library = { plugins = { "neotest" }, types = true },
        adapters = {
            require("neotest-go")({
                experimental = {
                    test_table = true,
                },
                args = { "-count=1", "-timeout=60s" },
            }),
        },
        -- TODO: Setup trouble plugin
        -- <https://www.lazyvim.org/extras/test/core#neotest-1>
        -- quickfix = {
        --     open = function()
        --         if require("lazyvim.util").has("trouble.nvim") then
        --             require("trouble").open({ mode = "quickfix", focus = false })
        --         else
        --             vim.cmd("copen")
        --         end
        --     end,
        -- },
    })

    -- MAPPINGS

    -- Runners
    vim.keymap.set("n", "<leader>nrt", function()
        neotest.run.run()
    end, { desc = "Run the nearest test" })

    vim.keymap.set("n", "<leader>nrf", function()
        neotest.run.run(vim.fn.expand("%"))
    end, { desc = "Run the current file" })

    vim.keymap.set("n", "<leader>nwt", function()
        neotest.watch.toggle()
    end, { desc = "Watch the nearest test" })

    vim.keymap.set("n", "<leader>nwf", function()
        neotest.watch.toggle(vim.fn.expand("%"))
    end, { desc = "Watch the current file" })

    -- TODO: Run integration test
    -- https://github.com/nvim-neotest/neotest-go?tab=readme-ov-file#additional-arguments
    -- local path = vim.fn.getcwd()
    -- neotest.run.run({path, extra_args = {"-tags integration,mock -race"}})

    -- NOTE: still WIP
    -- <https://github.com/nvim-neotest/neotest-go/pull/13>
    -- vim.keymap.set("n", "<leader>ndt", function()
    --     neotest.run.run({ strategy = "dap" })
    -- end, { desc = "Debug the nearest test" })

    -- Jump between tests
    vim.keymap.set("n", "]t", function()
        neotest.jump.next()
    end, { desc = "Jump to the next test" })

    vim.keymap.set("n", "[t", function()
        neotest.jump.prev()
    end, { desc = "Jump to the prev test" })

    vim.keymap.set("n", "]n", function()
        neotest.jump.next({ status = "failed" })
    end, { desc = "Jump to the next failed test" })

    vim.keymap.set("n", "[n", function()
        neotest.jump.prev({ status = "failed" })
    end, { desc = "Jump to the prev failed test" })

    -- Open UI
    vim.keymap.set("n", "<leader>ntO", function()
        neotest.output_panel.toggle()
    end, { desc = "Open the output panel" })

    vim.keymap.set("n", "]o", function()
        neotest.output.open({ enter = false, auto_close = true })
    end, { desc = "Open the output panel" })

    vim.keymap.set("n", "<leader>nts", function()
        neotest.summary.toggle()
    end, { desc = "Toggle the summary pannel" })

    -- NOTE: Mappings for the summary pannel:
    -- <https://github.com/nvim-neotest/neotest/blob/master/lua/neotest/config/init.lua#L217>
    -- `r` — run
    -- `o` — show output
    -- `u` — stop
    -- `w` — watch
    -- `i` — jump to
    -- `d` — debug
    -- `m` — mark
    -- `R` — run marked
    -- `D` — debug marked
    -- `M` — clear marked
    -- `J` — next failed
    -- `K` — prev failed
end

return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-go",
        "folke/neodev.nvim",
    },
    config = neotest_config,
}
