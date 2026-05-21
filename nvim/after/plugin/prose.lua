local proseGroup = vim.api.nvim_create_augroup('prose', { clear = true })

local function prose_enable(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()

    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.list = false
    vim.opt_local.breakindent = true
    vim.opt_local.textwidth = 0
    vim.opt_local.wrapmargin = 0

    local opts = { buffer = bufnr, silent = true }

    vim.keymap.set({ 'n', 'x' }, 'j', 'gj', opts)
    vim.keymap.set({ 'n', 'x' }, 'k', 'gk', opts)
    vim.keymap.set({ 'n', 'x' }, '0', 'g0', opts)
    vim.keymap.set({ 'n', 'x' }, '$', 'g$', opts)
    vim.keymap.set({ 'n', 'x' }, '<Home>', 'g<Home>', opts)
    vim.keymap.set({ 'n', 'x' }, '<End>', 'g<End>', opts)

    vim.keymap.set('i', '<Up>', '<C-o>g<Up>', opts)
    vim.keymap.set('i', '<Down>', '<C-o>g<Down>', opts)
    vim.keymap.set('i', '<Home>', '<C-o>g<Home>', opts)
    -- End: move to end of visual line. If that lands on the last char of the
    -- buffer line (i.e. final visual line of a soft-wrapped block), advance
    -- past EOL so the cursor sits visually past the last char. On intermediate
    -- visual lines, advancing would render the cursor at the start of the
    -- next visual line, so we stop on the last visible char instead.
    vim.keymap.set('i', '<End>', function()
        if vim.fn.pumvisible() == 1 then
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<End>', true, false, true), 'n', false)
            return
        end
        vim.cmd('normal! g$')
        local row = vim.fn.line('.')
        local line = vim.fn.getline(row)
        if vim.fn.col('.') >= #line then
            vim.fn.cursor(row, #line + 1)
        end
    end, opts)

    vim.b[bufnr].prose_enabled = true
end

local function prose_disable(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()

    vim.opt_local.wrap = false
    vim.opt_local.linebreak = false
    vim.opt_local.breakindent = false

    for _, key in ipairs({ 'j', 'k', '0', '$', '<Home>', '<End>' }) do
        pcall(vim.keymap.del, { 'n', 'x' }, key, { buffer = bufnr })
    end
    for _, key in ipairs({ '<Up>', '<Down>', '<Home>', '<End>' }) do
        pcall(vim.keymap.del, 'i', key, { buffer = bufnr })
    end

    vim.b[bufnr].prose_enabled = false
end

local function prose_toggle()
    if vim.b.prose_enabled then
        prose_disable()
    else
        prose_enable()
    end
end

vim.api.nvim_create_user_command('ProseToggle', prose_toggle, {})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'markdown', 'text', 'tex' },
    group = proseGroup,
    callback = function(args)
        prose_enable(args.buf)
    end,
})
