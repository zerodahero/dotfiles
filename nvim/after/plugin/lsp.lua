require('neodev').setup({library = {plugins = {'nvim-dap-ui'}, types = true}})

local lsp = require('lsp-zero')
lsp.preset('recommended')

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({select = true}),
    ['<C-Space>'] = cmp.mapping.complete(),
})
-- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
-- cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

-- disable completion with tab
-- this helps with copilot setup
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil
cmp_mappings['<CR>'] = nil

local cmp_sources = lsp.defaults.cmp_sources()
table.insert(cmp_sources, {name = 'nvim_lsp_signature_help'})

lsp.setup_nvim_cmp({mapping = cmp_mappings, sources = cmp_sources})

lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}

    if client.name == 'eslint' then
        vim.cmd.LspStop('eslint')
        return
    end

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts)
    vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)

    require'lsp_signature'.on_attach({
        bind = true,
        handler_opts = {border = 'rounded'},
    }, bufnr)
end)

lsp.configure('omnisharp', {
    handlers = {
        ['textDocument/definition'] = require('omnisharp_extended').handler,
    },
})

lsp.nvim_workspace();

lsp.setup()

vim.diagnostic.config({
    virtual_text = false,
    underline = {severity = vim.diagnostic.severity.ERROR},
})

local null_ls = require('null-ls')
local null_opts = lsp.build_options('null-ls', {})

null_ls.setup({
    on_attach = function(client, bufnr) null_opts.on_attach(client, bufnr) end,
    sources = {
        -- You can add tools not supported by mason.nvim
    },
})

-- See mason-null-ls.nvim's documentation for more details:
-- https://github.com/jay-babu/mason-null-ls.nvim#setup
require('mason-null-ls').setup({
    ensure_installed = nil,
    automatic_installation = true,
    automatic_setup = true,
})

-- Required when `automatic_setup` is true
require('mason-null-ls').setup_handlers({})

require('fidget').setup()

require('lsp-toggle').setup();
