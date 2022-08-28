local status, saga = pcall(require, "lspsaga")
if not status then
  return
end

saga.init_lsp_saga({
  -- Options with default value
  -- "single" | "double" | "rounded" | "bold" | "plus"
  border_style = "rounded",
  -- when cursor in saga window you config these to move
  move_in_saga = { prev = "<S-Tab>", next = "<Tab>" },
  -- use emoji lightbulb in default
  code_action_icon = "💡",
  -- same as nvim-lightbulb but async
  code_action_lightbulb = {
    enable = false,
  },
  -- finder do lsp request timeout
  -- if your project big enough or your server very slow
  -- you may need to increase this value
  finder_request_timeout = 5000,
  finder_action_keys = {
    open = "<CR>",
    vsplit = "v",
    split = "h",
    tabe = "t",
    quit = "<ESC>",
  },
  code_action_keys = {
    quit = "<ESC>",
    exec = "<CR>",
  },
  rename_action_quit = "<ESC>",
})

-- Shorten function name
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "gj", function()
  require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, opts)
keymap("n", "gk", function()
  require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, opts)
keymap("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
--[[ keymap("n", "gd", "<Cmd>Lspsaga lsp_finder<CR>", opts)  not working now ]]
keymap("i", "<C-k>", "<Cmd>Lspsaga signature_help<CR>", opts)
keymap("n", "gp", "<Cmd>Lspsaga preview_definition<CR>", opts)
keymap("n", "gR", "<Cmd>Lspsaga rename<CR>", opts)
keymap("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- Show line diagnostics
keymap("v", "<leader>la", "<cmd><C-U>Lspsaga range_code_action<CR>", { silent = true })

local action = require("lspsaga.action")
-- scroll in hover doc or  definition preview window
vim.keymap.set("n", "<C-f>", function()
  action.smart_scroll_with_saga(1)
end, { silent = true })
-- scroll in hover doc or  definition preview window
vim.keymap.set("n", "<C-b>", function()
  action.smart_scroll_with_saga(-1)
end, { silent = true })
