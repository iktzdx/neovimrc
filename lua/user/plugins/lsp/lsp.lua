local function mason_lsp_options()
    local options = {
        ensure_installed = {
            "bashls",
            "gopls",
            "golangci_lint_ls",
            "intelephense",
            "lua_ls",
            "tsserver",
            "yamlls",
        },
    }

    return options
end

local function mason_lsp_handlers()
    local lspconfig = require("lspconfig")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    local handlers = {
        -- default handler (optional)
        function(server_name)
            lspconfig[server_name].setup({
                capabilities = capabilities,
            })
        end,

        -- Next, you can provide targeted overrides for specific servers.

        -- [[
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
        -- ]]

        -- [[
        -- Golang Setup
        ["gopls"] = function()
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
        end,
        -- ]]

        -- [[
        -- golangci-lint
        ["golangci_lint_ls"] = function()
            lspconfig.golangci_lint_ls.setup({
                cmd = { "golangci-lint-langserver" },
                filetypes = { "go", "gomod" },
                root_dir = lspconfig.util.root_pattern(
                    ".golangci.yml",
                    ".golangci.yaml",
                    ".golangci.toml",
                    ".golangci.json",
                    "go.work",
                    "go.mod",
                    ".git"
                ),
                init_options = {
                    command = {
                        "golangci-lint",
                        "run",
                        "--out-format",
                        "json",
                        "--issues-exit-code=1",
                    },
                },
            })
        end,
        -- ]]

        -- [[
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
        -- ]]

        -- [[
        -- YAML Setup
        ["yamlls"] = function()
            lspconfig.yamlls.setup({
                capabilities = capabilities,

                settings = {
                    yaml = {
                        schemas = {
                            ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.0/all.json"] =
                            "k8s/**",
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
        end,
        -- ]]
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

    vim.api.nvim_create_augroup("UserLspConfig", {})

    -- autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
    vim.api.nvim_create_autocmd({ "CursorHold", "LspAttach" }, {
        group = "UserLspConfig",
        callback = function()
            vim.o.updatetime = 2000
            vim.lsp.buf.document_highlight()
        end
    })
    -- autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
    vim.api.nvim_create_autocmd({ "CursorHoldI", "LspAttach" }, {
        group = "UserLspConfig",
        callback = function()
            vim.o.updatetime = 2000
            vim.lsp.buf.document_highlight()
        end
    })
    -- autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    vim.api.nvim_create_autocmd({ "CursorMoved", "LspAttach" }, {
        group = "UserLspConfig",
        callback = function()
            vim.lsp.buf.clear_references()
        end
    })

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
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
            vim.keymap.set("n", "[d", function()
                vim.diagnostic.goto_next()
            end, params)
            vim.keymap.set("n", "]d", function()
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
    },
    opts = mason_lsp_options,
    config = mason_lsp_config,
}
