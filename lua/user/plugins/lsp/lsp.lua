local function mason_lsp_handlers()
    local lspconfig = require("lspconfig")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    local handlers = {
        function(server_name)
            lspconfig[server_name].setup({
                capabilities = capabilities,
            })
        end,

        -- Lua Setup
        ["lua_ls"] = function()
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
        end,

        -- Golang Setup
        ["gopls"] = function()
            lspconfig.gopls.setup({
                capabilities = capabilities,

                cmd = { "gopls" },
                filetypes = { "go", "gomod", "gowork", "gotmpl" },
                root_dir = lspconfig.util.root_pattern(
                    "go.work",
                    "go.mod",
                    ".git"
                ),
                single_file_support = true,

                settings = {
                    gopls = {
                        completeUnimported = true,
                        completeFunctionCalls = true,
                        usePlaceholders = true,
                        analyses = {
                            unusedparams = true,
                            fillstruct = true,
                            shadow = true,
                        },
                        staticcheck = true,
                        buildFlags = { "-tags=integration,mock,e2e" },
                        gofumpt = true,
                        diagnosticsDelay = "250ms",
                    },
                },
            })
        end,

        -- golangci-lint language server
        ["golangci_lint_ls"] = function()
            lspconfig.golangci_lint_ls.setup({
                cmd = { "golangci-lint-langserver" },
                filetypes = { "go", "gomod", "gosum", "gowork", "gotmpl" },
                root_dir = lspconfig.util.root_pattern(
                    ".golangci.yml",
                    ".golangci.yaml",
                    ".golangci.toml",
                    ".golangci.json",
                    "go.work",
                    "go.mod",
                    ".git"
                ),
            })
        end,

        -- PHP Setup
        ["intelephense"] = function()
            lspconfig.intelephense.setup({

                capabilities = capabilities,
                init_options = {
                    globalStoragePath = os.getenv("HOME")
                        .. "/.local/share/intelephense",
                },
            })
        end,

        -- JSON Setup
        ["jsonls"] = function()
            lspconfig.jsonls.setup({
                capabilities = capabilities,

                settings = {
                    json = {
                        schemas = require("schemastore").json.schemas(),
                        validate = { enable = true },
                    },
                },
            })
        end,

        -- YAML Setup
        ["yamlls"] = function()
            lspconfig.yamlls.setup({
                capabilities = capabilities,

                settings = {
                    yaml = {
                        schemaStore = {
                            enable = false,
                            url = "",
                        },
                        schemas = require("schemastore").yaml.schemas(),
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
        end,
    }

    return handlers
end

local function mason_lsp_config(_, opts)
    require("fidget").setup({
        notification = {
            window = {
                winblend = 0,
            },
        },
    })

    require("mason").setup()
    require("mason-lspconfig").setup(opts)
    require("mason-lspconfig").setup_handlers(mason_lsp_handlers())

    require("mason-tool-installer").setup({
        ensure_installed = {
            -- LSP
            "bashls",
            "golangci_lint_ls",
            "gopls",
            "jsonls",
            "intelephense",
            "lua_ls",
            "tsserver",
            "yamlls",

            -- Linters
            { "golangci-lint", version = "v1.56.2" },
            "staticcheck",
            "luacheck",
            "jsonlint",
            "fixjson",
            "yamllint",
            "shellcheck",
            "codespell",

            -- Formatters
            "gci",
            "gofumpt",
            "goimports",
            "golines",
            "stylua",
            "prettier",

            -- Debggers
            "delve",

            -- Other tools
            "gomodifytags",
            "gotests",
            "impl",
            "json-to-struct",
        },
        auto_update = false,
        run_on_start = true,
        start_delay = 3000,
        debounce_hours = 1,
    })

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_augroup("UserLspConfig", {})
    vim.api.nvim_create_autocmd("LspAttach", {
        group = "UserLspConfig",
        callback = function(ev)
            -- Enable completion triggered by <c-x><c-o>
            vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

            -- Buffer local mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local params = { buffer = ev.buf }
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, params)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, params)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, params)
            vim.keymap.set("n", "<C-h>", vim.lsp.buf.signature_help, params)
            vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, params)
            vim.keymap.set(
                { "n", "v" },
                "<leader>vca",
                vim.lsp.buf.code_action,
                params
            )
            vim.keymap.set("n", "<leader>vd", function()
                vim.diagnostic.open_float()
            end, params)
            vim.keymap.set({ "n", "v" }, "]d", function()
                vim.diagnostic.goto_next()
            end, params)
            vim.keymap.set({ "n", "v" }, "[d", function()
                vim.diagnostic.goto_prev()
            end, params)
        end,
    })

    vim.diagnostic.config({
        update_in_insert = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    })
end

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "j-hui/fidget.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "b0o/schemastore.nvim",
    },
    opts = {},
    config = mason_lsp_config,
}
