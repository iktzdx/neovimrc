local function dapgo_config(_, opts)
    local dapgo = require("dap-go")

    -- Setup
    dapgo.setup(opts)

    -- Keymaps
    vim.keymap.set("n", "<leader>dt", function()
        dapgo.debug_test()
    end, { desc = "dapgo.debug_test()" })
    vim.keymap.set("n", "<leader>dl", function()
        dapgo.debug_last_test()
    end, { desc = "dapgo.debug_last_test()" })
end

return {
    "dnlklmts/nvim-dap-go",
    config = dapgo_config,
}
