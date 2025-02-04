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

            require("mason-lspconfig").setup({
                ensure_installed = {},
                handlers = {
                    -- this first function is the "default handler"
                    -- it applies to every language server without a "custom handler"
                    -- function(server_name)
                    --     if server_name == "tsserver" then
                    --         server_name = "ts_ls"
                    --     else
                    --         require("lspconfig")[server_name].setup({})
                    --     end
                    -- end,

                    lua_ls = function()
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        lspconfig.lua_ls.setup(lua_opts)
                    end,
                    -- ts_ls = function()
                    --     lspconfig.ts_ls.setup({ javascript = { validate = false } })
                    -- end,
                    -- volar = function()
                    --     lspconfig.volar.setup({
                    --         filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
                    --         init_options = {
                    --             vue = {
                    --                 hybridMode = false,
                    --             },
                    --         },
                    --     })
                    -- end,
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
                    -- Some "ifology" using `ft` of opened file
                    return {
                        includeInlayParameterNameHints = "all",
                        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                        includeInlayFunctionParameterTypeHints = false,
                        includeInlayVariableTypeHints = false,
                        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                        includeInlayPropertyDeclarationTypeHints = false,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                    }
                end,
            },
        },
    },
}
