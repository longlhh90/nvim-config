local status_ok, gitconflict = pcall(require, "git-conflict")
if not status_ok then
  return
end

gitconflict.setup()

vim.keymap.set("n", "<Tab>", "<Plug>(git-conflict-next-conflict)")
vim.keymap.set("n", "<S-Tab>", "<Plug>(git-conflict-prev-conflict)")
vim.keymap.set("n", "<leader>1", "<Plug>(git-conflict-ours)")   -- Local
vim.keymap.set("n", "<leader>2", "<Plug>(git-conflict-both)")
vim.keymap.set("n", "<leader>3", "<Plug>(git-conflict-theirs)") -- Remote
vim.keymap.set("n", "<leader>0", "<Plug>(git-conflict-none)")
