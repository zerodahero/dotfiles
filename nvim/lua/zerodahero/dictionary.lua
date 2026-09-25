-- Tracked word lists for the spell checkers in plugins/lsp.lua.
-- Both live in nvim/dictionaries/, so they ride along with the ~/.config/nvim link.
local M = {}

local dir = vim.fn.stdpath("config") .. "/dictionaries"
M.harper_path = dir .. "/harper.txt"
M.typos_path = dir .. "/typos.toml"

local function read_lines(path)
    if vim.fn.filereadable(path) == 0 then return {} end
    return vim.fn.readfile(path)
end

-- Append `line`, unless `exists(line)` is true for a line already in the file.
local function append_unless(path, line, exists)
    for _, existing in ipairs(read_lines(path)) do
        if exists(existing) then return false end
    end
    vim.fn.writefile({ line }, path, "a")
    return true
end

--- Add a word to both word lists, then restart the attached spell servers.
---@param word string
function M.add_word(word)
    word = vim.trim(word or "")
    if word == "" or word:find("%s") then
        vim.notify("zg: no single word to add", vim.log.levels.WARN)
        return
    end

    -- harper keeps case, so proper nouns like `GitHub` stay exact.
    local harper_added = append_unless(M.harper_path, word, function(l) return l == word end)

    -- typos matches words case-insensitively. `word = "word"` means always valid.
    local lower = word:lower()
    local typos_added = append_unless(
        M.typos_path,
        string.format('%s = "%s"', lower, lower),
        function(l) return vim.startswith(l, lower .. " =") end
    )

    if not (harper_added or typos_added) then
        vim.notify(string.format("zg: %q is already in both lists", word))
        return
    end

    -- Neither server documents a file watch on its dictionary, so restart.
    for _, name in ipairs({ "typos_lsp", "harper_ls" }) do
        if #vim.lsp.get_clients({ bufnr = 0, name = name }) > 0 then vim.cmd("lsp restart " .. name) end
    end

    vim.notify(string.format("zg: added %q to %s", word, harper_added and typos_added and "harper + typos"
        or harper_added and "harper" or "typos"))
end

return M
