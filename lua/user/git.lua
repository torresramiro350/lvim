local M = {}
M.config = function()
  vim.g.gitblame_enabled = 1
  -- vim.g.gitblame_message_template = "<summary> • <date> • <author>"
  vim.g.gitblame_message_template = "<date> • <author>"
  vim.g.gitblame_highlight_group = "LineNr"
  vim.g.gitblame_message_when_not_committed = 'Oh please, commit this !'
end

return M
