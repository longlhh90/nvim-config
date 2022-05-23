local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local dap = require("dap")

local colors = {
	bg = "#1F1F28",
	fg = "#DCD7BA",
	yellow = "#ECBE7B",
	cyan = "#008080",
	darkblue = "#081633",
	green = "#98be65",
	orange = "#FF8800",
	violet = "#a9a1e1",
	magenta = "#c678dd",
	purple = "#c678dd",
	blue = "#51afef",
	red = "#C34043",
	sakura_pink = "#D27E99",
	wave_red = "#E46876",
	surimi_orange = "#FFA066",
	ronin_yellow = "#FF9E3B",
}

local function diff_source()
	local gitsigns = vim.b.gitsigns_status_dict
	if gitsigns then
		return {
			added = gitsigns.added,
			modified = gitsigns.changed,
			removed = gitsigns.removed,
		}
	end
end

local function env_cleanup(venv)
	if string.find(venv, "/") then
		local final_venv = venv
		for w in venv:gmatch("([^/]+)") do
			final_venv = w
		end
		venv = final_venv
	end
	return venv
end

local mode_icons = {
	c = "🅒 ",
	i = "🅘 ",
	n = "🅝 ",
	r = "🅡 ",
	s = "🅢 ",
	t = "🅣 ",
	v = "🅥 ",
}
--bullet = "•"

local debug = {
	function()
		if dap.status() ~= "" then
			return " "
		end
		return ""
	end,
	color = { fg = colors.ronin_yellow },
	cond = nil,
}

local mode = {
	function()
		local prefix = ""
		if vim.loop.os_uname().sysname == "Linux" then
			prefix = "  "
		elseif vim.loop.os_uname().sysname == "Darwin" then
			prefix = "  "
		else
			prefix = "  "
		end

		if mode_icons[vim.fn.mode()] ~= nil then
			return prefix .. " • " .. mode_icons[vim.fn.mode()] .. " "
		else
			return prefix .. " "
		end
	end,
	padding = { left = 0, right = 0 },
	color = {},
	cond = nil,
}

local branch = {
	function()
		return vim.b.gitsigns_head:sub(0,20)
	end,
	icon = " ",
	color = { gui = "bold", fg = colors.wave_red },
	cond = hide_in_width,
}

local filename = {
	"filename",
	icon = " פּ",
	color = {},
	cond = nil,
}

local diff = {
	"diff",
	source = diff_source,
	symbols = { added = "  ", modified = "柳", removed = " " },
	diff_color = {
		added = { fg = colors.green },
		modified = { fg = colors.yellow },
		removed = { fg = colors.red },
	},
	color = {},
	cond = nil,
}

local python_env = {
	function()
		if vim.bo.filetype == "python" then
			local venv = os.getenv("CONDA_DEFAULT_ENV")
			if venv then
				return string.format("  (%s)", env_cleanup(venv))
			end
			venv = os.getenv("VIRTUAL_ENV")
			if venv then
				return string.format("  (%s)", env_cleanup(venv))
			end
			return ""
		end
		return ""
	end,
	color = { fg = colors.green },
	cond = hide_in_width,
}

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	symbols = { error = " ", warn = " ", info = " ", hint = " " },
	color = {},
	cond = hide_in_width,
}

local treesitter = {
	function()
		local b = vim.api.nvim_get_current_buf()
		if next(vim.treesitter.highlighter.active[b]) then
			return " "
		end
		return ""
	end,
	color = { fg = colors.orange },
	cond = hide_in_width,
}

local lsp = {
	function(msg)
		msg = msg or "LS Inactive"
		local buf_clients = vim.lsp.buf_get_clients()
		if next(buf_clients) == nil then
			-- TODO: clean up this if statement
			if type(msg) == "boolean" or #msg == 0 then
				return "LS Inactive"
			end
			return msg
		end
		local buf_ft = vim.bo.filetype
		local buf_client_names = {}

		-- add client
		for _, client in pairs(buf_clients) do
			if client.name ~= "null-ls" then
				table.insert(buf_client_names, client.name)
			end
		end

		-- add formatter
		-- local formatters = require "lvim.lsp.null-ls.formatters"
		-- local supported_formatters = formatters.list_registered_providers(buf_ft)
		-- vim.list_extend(buf_client_names, supported_formatters)

		-- add linter
		-- local linters = require "lvim.lsp.null-ls.linters"
		-- local supported_linters = linters.list_registered_providers(buf_ft)
		-- vim.list_extend(buf_client_names, supported_linters)

		return "[" .. table.concat(buf_client_names, ", ") .. "]"
	end,
	--icon = " ",
	color = { gui = "bold" },
	cond = hide_in_width,
}

local location = { "location", cond = hide_in_width, color = {}, padding = { left = 0, right = 0 } }

local progress = { "progress", cond = hide_in_width, color = {} }

local spaces = {
	function()
		if not vim.api.nvim_buf_get_option(0, "expandtab") then
			return "Tab size: " .. vim.api.nvim_buf_get_option(0, "tabstop") .. " "
		end
		local size = vim.api.nvim_buf_get_option(0, "shiftwidth")
		if size == 0 then
			size = vim.api.nvim_buf_get_option(0, "tabstop")
		end
		return "Spaces: " .. size .. " "
	end,
	cond = hide_in_width,
	color = {},
}

local encoding = {
	"o:encoding",
	fmt = string.upper,
	color = {},
	cond = hide_in_width,
}

local filetype = { "filetype", cond = hide_in_width, color = {} }

local scrollbar = {
	function()
		local current_line = vim.fn.line(".")
		local total_lines = vim.fn.line("$")
		local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
		local line_ratio = current_line / total_lines
		local index = math.ceil(line_ratio * #chars)
		return chars[index]
	end,
	padding = { left = 0, right = 0 },
	color = { fg = colors.yellow, bg = colors.bg },
	cond = nil,
}

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "•", right = "•" },
		-- component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline", "toggleterm" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = {
			mode,
		},
		lualine_b = {
			debug,
			branch,
			filename,
		},
		lualine_c = {
			diff,
			python_env,
		},
		lualine_x = {
			diagnostics,
			treesitter,
		},
		lualine_y = {
			lsp,
			filetype,
			encoding,
		},
		lualine_z = {
			location,
			scrollbar,
		},
	},
	inactive_sections = {
		lualine_a = {
			"filename",
		},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = { "nvim-tree" },
})
