require('mini.cursorword').setup()
require('mini.trailspace').setup()
require('mini.splitjoin').setup()
require('mini.misc').setup({})

-- FUTURE: this is wonky with nvim-tree
-- local starter = require('mini.starter')
-- starter.setup({
--     evaluate_single = true,
--     items = {
--         starter.sections.builtin_actions(),
--         starter.sections.recent_files(10, true),
--     },
-- })
