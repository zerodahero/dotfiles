-- local animate = require('mini.animate')
-- require('mini.animate').setup({
--     cursor = {
--         timing = animate.gen_timing.linear({duration = 25, unit = 'total'}),
--     },
--     scroll = {
--         timing = animate.gen_timing.linear({duration = 25, unit = 'total'}),
--     },
--     resize = {enable = false},
--     open = {enable = false},
--     close = {enable = false},
-- })
require('mini.pairs').setup()
require('mini.comment').setup()
require('mini.cursorword').setup()
-- require('mini.indentscope').setup({
--     draw = {animation = require('mini.indentscope').gen_animation.none(), priority = 1},
-- })
require('mini.trailspace').setup()
