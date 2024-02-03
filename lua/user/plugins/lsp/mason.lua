local function mason_lsp_options()
    local options = {
        ensure_installed = {
            "bashls",
            "gopls",
            "intelephense",
            "lua_ls",
            "tsserver",
            "yamlls",
        },
    }

    return options
end

local function mason_lsp_config(_, opts)
    require("mason").setup()
    require("mason-lspconfig").setup(opts)

    local lspconfig = require('lspconfig')
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    require("mason-lspconfig").setup_handlers({
        function(server_name)
            lspconfig[server_name].setup({
                capabilities = capabilities,
            })
        end,
    })
end

return {
    "williamboman/mason-lspconfig.nvim",
    opts = mason_lsp_options,
    config = mason_lsp_config,
    dependencies = {
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig",
    },
}
