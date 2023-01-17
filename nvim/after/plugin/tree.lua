-- examples for your init.lua

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup({
    actions = {
      open_file = {
        quit_on_open = true
      }
    }
})

-- Keys
vim.keymap.set("n", "<leader>tc", ":NvimTreeCollapse<CR>")
-- vim.keymap.set("n", "<leader>tm", ":NvimTreeFindFile<CR>")
vim.keymap.set('n', '<C-Bslash>', function () 
  if string.find(vim.fn.expand('%'), 'NvimTree_%d') then
    vim.cmd.NvimTreeToggle()
  else
    vim.cmd.NvimTreeFindFile()
  end
end)
