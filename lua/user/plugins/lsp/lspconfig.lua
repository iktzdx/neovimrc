-- [[
-- Language Server Protocol configurations
local function lspconfig_config()
    -- [[
    -- Native LSP keymaps
    vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(event)
            -- Create your keybindings here...
            local opts = { buffer = event.buf, remap = false }
            vim.keymap.set("n", "<leader>vd", function()
                vim.diagnostic.open_float()
            end, opts)
            vim.keymap.set("n", "[d", function()
                vim.diagnostic.goto_next()
            end, opts)
            vim.keymap.set("n", "]d", function()
                vim.diagnostic.goto_prev()
            end, opts)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "<C-h>", vim.lsp.buf.signature_help, opts)
            vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
            vim.keymap.set({ "n", "v" }, "<leader>vca", vim.lsp.buf.code_action, opts)
        end,
    })
    -- ]]

    local lspconfig = require("lspconfig")

    -- Add additional capabilities supported by nvim-cmp
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    -- [[
    -- Lua LSP
    lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                },
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                        [vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types"] = true,
                        [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
                    },
                    maxPreload = 100000,
                    preloadFileSize = 10000,
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    })
    -- ]]

    -- [[
    -- Golang LSP
    lspconfig.gopls.setup({
        capabilities = capabilities,

        settings = {
            gopls = {
                completeUnimported = true,
                usePlaceholders = true,
                analyses = {
                    unusedparams = true,
                    fillstruct = true,
                },
                staticcheck = true,
            },
        },
    })
    -- ]]

    -- [[
    -- PHP LSP
    lspconfig.intelephense.setup({
        capabilities = capabilities,
        init_options = {
            globalStoragePath = os.getenv("HOME") .. "/.local/share/intelephense",
        },
    })
    -- ]]

    -- [[
    -- YAML LSP
    lspconfig.yamlls.setup({
        capabilities = capabilities,

        settings = {
            yaml = {
                schemas = {
                    ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.0/all.json"] = "k8s/**",
                    ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = {
                        "ci/*.yml",
                        ".gitlab-ci.yml",
                    },
                },
                customTags = {
                    "!reference sequence",
                },
            },
            redhat = {
                telemetry = {
                    enabled = false,
                },
            },
        },
    })
    -- ]]

    -- [[
    -- TypeScript LSP
    lspconfig.tsserver.setup({
        capabilities = capabilities,
    })
    -- ]]

    -- [[
    -- Bash LSP
    lspconfig.bashls.setup({
        capabilities = capabilities,
    })
    --]]
end
-- ]]

return {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = lspconfig_config,
}
