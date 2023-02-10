vim.api.nvim_create_autocmd('FileType', {
    pattern = {"just"},
    callback = function() vim.opt_local.commentstring = "# %s" end
})
