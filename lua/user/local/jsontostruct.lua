-- [[
-- A wrapper around https://github.com/tmc/json-to-struct
-- Inspired by https://github.com/meain/vim-jsontogo/blob/master/plugin/jsontogo.vim
-- ]]

local function JSONToStructFunc(opts)
    local curr_filename = vim.fn.fnamemodify(vim.fn.expand("%:t"), ":r")
    local struct_name = opts.fargs[1] or curr_filename

    local cmd = { "!json-to-struct" }

    table.insert(cmd, "-name=" .. struct_name)
    -- do not emit struct field tags with 'omitempty'
    -- and cut package name
    table.insert(cmd, "-omitempty=false | tail -n +3")

    local command = opts.line1 .. "," .. opts.line2 .. table.concat(cmd, " ")
    vim.fn.execute(command)
end

vim.api.nvim_create_user_command("JSONToStruct", JSONToStructFunc, {
    bang = true,
    bar = true,
    nargs = "?",
    range = "%",
})
