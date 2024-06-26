require("neodev").setup({ library = { plugins = { "nvim-dap-ui" }, types = true } })

local lsp_zero = require("lsp-zero")

lsp_zero.set_sign_icons({ error = "✘", warn = "▲", hint = "⚑", info = "»" })

lsp_zero.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    lsp_zero.default_keymaps({ buffer = bufnr })

    if client.name == "eslint" then
        vim.cmd.LspStop("eslint")
        return
    end
    -- Workaround for semantic token issue with omnisharp-roslyn
    -- See https://github.com/OmniSharp/omnisharp-roslyn/issues/2483
    if client.name == "omnisharp" then
        client.server_capabilities.semanticTokensProvider = {
            full = vim.empty_dict(),
            legend = {
                tokenModifiers = { "static_symbol" },
                tokenTypes = {
                    "comment",
                    "excluded_code",
                    "identifier",
                    "keyword",
                    "keyword_control",
                    "number",
                    "operator",
                    "operator_overloaded",
                    "preprocessor_keyword",
                    "string",
                    "whitespace",
                    "text",
                    "static_symbol",
                    "preprocessor_text",
                    "punctuation",
                    "string_verbatim",
                    "string_escape_character",
                    "class_name",
                    "delegate_name",
                    "enum_name",
                    "interface_name",
                    "module_name",
                    "struct_name",
                    "type_parameter_name",
                    "field_name",
                    "enum_member_name",
                    "constant_name",
                    "local_name",
                    "parameter_name",
                    "method_name",
                    "extension_method_name",
                    "property_name",
                    "event_name",
                    "namespace_name",
                    "label_name",
                    "xml_doc_comment_attribute_name",
                    "xml_doc_comment_attribute_quotes",
                    "xml_doc_comment_attribute_value",
                    "xml_doc_comment_cdata_section",
                    "xml_doc_comment_comment",
                    "xml_doc_comment_delimiter",
                    "xml_doc_comment_entity_reference",
                    "xml_doc_comment_name",
                    "xml_doc_comment_processing_instruction",
                    "xml_doc_comment_text",
                    "xml_literal_attribute_name",
                    "xml_literal_attribute_quotes",
                    "xml_literal_attribute_value",
                    "xml_literal_cdata_section",
                    "xml_literal_comment",
                    "xml_literal_delimiter",
                    "xml_literal_embedded_expression",
                    "xml_literal_entity_reference",
                    "xml_literal_name",
                    "xml_literal_processing_instruction",
                    "xml_literal_text",
                    "regex_comment",
                    "regex_character_class",
                    "regex_anchor",
                    "regex_quantifier",
                    "regex_grouping",
                    "regex_alternation",
                    "regex_text",
                    "regex_self_escaped_character",
                    "regex_other_escape",
                },
            },
            range = true,
        }
        --- Guard against servers without the signatureHelper capability
        if client.server_capabilities.signatureHelpProvider then
            require("lsp-overloads").setup(client, { ui = { floating_window_above_cur_line = true } })
        end
    end

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>h", ":LspOverloadsSignature<CR>", { noremap = true, silent = true })

    vim.keymap.set("n", "<leader><leader>cs", ":LspRestart omnisharp<CR>", { noremap = true })

    -- -- Navic
    -- if client.server_capabilities.documentSymbolProvider then
    --     require('nvim-navic').attach(client, bufnr)
    -- end
end)

lsp_zero.configure("omnisharp", {
    handlers = { ["textDocument/definition"] = require("omnisharp_extended").handler },
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

local cmp_format = lsp_zero.cmp_format()

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

-- require('lsp_signature').setup({
-- bind = true,
-- handler_opts = {border = 'rounded'},
-- select_signature_key = '<C-k>',
-- })

-- vim.diagnostic
--     .config({virtual_text = false, underline = {severity = vim.diagnostic.severity.ERROR}})

-- Configure diagnostics.
vim.diagnostic.config({
    severity_sort = true,
    signs = true,
    -- virtual_text = {severity = {min = vim.diagnostic.severity.ERROR}, spacing = 8},
    virtual_text = false,
    underline = { severity = vim.diagnostic.severity.WARN },
})

local lspconfig = require("lspconfig")

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "tsserver", "rust_analyzer" },
    handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            lspconfig.lua_ls.setup(lua_opts)
        end,
        tsserver = function()
            lspconfig.tsserver.setup({ javascript = { validate = false } })
        end,
        volar = function()
            lspconfig.volar.setup({
                filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
                init_options = {
                    vue = {
                        hybridMode = false,
                    },
                },
            })
        end,
    },
})

-- local null_ls = require('null-ls')
-- local null_opts = lsp_zero.build_options('null-ls', {})
--
-- null_ls.setup({
--     -- debug = true,
--     on_attach = function(client, bufnr) null_opts.on_attach(client, bufnr) end,
--     sources = {
--         null_ls.builtins.formatting.stylua,
--         null_ls.builtins.diagnostics.eslint,
--         null_ls.builtins.completion.spell,
--     },
-- })
--
-- -- See mason-null-ls.nvim's documentation for more details:
-- -- https://github.com/jay-babu/mason-null-ls.nvim#setup
-- require('mason-null-ls').setup({
--     ensure_installed = nil,
--     automatic_installation = false,
--     automatic_setup = true,
--     handlers = {},
-- })

require("fidget").setup()

require("lsp-toggle").setup()

-- require('symbols-outline').setup()
require("outline").setup()

vim.keymap.set("n", "<leader>vyo", ":Outline<CR>", {})

-- require('lspsaga').setup({symbol_in_winbar = {enable = false}});

require("nvim-navic").setup({ lsp = { auto_attach = true, preference = { "volar" } }, highlight = true })
