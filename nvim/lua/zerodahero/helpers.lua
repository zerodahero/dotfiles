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

-- local function md_to_slack()
--     local a, b = vim.fn.line("v"), vim.fn.line(".")
--     if a > b then
--         a, b = b, a
--     end
--
--     local lines = vim.api.nvim_buf_get_lines(0, a - 1, b, false)
--     local out = vim.fn.systemlist({ "pandoc", "-f", "gfm", "-t", "gfm" }, lines)
--
--     if vim.v.shell_error ~= 0 then
--         vim.notify("pandoc failed: " .. table.concat(out, "\n"), vim.log.levels.ERROR)
--         return
--     end
--
--     vim.fn.setreg("+", table.concat(out, "\n") .. "\n")
--     vim.notify(("Slack-ified %d lines → clipboard"):format(#out))
-- end
--
-- -- [S]lack [T]able
-- vim.keymap.set("x", "<leader>st", md_to_slack, { desc = "Slack-ify markdown table" })

local function md_table_to_tsv()
  local a, b = vim.fn.line("v"), vim.fn.line(".")
  if a > b then a, b = b, a end

  local rows = {}
  for _, line in ipairs(vim.api.nvim_buf_get_lines(0, a - 1, b, false)) do
    -- skip |---|:---:|---| separator and blank lines
    if not line:match("^%s*|?[%s:%-|]+|?%s*$") then
      line = line:gsub("\\|", "\1")                    -- protect escaped pipes
      line = line:gsub("^%s*|", ""):gsub("|%s*$", "")  -- drop outer pipes if present
      local cells = {}
      for cell in (line .. "|"):gmatch("([^|]*)|") do
        table.insert(cells, (cell:gsub("\1", "|"):gsub("^%s+", ""):gsub("%s+$", "")))
      end
      table.insert(rows, table.concat(cells, "\t"))
    end
  end

  vim.fn.setreg("+", table.concat(rows, "\n"))
  vim.notify(("%d rows → clipboard as TSV"):format(#rows))
end

vim.keymap.set("x", "<leader>tsv", md_table_to_tsv, { desc = "Table → TSV for Slack" })
