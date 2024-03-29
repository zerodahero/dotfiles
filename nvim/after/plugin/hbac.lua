require("hbac").setup({
  autoclose     = true, -- set autoclose to false if you want to close manually
  threshold     = 7, -- hbac will start closing unedited buffers once that number is reached
  close_command = function(bufnr)
    vim.cmd("Bdelete " .. bufnr)
  end,
})
