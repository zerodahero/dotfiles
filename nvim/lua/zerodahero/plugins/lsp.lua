return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v4.x",
        lazy = true,
        config = false,
    },
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = true,
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            { "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp" },
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lsp-signature-help" },
        },
        config = function()
            local cmp = require("cmp")
            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

            local cmp_format = require("lsp-zero").cmp_format()

            cmp.setup({
                completion = { completeopt = "menu,menuone,noinsert" },
                mapping = cmp.mapping.preset.insert({
                    -- disable completion with tab
                    -- this helps with copilot setup
                    ["<Tab>"] = nil,
                    ["<S-Tab>"] = nil,
                    ["<CR>"] = nil,
                    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
                formatting = cmp_format,
                sources = {
                    { name = "path" },
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "nvim_lua" },
                    { name = "nvim_lsp_signature_help" },
                    { name = "render-markdown" },
                },
            })
        end,
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            { "Issafalcon/lsp-overloads.nvim" },
            { "Hoffs/omnisharp-extended-lsp.nvim" },
        },
        config = function()
            local lsp_zero = require("lsp-zero")

            -- lsp_attach is where you enable features that only work
            -- if there is a language server active in the file
            local lsp_attach = function(client, bufnr)
                local opts = { buffer = bufnr }

                lsp_zero.default_keymaps({ buffer = bufnr })

                vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
                vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
                -- vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
                -- vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
                vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
                vim.keymap.set(
                    "n",
                    "<leader>h",
                    ":LspOverloadsSignature<CR>",
                    { noremap = true, silent = true, buffer = bufnr }
                )
                vim.keymap.set("n", "<leader>k", function()
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr }), { bufnr })
                end, opts)

                vim.keymap.set("n", "<leader><leader>cs", ":LspRestart omnisharp<CR>", { noremap = true })
                vim.keymap.set("n", "<leader><leader>lsp", ":LspRestart<CR>", { noremap = true })

                --- Guard against servers without the signatureHelper capability
                if client.server_capabilities.signatureHelpProvider then
                    require("lsp-overloads").setup(client, {})
                end
            end

            lsp_zero.extend_lspconfig({
                sign_text = true,
                lsp_attach = lsp_attach,
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
            })
            lsp_zero.configure("omnisharp", {
                handlers = { ["textDocument/definition"] = require("omnisharp_extended").handler },
            })

            local lspconfig = require("lspconfig")

            lspconfig.nim_langserver.setup({
                settings = {
                    nim = {
                        logNimsuggest = false,
                        notificationVerbosity = "warning",
                    },
                },
            })

            -- vim.lsp.enable('sqruff')
            vim.lsp.enable('postgres_lsp')

            require("mason-lspconfig").setup({
                ensure_installed = {},
                automatic_installation = true,
                handlers = {
                    -- this first function is the "default handler"
                    -- it applies to every language server without a "custom handler"
                    function(server_name)
                        require("lspconfig")[server_name].setup({})
                    end,

                    lua_ls = function()
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        lspconfig.lua_ls.setup(lua_opts)
                    end,
                },
            })
        end,
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
        "scalameta/nvim-metals",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        ft = { "scala", "sbt", "java" },
        opts = function()
            local metals_config = require("metals").bare_config()

            metals_config.init_options.statusBarProvider = "off"

            metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

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
