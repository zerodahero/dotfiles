-- return {
--     "David-Kunz/gen.nvim",
--     opts = {
--         -- model = "qwen2.5-coder:14b", -- The default model to use.
--     },
--     cmd = "Gen",
--     keys = {
--         { "<leader><leader>g", ":Gen<CR>", mode = { "n", "v" }, desc = "Gen AI" },
--     },
-- }
return {
    "robitx/gp.nvim",
    config = function()
        local conf = {
            -- For customization, refer to Install > Configuration in the Documentation/Readme
            providers = {
                copilot = {
                    endpoint = "https://api.githubcopilot.com/chat/completions",
                    secret = {
                        "bash",
                        "-c",
                        "cat ~/.config/github-copilot/hosts.json | sed -e 's/.*oauth_token...//;s/\".*//'",
                    },
                },
                ollama = {
                    endpoint = "http://localhost:11434/v1/chat/completions",
                },
            },
            whisper = { disable = true },
            agents = {
                {
                    name = "Qwen2.5:32b",
                    chat = true,
                    command = true,
                    provider = "ollama",
                    model = { model = "qwen2.5:32b" },
                    system_prompt = "I am an AI meticulously crafted to provide programming guidance and code assistance. "
                        .. "To best serve you as a computer programmer, please provide detailed inquiries and code snippets when necessary, "
                        .. "and expect precise, technical responses tailored to your development needs.\n",
                },
                {
                    name = "Codellama",
                    chat = true,
                    command = true,
                    provider = "ollama",
                    model = { model = "codellama" },
                    system_prompt = "I am an AI meticulously crafted to provide programming guidance and code assistance. "
                        .. "To best serve you as a computer programmer, please provide detailed inquiries and code snippets when necessary, "
                        .. "and expect precise, technical responses tailored to your development needs.\n",
                },
            },
        }
        require("gp").setup(conf)

        -- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
    end,
}
