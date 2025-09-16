vim.api.nvim_create_user_command("DisableAIComplete", function()
    if vim.fn.exists(":Copilot") > 0 then vim.cmd("Copilot disable") end
    if vim.fn.exists(":Codeium") > 0 then vim.cmd("CodeiumDisable") end
end, {})

local function wrap_selection(opts, width)
    local start_line = opts.line1
    local end_line = opts.line2

    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
    local text_to_wrap = table.concat(lines, " ")

    local wrapped_lines = {}

    local current_line = ""
    local words = vim.fn.split(text_to_wrap, " ")
    local indent = vim.fn.indent(start_line)

    for _, word in ipairs(words) do
        if current_line == "" then
            current_line = word
        elseif #current_line + #word + 1 <= width then
            current_line = current_line .. " " .. word
        else
            table.insert(wrapped_lines, string.rep(" ", indent) .. current_line)
            current_line = word
        end
    end
    table.insert(wrapped_lines, string.rep(" ", indent) .. current_line)

    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, wrapped_lines)
end

-- Create a user command for convenience
vim.api.nvim_create_user_command("WrapString", function(opts)
    local width = tonumber(opts.fargs[1]) or 80
    wrap_selection(opts, width)
end, {
    range = true,
    nargs = 1,
    desc = "Wrap selected line(s)",
})

vim.keymap.set("v", "<leader>ws", ":WrapString 80<cr>", { noremap = true, silent = true })
