local function harpoon_config()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    vim.keymap.set("n", "<leader>ha", mark.add_file)
    vim.keymap.set("n", "<leader>hl", ui.toggle_quick_menu)

    vim.keymap.set("n", "]h", function()
        ui.nav_next()
    end)
    vim.keymap.set("n", "[h", function()
        ui.nav_prev()
    end)

    vim.keymap.set("n", "<leader>hq", function()
        ui.nav_file(1)
    end)
    vim.keymap.set("n", "<leader>hw", function()
        ui.nav_file(2)
    end)
    vim.keymap.set("n", "<leader>he", function()
        ui.nav_file(3)
    end)
end

return {
    "theprimeagen/harpoon",
    config = harpoon_config,
}
