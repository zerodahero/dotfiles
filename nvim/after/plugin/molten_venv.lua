-- :MoltenVenv / ,jv — start a Molten kernel from the nearest project .venv.
--
-- Bounces cleanly between git worktrees: it walks up from the current file to the
-- first .venv, writes a per-worktree kernelspec pointing at <root>/.venv/bin/python,
-- then MoltenInits it. The kernel name is derived from the worktree dir, so each
-- worktree gets its own kernel and they never clobber each other.
--
-- Requires ipykernel in the .venv:  pip install ipykernel  (or  uv add --dev ipykernel)

local function jupyter_kernel_dir()
    return vim.fn.has("mac") == 1 and vim.fn.expand("~/Library/Jupyter/kernels")
        or vim.fn.expand("~/.local/share/jupyter/kernels")
end

local function molten_init_venv()
    local start = vim.fn.expand("%:p:h")
    if start == "" then start = vim.fn.getcwd() end

    local venv = vim.fs.find(".venv", { upward = true, type = "directory", path = start })[1]
    if not venv then
        vim.notify("MoltenVenv: no .venv found above " .. start, vim.log.levels.ERROR)
        return
    end

    local py = venv .. "/bin/python"
    if vim.fn.executable(py) == 0 then
        vim.notify("MoltenVenv: no python at " .. py, vim.log.levels.ERROR)
        return
    end

    vim.fn.system({ py, "-c", "import ipykernel" })
    if vim.v.shell_error ~= 0 then
        vim.notify(
            "MoltenVenv: ipykernel missing in " .. py .. "\n  pip install ipykernel   (or: uv add --dev ipykernel)",
            vim.log.levels.ERROR
        )
        return
    end

    local root = vim.fs.dirname(venv)
    local name = "venv-" .. vim.fn.fnamemodify(root, ":t")
    local specdir = jupyter_kernel_dir() .. "/" .. name
    vim.fn.mkdir(specdir, "p")

    local spec = {
        argv = { py, "-m", "ipykernel_launcher", "-f", "{connection_file}" },
        display_name = name,
        language = "python",
    }
    local f = assert(io.open(specdir .. "/kernel.json", "w"))
    f:write(vim.json.encode(spec))
    f:close()

    vim.cmd("MoltenInit " .. name)
end

vim.api.nvim_create_user_command("MoltenVenv", molten_init_venv, { desc = "Molten: init kernel from nearest .venv" })
vim.keymap.set("n", "<leader>jv", molten_init_venv, { desc = "Molten: init kernel from .venv" })
