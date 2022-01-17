local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap ; as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Tonggle NvimTree
keymap("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<S-q>", ":Bdelete!<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- ToggleTerm
local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({cmd = "lazygit",direction = "float", size=30, hidden = true})

_toggle_lazygit = function ()
  lazygit:toggle()
end

keymap("n", "<leader>tl", "<cmd>lua _toggle_lazygit()<cr>", opts)


-- Telescope
keymap("n", "<leader>f", "<cmd>Telescope find_files<cr>", opts)
--keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false}))<cr>", opts)
keymap("n", "<leader>r", "<cmd>Telescope live_grep<cr>", opts)

-- DAP
keymap("n", "<leader>dt", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader><leader>", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>ds", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>dq", "<cmd>lua require'dap'.close()<cr>", opts)
keymap("n", "<leader>dv", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.close() require'dap'.continue()<cr>", opts)

--b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
--C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
--d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
--g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
--p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
--r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },

-- Others
keymap("n", "<leader>h", "<cmd>nohlsearch<cr>", opts)

