-- Fast and easy to configure Neovim statusline
local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },
    symbols = { error = " ", warn = " " },
    colored = false,
    update_in_insert = false,
    always_visible = true,
}

local diff = {
    "diff",
    colored = false,
    -- symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
    symbols = { added = "+", modified = "~", removed = "-" }, -- changes diff symbols
    cond = function()
        return vim.fn.winwidth(0) > 80
    end
}

local mode = {
    "mode",
    fmt = function(str)
        return "-- " .. str .. " --"
    end,
}

local filetype = {
    "filetype",
    icons_enabled = false,
    icon = nil,
}

local branch = {
    "branch",
    icons_enabled = true,
    icon = "",
}

local location = {
    "location",
    padding = { left = 0, right = 1 },
}

local progress = {
    "progress",
    padding = { left = 1, right = 1 },
}

local spaces = function()
    return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local function lualine_options()
    local options = {
        options = {
            theme = "onedark",
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
        },
        sections = {
            lualine_a = { mode },
            lualine_b = { branch, diff, diagnostics },
            lualine_c = {
                {
                    "filename",
                    file_status = true,
                    newfile_status = true,
                    path = 1,
                    shorting_target = 40,
                    symbols = {
                        modified = "[+]",
                        readonly = "[-]",
                        unnamed = "[No Name]",
                        newfile = "[New]",
                    },
                },
            },
            lualine_x = { spaces, "encoding", filetype },
            lualine_y = { location },
            lualine_z = { progress },
        },
    }
    return options
end

local function lualine_config(_, opts)
    require("lualine").setup(opts)
end

return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "kyazdani42/nvim-web-devicons",
        enabled = true,
        lazy = true,
    },
    opts = lualine_options,
    config = lualine_config,
}
