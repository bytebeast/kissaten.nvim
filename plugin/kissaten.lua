if vim.g.loaded_kissaten then
  return
end
vim.g.loaded_kissaten = true

-- :Kissaten [morning|afternoon|evening|midnight|graveyard|info]
vim.api.nvim_create_user_command("Kissaten", function(args)
  local arg = args.args
  if arg == "" then
    vim.cmd.colorscheme("kissaten")
  elseif arg == "info" then
    vim.cmd("checkhealth kissaten")
  elseif vim.tbl_contains(require("kissaten.config").styles, arg) then
    vim.cmd.colorscheme("kissaten-" .. arg)
  else
    vim.notify("kissaten: unknown argument '" .. arg .. "'", vim.log.levels.WARN)
  end
end, {
  nargs = "?",
  desc = "Switch kissaten style or show info",
  complete = function(lead)
    local items = vim.list_extend(vim.deepcopy(require("kissaten.config").styles), { "info" })
    return vim.tbl_filter(function(i)
      return i:find("^" .. vim.pesc(lead))
    end, items)
  end,
})
