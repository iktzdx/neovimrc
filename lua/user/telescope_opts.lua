local M = {}

M.find_files = {
    file_ignore_patterns = { ".git/" },
    follow = true,
    hidden = true,
    no_ignore = true,
    previewer = false,
    results_title = false,
    layout_strategy = "vertical",
    layout_config = {
        anchor = "N",
        height = 15,
        mirror = true,
        prompt_position = "top",
        width = 80,
    },
}

M.buffers = {
    previewer = false,
    results_title = false,
    layout_strategy = "vertical",
    layout_config = {
        anchor = "N",
        height = 15,
        prompt_position = "top",
        width = 80,
    },
}

M.live_grep = {
    file_ignore_patterns = { ".git/" },
    follow = true,
    hidden = true,
    no_ignore = true,
    results_title = false,
    layout_strategy = "vertical",
    layout_config = {
        height = 20,
        preview_cutoff = 1,
        prompt_position = "top",
        width = 80,
    },
}

M.help_tags = {
    layout_strategy = "vertical",
    layout_config = {
        height = 20,
        preview_cutoff = 1,
        prompt_position = "top",
        width = 80,
    },
}

M.lsp = {
    layout_config = {
        height = 15,
        width = 100,
    },
}

return M
