return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
        -- adapters = {
        --     qwen_coder = function()
        --         return require("codecompanion.adapters").extend("ollama", {
        --             name = "qwen_coder",
        --             schema = {
        --                 model = {
        --                     default = "qwen2.5-coder:7b",
        --                 },
        --             },
        --         })
        --     end,
        --     qwen = function()
        --         return require("codecompanion.adapters").extend("ollama", {
        --             name = "qwen",
        --             schema = {
        --                 model = {
        --                     default = "qwen2.5:7b",
        --                 },
        --             },
        --         })
        --     end,
        -- },
        strategies = {
            chat = {
                adapter = "ollama",
            },
            inline = {
                adapter = "ollama",
            },
            agent = {
                adapter = "ollama",
            },
        },
        prompt_library = {
            ["Proofread"] = {
                strategy = "chat",
                description = "Proofread and correct the message",
                opts = {
                    modes = { "v" },
                    short_name = "proofread",
                    auto_submit = true,
                    user_prompt = false,
                    stop_context_insertion = true,
                    adapter = {
                        name = "ollama",
                        model = "mistral:7b-instruct",
                    },
                },
                prompts = {
                    {
                        role = "system",
                        content = "You are a helpful assistant that proofreads, corrects, and improves message text for communicating with other colleagues. You value clarity and conciseness.",
                    },
                    {
                        role = "user",
                        content = function(context)
                            local text =
                                require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

                            return "Please proofread the following message text and edit for grammar, spelling, punctionation, and clarity. Do not change the meaning of the message. Please offer suggestions for improving the clarity or conciseness of the message.\n\n"
                                .. text
                        end,
                    },
                },
            },
        },
    },
    keys = {
        {
            "<leader>aa",
            "<cmd>CodeCompanionActions<cr>",
            mode = { "n", "v" },
            desc = "CodeCompanion - Prompt actions",
        },
    },
}
