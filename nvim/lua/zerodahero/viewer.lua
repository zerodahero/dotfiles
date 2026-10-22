-- lua/zerodahero/viewer.lua
-- Open a file in an external TUI viewer, picked by file extension.
local M = {}

-- Extension -> command. The path is appended as the last argument.
M.viewers = {
  md = { "glow", "-p" },
  markdown = { "glow", "-p" },
  pdf = { "tdf" },
}

-- Extension -> command used outside kitty. nvim's :terminal cannot show
-- kitty graphics, so image-based viewers need a GUI app here instead.
M.fallbacks = {
  pdf = { "open" },
}

-- Used when no extension matches. VisiData opens most tabular formats.
M.default = { "vd" }

local function float_term(cmd)
  local buf = vim.api.nvim_create_buf(false, true)
  local w, h = math.floor(vim.o.columns * 0.95), math.floor(vim.o.lines * 0.9)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor", width = w, height = h,
    row = math.floor((vim.o.lines - h) / 2), col = math.floor((vim.o.columns - w) / 2),
    border = "rounded", style = "minimal",
  })
  vim.fn.jobstart(cmd, {
    term = true,
    on_exit = function()
      vim.schedule(function()
        if vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_close(win, true) end
        pcall(vim.api.nvim_buf_delete, buf, { force = true })
      end)
    end,
  })
  vim.cmd.startinsert()
end

function M.open(path)
  path = path or vim.api.nvim_buf_get_name(0)
  if path == "" then return end

  local ext = vim.fn.fnamemodify(path, ":e"):lower()
  local cmd = vim.list_extend(vim.deepcopy(M.viewers[ext] or M.default), { path })

  local function fallback()
    if M.fallbacks[ext] then
      vim.fn.jobstart(vim.list_extend(vim.deepcopy(M.fallbacks[ext]), { path }), { detach = true })
    else
      float_term(cmd)
    end
  end

  if vim.env.KITTY_LISTEN_ON then
    vim.fn.jobstart(vim.list_extend({
      "kitty", "@", "--to", vim.env.KITTY_LISTEN_ON,
      "launch", "--type=overlay", "--cwd=current", "--title", cmd[1],
    }, cmd), {
      on_exit = function(_, code)
        if code ~= 0 then vim.schedule(fallback) end
      end,
    })
  else
    fallback()
  end
end

return M
