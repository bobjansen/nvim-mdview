if vim.g.loaded_mdview then return end
vim.g.loaded_mdview = true

vim.api.nvim_create_user_command("MdViewToggle", function()
  local wo = vim.wo[0][0]
  if wo.conceallevel == 0 then
    wo.conceallevel = (vim.g.mdview or {}).conceallevel or 2
  else
    wo.conceallevel = 0
  end
end, { desc = "Toggle markdown concealment (rendered / raw)" })
