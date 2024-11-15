vim.api.nvim_create_user_command("DisableAIComplete", function()
    if vim.fn.exists(':Copilot') > 0 then vim.cmd("Copilot disable") end
    if vim.fn.exists(':Codeium') > 0 then vim.cmd("CodeiumDisable") end
end, {})
