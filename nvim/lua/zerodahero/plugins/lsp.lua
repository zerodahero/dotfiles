return {
    { -- Autocompletion
        "saghen/blink.cmp",
        event = "VimEnter",
        version = "1.*",
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                version = "2.*",
                build = (function()
                    return "make install_jsregexp"
                end)(),
                dependencies = {},
                opts = {},
            },
            "folke/lazydev.nvim",
        },
        --- @module 'blink.cmp'
        --- @type blink.cmp.Config
        opts = {
            keymap = {
                preset = "default",
                -- ["<C-b>"] = { "show", "show_documentation", "hide_documentation" },
                ["<Tab>"] = false,
                ["<S-Tab>"] = false,
                ["<C-l>"] = { "snippet_forward", "fallback" },
                ["<C-j>"] = { "snippet_backward", "fallback" },
            },
            appearance = {
                nerd_font_variant = "mono",
            },
            completion = {
                -- By default, you may press `<c-space>` to show the documentation.
                -- Optionally, set `auto_show = true` to show the documentation after a delay.
                documentation = { auto_show = false, auto_show_delay_ms = 500 },
            },

            sources = {
                default = { "lsp", "path", "snippets", "lazydev" },
                providers = {
                    lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
                },
            },

            snippets = { preset = "luasnip" },

            fuzzy = { implementation = "lua" },

            signature = { enabled = true },
        },
    },

    {
        -- Main LSP Configuration
        "neovim/nvim-lspconfig",
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "mason-org/mason-lspconfig.nvim",

            { "j-hui/fidget.nvim", opts = {} },

            "saghen/blink.cmp",
        },
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP Actions",
                group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
                callback = function(event)
                    local opts = { buffer = event.buf }
                    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
                    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
                    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
                    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
                    vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
                    vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
                    vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
                    vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
                    -- vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
                    vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
                    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
                    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
                    -- vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
                    -- vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
                    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
                    -- vim.keymap.set(
                    --     "n",
                    --     "<leader>h",
                    --     ":LspOverloadsSignature<CR>",
                    --     { noremap = true, silent = true, buffer = bufnr }
                    -- )
                    -- vim.keymap.set("n", "<leader>k", function()
                    --     vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr }), { bufnr })
                    -- end, opts)

                    -- vim.keymap.set("n", "<leader><leader>cs", ":LspRestart omnisharp<CR>", { noremap = true })
                    vim.keymap.set("n", "<leader><leader>lsp", ":LspRestart<CR>", { noremap = true })

                    --- Guard against servers without the signatureHelper capability
                    -- if client.server_capabilities.signatureHelpProvider then
                    --     require("lsp-overloads").setup(client, {})
                    -- end

                    -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
                    ---@param client vim.lsp.Client
                    ---@param method vim.lsp.protocol.Method
                    ---@param bufnr? integer some lsp support methods only in specific files
                    ---@return boolean
                    local function client_supports_method(client, method, bufnr)
                        if vim.fn.has("nvim-0.11") == 1 then
                            return client:supports_method(method, bufnr)
                        else
                            return client.supports_method(method, { bufnr = bufnr })
                        end
                    end

                    -- The following two autocommands are used to highlight references of the
                    -- word under your cursor when your cursor rests there for a little while.
                    --    See `:help CursorHold` for information about when this is executed
                    --
                    -- When you move your cursor, the highlights will be cleared (the second autocommand).
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if
                        client
                        and client_supports_method(
                            client,
                            vim.lsp.protocol.Methods.textDocument_documentHighlight,
                            event.buf
                        )
                    then
                        local highlight_augroup =
                            vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
                        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.clear_references,
                        })

                        vim.api.nvim_create_autocmd("LspDetach", {
                            group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
                            callback = function(event2)
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
                            end,
                        })
                    end

                    if
                        client
                        and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
                    then
                        vim.keymap.set("n", "<leader>k", function()
                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
                        end, opts)
                    end
                end,
            })

            -- Diagnostic Config
            -- See :help vim.diagnostic.Opts
            vim.diagnostic.config({
                severity_sort = true,
                float = { border = "rounded", source = "if_many" },
                underline = { severity = vim.diagnostic.severity.ERROR },
                signs = vim.g.have_nerd_font and {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "󰅚 ",
                        [vim.diagnostic.severity.WARN] = "󰀪 ",
                        [vim.diagnostic.severity.INFO] = "󰋽 ",
                        [vim.diagnostic.severity.HINT] = "󰌶 ",
                    },
                } or {},
                virtual_text = false, -- use lsp-lines for virtual text
                -- virtual_text = {
                --     source = "if_many",
                --     spacing = 2,
                --     format = function(diagnostic)
                --         local diagnostic_message = {
                --             [vim.diagnostic.severity.ERROR] = diagnostic.message,
                --             [vim.diagnostic.severity.WARN] = diagnostic.message,
                --             [vim.diagnostic.severity.INFO] = diagnostic.message,
                --             [vim.diagnostic.severity.HINT] = diagnostic.message,
                --         }
                --         return diagnostic_message[diagnostic.severity]
                --     end,
                -- },
            })

            local servers = {
                -- clangd = {},
                -- gopls = {},
                -- pyright = {},
                -- rust_analyzer = {},
                -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
                --
                -- Some languages (like typescript) have entire language plugins that can be useful:
                --    https://github.com/pmizio/typescript-tools.nvim
                --
                -- But for many setups, the LSP (`ts_ls`) will work just fine
                -- ts_ls = {},
                --
                nim_langserver = {
                    -- cmd = { "nim-langserver" }, -- This is the default, so you can remove this line
                    -- filetypes = { "nim", "nimble" }, -- This is the default, so you can remove this line
                    -- capabilities = capabilities,
                    settings = {
                        nim = {
                            logNimsuggest = false,
                            notificationVerbosity = "warning",
                        },
                    },
                },

                lua_ls = {
                    -- cmd = { ... },
                    -- filetypes = { ... },
                    -- capabilities = {},
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = "Replace",
                            },
                            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                            -- diagnostics = { disable = { 'missing-fields' } },
                        },
                    },
                },
            }

            -- Ensure the servers and tools above are installed
            --
            -- To check the current status of installed tools and/or manually install
            -- other tools, you can run
            --    :Mason
            --
            -- You can press `g?` for help in this menu.
            --
            -- `mason` had to be setup earlier: to configure its options see the
            -- `dependencies` table for `nvim-lspconfig` above.
            --
            -- You can add other tools here that you want Mason to install
            -- for you, so that they are available from within Neovim.
            local ensure_installed = vim.tbl_keys(servers or {})
            -- vim.list_extend(ensure_installed, {
            --     "stylua", -- Used to format Lua code
            -- })

            require("mason-lspconfig").setup({
                -- automatic_enable = true, -- automatically enable all servers that are installed
                ensure_installed = ensure_installed,
                -- handlers = {
                --     function(server_name)
                --         local server = servers[server_name] or {}
                --         -- This handles overriding only values explicitly passed
                --         -- by the server configuration above. Useful when disabling
                --         -- certain features of an LSP (for example, turning off formatting for ts_ls)
                --         server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                --         require("lspconfig")[server_name].setup(server)
                --     end,
                -- },
            })

            for server_name, config in pairs(servers) do
                vim.lsp.config(server_name, config)
            end
        end,
    },
    {
        "cwrau/yaml-schema-detect.nvim",
        ---@module "yaml-schema-detect"
        ---@type YamlSchemaDetectOptions
        opts = {
            disable_keymap = true,
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        ft = { "yaml" },
    },
    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        opts = {},
        keys = {
            {
                "<leader>l",
                function()
                    require("lsp_lines").toggle()
                end,
                desc = "Toggle lsp_lines",
            },
        },
    },
    {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = {
            settings = {
                tsserver_file_preferences = function(ft)
                    return {
                        includeInlayParameterNameHints = "all",
                        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                        includeInlayFunctionParameterTypeHints = false,
                        includeInlayVariableTypeHints = true,
                        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                    }
                end,
            },
        },
    },

    {
        "apple/pkl-neovim",
        lazy = true,
        ft = "pkl",
        build = function()
            require("pkl-neovim").init()

            -- Set up syntax highlighting.
            vim.cmd("TSInstall pkl")
        end,
        config = function()
            -- Set up snippets.
            require("luasnip.loaders.from_snipmate").lazy_load()

            -- Configure pkl-lsp
            -- vim.g.pkl_neovim = {
            -- start_command = { "java", "-jar", "/path/to/pkl-lsp.jar" },
            -- or if pkl-lsp is installed with brew:
            -- start_command = { "pkl-lsp" },
            -- pkl_cli_path = "pkl",
            -- }
        end,
    },
    {
        "scalameta/nvim-metals",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        ft = { "scala", "sbt", "java" },
        opts = function()
            local metals_config = require("metals").bare_config()

            metals_config.init_options.statusBarProvider = "off"

            -- TODO: move to blink
            -- metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

            metals_config.settings = {
                javaHome = vim.fn.getenv("JAVA_HOME_PROJECT") or vim.fn.getenv("JAVA_HOME"),
            }

            return metals_config
        end,
        config = function(self, metals_config)
            local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = self.ft,
                callback = function()
                    require("metals").initialize_or_attach(metals_config)
                end,
                group = nvim_metals_group,
            })
        end,
    },

    {
        "ray-x/lsp_signature.nvim",
        event = "InsertEnter",
        opts = {
            bind = true,
        },
    },

    {
        "SmiteshP/nvim-navic",
        opts = {
            lsp = { auto_attach = true, preference = { "volar" } },
            highlight = true,
        },
    },
}
