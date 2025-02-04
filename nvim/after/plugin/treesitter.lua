vim.keymap.set("n", "<leader>cc", ":TSContextToggle<CR>")
vim.keymap.set("n", "<leader>jc", function()
  require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })
vim.cmd('hi TreesitterContextBottom gui=underline guisp=Grey')
vim.cmd('hi TreesitterContextLineNumberBottom gui=underline guisp=Grey')
