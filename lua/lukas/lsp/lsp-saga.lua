local status, saga = pcall(require, "lspsaga")
if not status then
  return
end

saga.setup({
  -- Options with default value
  -- "single" | "double" | "rounded" | "bold" | "plus"
  border_style = "rounded",
  -- when cursor in saga window you config these to move
  move_in_saga = { prev = "<S-Tab>", next = "<Tab>" },
  -- use emoji lightbulb in default
  code_action_icon = "💡",
  -- same as nvim-lightbulb but async
  lightbulb = {
    enable = false,
    enable_in_insert = true,
    sign = true,
    sign_priority = 40,
    virtual_text = true,
  },
  -- finder do lsp request timeout
  -- if your project big enough or your server very slow
  -- you may need to increase this value
  request_timeout = 5000,

  finder = {
    max_height = 0.5,
    min_width = 30,
    force_max_height = false,
    keys = {
      jump_to = 'p',
      expand_or_jump = '<CR>',
      vsplit = 'v',
      split = 'h',
      tabe = 't',
      tabnew = 'r',
      quit = { '<ESC>' },
      close_in_preview = '<ESC>',
    },
  },

  code_action = {
    num_shortcut = true,
    show_server_name = false,
    extend_gitsigns = true,
    keys = {
      -- string | table type
      quit = "<ESC>",
      exec = "<CR>",
    },
  },

  rename = {
    quit = "<ESC>",
    exec = "<CR>",
    mark = "x",
    confirm = "<CR>",
    in_select = true,
  },

  outline = {
    win_position = "right",
    win_with = "",
    win_width = 30,
    preview_width = 0.4,
    show_detail = true,
    auto_preview = true,
    auto_refresh = true,
    auto_close = true,
    custom_sort = nil,
    keys = {
      expand_or_jump = '<CR>',
      quit = "<ESC>",
    },
  },
})

-- Shorten function name
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "gp", "<Cmd>Lspsaga lsp_finder<CR>", opts)
keymap("n", "gr", "<Cmd>Lspsaga rename<CR>", opts)
keymap("v", "<leader>la", "<cmd><C-U>Lspsaga range_code_action<CR>", { silent = true })
keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { silent = true })
