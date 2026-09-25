-- zg: add a word to the harper + typos word lists. Replaces Vim's built-in
-- zg, which only feeds Vim's own `spell`, and that is off in this config.
local dictionary = require("zerodahero.dictionary")

vim.keymap.set("n", "zg", function() dictionary.add_word(vim.fn.expand("<cword>")) end,
    { desc = "Add word to spell dictionaries" })

-- Visual: for words <cword> splits badly, like `don't`.
vim.keymap.set("x", "zg", function()
    local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() })
    vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "nx", false)
    dictionary.add_word(table.concat(lines, " "))
end, { desc = "Add selection to spell dictionaries" })
