local function comment_config()
    require("Comment").setup()
end

local function todo_config()
    require("todo-comments").setup()
end

return {
    {
        "numToStr/Comment.nvim",
        lazy = false,
        config = comment_config
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = todo_config,
    },
}

